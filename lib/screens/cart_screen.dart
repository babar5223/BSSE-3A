import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';
import '../widgets/app_drawer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<CartItem> _cartItems = [
    CartItem(
      product: mockProducts[0],
      selectedSize: 'L',
      selectedColor: 'White',
      quantity: 2,
    ),
    CartItem(
      product: mockProducts[3],
      selectedSize: 'XL',
      selectedColor: 'Black',
      quantity: 1,
    ),
    CartItem(
      product: mockProducts[4],
      selectedSize: 'M',
      selectedColor: 'White',
      quantity: 3,
    ),
  ];

  final _couponController = TextEditingController();
  double _discount = 0;
  String _couponStatus = '';
  int _trackingStep = 2;

  static const _validCoupons = {
    'WELCOME10': 0.10,
    'BULK20': 0.20,
    'BI15': 0.15,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _couponController.dispose();
    super.dispose();
  }

  double get _subtotal =>
      _cartItems.fold(0, (sum, item) => sum + item.total);
  double get _discountAmount => _subtotal * _discount;
  double get _shipping => _subtotal > 5000 ? 0 : 250;
  double get _total => _subtotal - _discountAmount + _shipping;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: isDark ? kGold : kDeepBlue,
          labelColor: isDark ? kGold : kDeepBlue,
          unselectedLabelColor:
              isDark ? kSubtextLight : kSubtextDark,
          tabs: const [
            Tab(text: 'Cart', icon: Icon(Icons.shopping_cart_outlined)),
            Tab(text: 'Checkout', icon: Icon(Icons.payment_outlined)),
            Tab(text: 'Tracking', icon: Icon(Icons.local_shipping_outlined)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCartTab(context, isDark),
          _buildCheckoutTab(context, isDark),
          _buildTrackingTab(context, isDark),
        ],
      ),
    );
  }

  // ── Cart Tab ──

  Widget _buildCartTab(BuildContext context, bool isDark) {
    if (_cartItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined,
                size: 64,
                color: isDark ? kSubtextLight : kSubtextDark),
            const SizedBox(height: 16),
            Text('Your cart is empty',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Browse Products',
              onPressed: () => Navigator.pushNamed(context, '/products'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _cartItems.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) => _buildCartItem(context, isDark, i),
          ),
        ),
        _buildOrderSummary(context, isDark),
      ],
    );
  }

  Widget _buildCartItem(BuildContext context, bool isDark, int index) {
    final item = _cartItems[index];
    final theme = Theme.of(context);
    final accent = isDark ? kGold : kDeepBlue;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? kDarkCard : kLightCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ImagePlaceholder(
              height: 80,
              width: 80,
              icon: Icons.checkroom_outlined,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name,
                    style: theme.textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text('${item.selectedSize} · ${item.selectedColor}',
                    style: theme.textTheme.bodySmall),
                const SizedBox(height: 6),
                Text(
                  'PKR ${item.product.price.toStringAsFixed(0)}',
                  style: TextStyle(
                      color: accent, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red, size: 20),
                onPressed: () => setState(() => _cartItems.removeAt(index)),
              ),
              Row(
                children: [
                  _smallButton(Icons.remove, () {
                    if (item.quantity > 1) {
                      setState(() => item.quantity--);
                    }
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('${item.quantity}',
                        style: theme.textTheme.titleMedium),
                  ),
                  _smallButton(Icons.add, () => setState(() => item.quantity++)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallButton(IconData icon, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          border: Border.all(color: isDark ? kGold : kDeepBlue),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 14, color: isDark ? kGold : kDeepBlue),
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    final accent = isDark ? kGold : kDeepBlue;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? kDarkSurface : kLightCard,
        border: Border(top: BorderSide(color: accent.withOpacity(0.1))),
      ),
      child: Column(
        children: [
          // Coupon
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _couponController,
                  decoration: InputDecoration(
                    hintText: 'Coupon code (e.g. WELCOME10)',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _applyCoupon,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                ),
                child: const Text('Apply'),
              ),
            ],
          ),
          if (_couponStatus.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              _couponStatus,
              style: TextStyle(
                color: _discount > 0 ? Colors.green : Colors.red,
                fontSize: 12,
              ),
            ),
          ],
          const SizedBox(height: 12),
          _summaryRow(theme, 'Subtotal',
              'PKR ${_subtotal.toStringAsFixed(0)}'),
          if (_discount > 0)
            _summaryRow(theme, 'Discount (${(_discount * 100).round()}%)',
                '-PKR ${_discountAmount.toStringAsFixed(0)}',
                color: Colors.green),
          _summaryRow(theme, 'Shipping',
              _shipping == 0 ? 'FREE' : 'PKR ${_shipping.toStringAsFixed(0)}',
              color: _shipping == 0 ? Colors.green : null),
          const Divider(),
          _summaryRow(
            theme,
            'Total',
            'PKR ${_total.toStringAsFixed(0)}',
            bold: true,
            color: accent,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _tabController.animateTo(1),
              child: const Text('Proceed to Checkout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(ThemeData theme, String label, String value,
      {bool bold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
              fontSize: bold ? 16 : 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _applyCoupon() {
    final code = _couponController.text.trim().toUpperCase();
    if (_validCoupons.containsKey(code)) {
      setState(() {
        _discount = _validCoupons[code]!;
        _couponStatus =
            '✅ Coupon applied! ${(_discount * 100).round()}% discount';
      });
    } else {
      setState(() {
        _discount = 0;
        _couponStatus = '❌ Invalid coupon code';
      });
    }
  }

  // ── Checkout Tab ──

  Widget _buildCheckoutTab(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    final accent = isDark ? kGold : kDeepBlue;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shipping Information', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 16),
          _checkoutField('Full Name'),
          const SizedBox(height: 12),
          _checkoutField('Email Address'),
          const SizedBox(height: 12),
          _checkoutField('Phone Number'),
          const SizedBox(height: 12),
          _checkoutField('Street Address'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _checkoutField('City')),
              const SizedBox(width: 12),
              Expanded(child: _checkoutField('Postal Code')),
            ],
          ),
          const SizedBox(height: 12),
          _checkoutField('Country'),
          const SizedBox(height: 24),
          Text('Payment Method', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 12),
          ..._buildPaymentMethods(isDark, accent, theme),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? kDarkCard : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                _summaryRow(theme, 'Order Total',
                    'PKR ${_total.toStringAsFixed(0)}',
                    bold: true, color: accent),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Order Placed! 🎉'),
                    content: const Text(
                        'Your order has been placed successfully. You will receive a confirmation email shortly.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _tabController.animateTo(2);
                        },
                        child: const Text('Track Order'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.lock_outlined),
              label: const Text('Place Order Securely',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkoutField(String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
    );
  }

  List<Widget> _buildPaymentMethods(
      bool isDark, Color accent, ThemeData theme) {
    final methods = [
      {'icon': '💳', 'name': 'Credit / Debit Card', 'desc': 'Visa, Mastercard, Amex'},
      {'icon': '📱', 'name': 'JazzCash / EasyPaisa', 'desc': 'Mobile wallet payment'},
      {'icon': '🏦', 'name': 'Bank Transfer', 'desc': 'Direct bank account transfer'},
      {'icon': '💰', 'name': 'Cash on Delivery', 'desc': 'Pay when you receive'},
    ];

    return methods
        .map((m) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? kDarkCard : kLightCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: accent.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Text(m['icon']!, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m['name']!, style: theme.textTheme.titleMedium),
                        Text(m['desc']!, style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  Radio<String>(
                    value: m['name']!,
                    groupValue: methods.first['name'],
                    onChanged: (_) {},
                    activeColor: accent,
                  ),
                ],
              ),
            ))
        .toList();
  }

  // ── Tracking Tab ──

  Widget _buildTrackingTab(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    final accent = isDark ? kGold : kDeepBlue;

    final steps = [
      {'label': 'Order Placed', 'icon': Icons.receipt_outlined},
      {'label': 'Processing', 'icon': Icons.settings_outlined},
      {'label': 'Shipped', 'icon': Icons.local_shipping_outlined},
      {'label': 'Out for Delivery', 'icon': Icons.delivery_dining_outlined},
      {'label': 'Delivered', 'icon': Icons.check_circle_outline},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Order Tracking', style: theme.textTheme.displaySmall),
          const SizedBox(height: 8),
          Text('Order #BI-2024-78432',
              style: theme.textTheme.bodyLarge?.copyWith(
                  color: accent, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('In Transit',
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                    fontSize: 12)),
          ),
          const SizedBox(height: 32),
          // Stepper
          ...steps.asMap().entries.map((entry) {
            final i = entry.key;
            final step = entry.value;
            final isDone = i <= _trackingStep;
            final isCurrent = i == _trackingStep;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isDone ? accent : (isDark ? kDarkCard : const Color(0xFFEEEEEE)),
                        shape: BoxShape.circle,
                        border: isCurrent
                            ? Border.all(color: accent, width: 3)
                            : null,
                      ),
                      child: Icon(
                        step['icon'] as IconData,
                        color: isDone
                            ? (isDark ? Colors.black : Colors.white)
                            : Colors.grey,
                        size: 20,
                      ),
                    ),
                    if (i < steps.length - 1)
                      Container(
                        width: 2,
                        height: 40,
                        color: i < _trackingStep
                            ? accent
                            : (isDark ? kDarkCard : const Color(0xFFEEEEEE)),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['label'] as String,
                          style: TextStyle(
                            fontWeight: isCurrent ? FontWeight.w700 : FontWeight.normal,
                            color: isDone
                                ? (isDark ? kTextLight : kTextDark)
                                : (isDark ? kSubtextLight : kSubtextDark),
                          ),
                        ),
                        if (isCurrent)
                          Text('Estimated: Today, 3:00 - 6:00 PM',
                              style: TextStyle(
                                  color: accent, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? kDarkCard : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.local_shipping_outlined, size: 20),
                    const SizedBox(width: 8),
                    Text('Delivery Partner: TCS Express',
                        style: theme.textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: 8),
                _summaryRow(theme, 'Tracking #', 'TCS-PK-293847'),
                _summaryRow(theme, 'Shipped On', 'May 5, 2024'),
                _summaryRow(theme, 'Expected Delivery', 'May 8, 2024'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
