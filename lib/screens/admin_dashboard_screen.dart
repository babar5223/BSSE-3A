import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/app_drawer.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.account_circle_outlined), onPressed: () {}),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Overview', icon: Icon(Icons.dashboard_outlined)),
            Tab(text: 'Products', icon: Icon(Icons.checkroom_outlined)),
            Tab(text: 'Orders', icon: Icon(Icons.receipt_long_outlined)),
            Tab(text: 'Customers', icon: Icon(Icons.people_outline)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverview(context, isDark),
          _buildProductsTab(context, isDark),
          _buildOrdersTab(context, isDark),
          _buildCustomersTab(context, isDark),
        ],
      ),
    );
  }

  Widget _buildOverview(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    final accent = isDark ? kGold : kDeepBlue;
    final isWide = MediaQuery.of(context).size.width >= 768;

    final kpis = [
      {'icon': '💰', 'title': 'Total Revenue', 'value': 'PKR 2.4M', 'change': '+18%', 'up': true},
      {'icon': '📦', 'title': 'Total Orders', 'value': '1,234', 'change': '+12%', 'up': true},
      {'icon': '👥', 'title': 'Total Customers', 'value': '498', 'change': '+8%', 'up': true},
      {'icon': '👕', 'title': 'Products Listed', 'value': '376', 'change': '+5%', 'up': true},
      {'icon': '⚠️', 'title': 'Low Stock Items', 'value': '12', 'change': '+3', 'up': false},
      {'icon': '🔄', 'title': 'Pending Orders', 'value': '47', 'change': '-2%', 'up': false},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dashboard Overview', style: theme.textTheme.headlineLarge),
          Text('Welcome back! Here\'s what\'s happening.',
              style: theme.textTheme.bodyMedium),
          const SizedBox(height: 20),

          // KPI Cards
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isWide ? 3 : 2,
              childAspectRatio: isWide ? 1.6 : 1.4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: kpis.length,
            itemBuilder: (_, i) {
              final kpi = kpis[i];
              final isUp = kpi['up'] as bool;
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? kDarkCard : kLightCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: accent.withOpacity(0.1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(kpi['icon'] as String,
                            style: const TextStyle(fontSize: 24)),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: (isUp ? Colors.green : Colors.red)
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isUp ? Icons.trending_up : Icons.trending_down,
                                size: 12,
                                color: isUp ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                kpi['change'] as String,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isUp ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(kpi['value'] as String,
                            style: TextStyle(
                              color: accent,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            )),
                        Text(kpi['title'] as String,
                            style: theme.textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Analytics Chart Placeholder
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: isDark ? kDarkCard : kLightCard,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: accent.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Revenue Analytics',
                          style: theme.textTheme.headlineSmall),
                      Text('Last 7 days',
                          style: theme.textTheme.bodySmall?.copyWith(
                              color: accent)),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomPaint(
                      painter: _SimpleBarChartPainter(
                        values: [45, 72, 58, 88, 62, 94, 78],
                        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                        barColor: accent,
                        isDark: isDark,
                      ),
                      size: const Size(double.infinity, 150),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Recent Orders
          Text('Recent Orders', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 12),
          _buildRecentOrdersTable(context, isDark, theme, accent),
        ],
      ),
    );
  }

  Widget _buildRecentOrdersTable(
      BuildContext context, bool isDark, ThemeData theme, Color accent) {
    final orders = [
      {'id': '#BI-1234', 'customer': 'Ahmed Khan', 'items': 3, 'total': 'PKR 8,200', 'status': 'Delivered'},
      {'id': '#BI-1235', 'customer': 'Sarah M.', 'items': 1, 'total': 'PKR 3,500', 'status': 'Processing'},
      {'id': '#BI-1236', 'customer': 'UK Fashion Ltd', 'items': 150, 'total': 'PKR 420,000', 'status': 'Shipped'},
      {'id': '#BI-1237', 'customer': 'Gulf Textile Co.', 'items': 500, 'total': 'PKR 1.2M', 'status': 'Pending'},
    ];

    final statusColors = {
      'Delivered': Colors.green,
      'Processing': Colors.orange,
      'Shipped': Colors.blue,
      'Pending': Colors.red,
    };

    return Column(
      children: orders.map((order) {
        final statusColor = statusColors[order['status']] ?? Colors.grey;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? kDarkCard : kLightCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: accent.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order['id'] as String,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    Text(order['customer'] as String,
                        style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Expanded(
                child: Text('${order['items']} items',
                    style: theme.textTheme.bodyMedium),
              ),
              Expanded(
                child: Text(order['total'] as String,
                    style: TextStyle(
                        color: accent, fontWeight: FontWeight.w700, fontSize: 13)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(order['status'] as String,
                    style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProductsTab(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    final accent = isDark ? kGold : kDeepBlue;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Product'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 8,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final names = [
                'Classic Oxford Shirt', 'Elite Polo Shirt', 'Premium Floral Kurta',
                'Pro Training Hoodie', 'Graphic Print Tee', 'Slim Fit Denim Jeans',
                'Corporate Uniform Set', 'Export Track Suit',
              ];
              final stocks = [145, 78, 32, 0, 234, 56, 12, 89];
              final prices = [2499, 1899, 3200, 3500, 1200, 4200, 8500, 5800];
              final isLowStock = stocks[i] < 30;

              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isDark ? kDarkCard : kLightCard,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: accent.withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ImagePlaceholder(
                        height: 56,
                        width: 56,
                        icon: Icons.checkroom_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(names[i], style: theme.textTheme.titleMedium),
                          Row(
                            children: [
                              Text('PKR ${prices[i]}',
                                  style: TextStyle(
                                      color: accent,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13)),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: stocks[i] == 0
                                      ? Colors.red.withOpacity(0.15)
                                      : isLowStock
                                          ? Colors.orange.withOpacity(0.15)
                                          : Colors.green.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  stocks[i] == 0
                                      ? 'Out of Stock'
                                      : '${stocks[i]} in stock',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: stocks[i] == 0
                                        ? Colors.red
                                        : isLowStock
                                            ? Colors.orange
                                            : Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit_outlined,
                              color: accent, size: 18),
                          onPressed: () {},
                          tooltip: 'Edit',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red, size: 18),
                          onPressed: () {},
                          tooltip: 'Delete',
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersTab(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    final accent = isDark ? kGold : kDeepBlue;
    final orders = [
      {'id': '#BI-1234', 'customer': 'Ahmed Khan', 'date': 'May 5, 2024', 'total': 'PKR 8,200', 'status': 'Delivered', 'type': 'Retail'},
      {'id': '#BI-1235', 'customer': 'Sarah Mitchell', 'date': 'May 6, 2024', 'total': 'PKR 3,500', 'status': 'Processing', 'type': 'Retail'},
      {'id': '#BI-1236', 'customer': 'UK Fashion Imports', 'date': 'May 4, 2024', 'total': 'PKR 420,000', 'status': 'Shipped', 'type': 'B2B'},
      {'id': '#BI-1237', 'customer': 'Gulf Textile Co.', 'date': 'May 3, 2024', 'total': 'PKR 1.2M', 'status': 'Pending', 'type': 'B2B'},
      {'id': '#BI-1238', 'customer': 'Mode Parisienne', 'date': 'May 2, 2024', 'total': 'PKR 780,000', 'status': 'Delivered', 'type': 'B2B'},
      {'id': '#BI-1239', 'customer': 'Rashid Enterprises', 'date': 'May 1, 2024', 'total': 'PKR 12,500', 'status': 'Processing', 'type': 'Retail'},
    ];
    final statusColors = {
      'Delivered': Colors.green,
      'Processing': Colors.orange,
      'Shipped': Colors.blue,
      'Pending': Colors.red,
    };

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final order = orders[i];
        final sc = statusColors[order['status']] ?? Colors.grey;
        final isB2B = order['type'] == 'B2B';

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? kDarkCard : kLightCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(order['id']!,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(width: 8),
                        if (isB2B)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: kDeepBlue.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('B2B',
                                style: TextStyle(
                                    color: kDeepBlue,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700)),
                          ),
                      ],
                    ),
                    Text(order['customer']!, style: theme.textTheme.bodySmall),
                    Text(order['date']!, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(order['total']!,
                    style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.w700)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: sc.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(order['status']!,
                    style: TextStyle(
                        color: sc, fontSize: 11, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCustomersTab(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    final accent = isDark ? kGold : kDeepBlue;
    final customers = [
      {'name': 'Ahmed Khan', 'email': 'ahmed@example.com', 'orders': 8, 'spent': 'PKR 42,500', 'type': 'Retail'},
      {'name': 'UK Fashion Imports', 'email': 'orders@ukfashion.co.uk', 'orders': 24, 'spent': 'PKR 2.1M', 'type': 'B2B'},
      {'name': 'Gulf Textile Co.', 'email': 'buying@gulftextile.ae', 'orders': 18, 'spent': 'PKR 8.4M', 'type': 'B2B'},
      {'name': 'Sarah Mitchell', 'email': 'sarah.m@gmail.com', 'orders': 3, 'spent': 'PKR 12,000', 'type': 'Retail'},
      {'name': 'Mode Parisienne', 'email': 'import@modeparis.fr', 'orders': 12, 'spent': 'PKR 5.6M', 'type': 'B2B'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: customers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final c = customers[i];
        final isB2B = c['type'] == 'B2B';

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? kDarkCard : kLightCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: accent.withOpacity(0.2),
                child: Text(
                  (c['name'] as String)[0],
                  style: TextStyle(color: accent, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(c['name'] as String,
                            style: theme.textTheme.titleMedium),
                        const SizedBox(width: 8),
                        if (isB2B)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: kDeepBlue.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text('B2B',
                                style: TextStyle(
                                    color: kDeepBlue,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700)),
                          ),
                      ],
                    ),
                    Text(c['email'] as String,
                        style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(c['spent'] as String,
                      style: TextStyle(
                          color: accent,
                          fontWeight: FontWeight.w700,
                          fontSize: 13)),
                  Text('${c['orders']} orders',
                      style: theme.textTheme.bodySmall),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Simple Bar Chart Painter ──

class _SimpleBarChartPainter extends CustomPainter {
  final List<int> values;
  final List<String> labels;
  final Color barColor;
  final bool isDark;

  _SimpleBarChartPainter({
    required this.values,
    required this.labels,
    required this.barColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final maxVal = values.reduce((a, b) => a > b ? a : b).toDouble();
    final barWidth = (size.width / values.length) * 0.5;
    final gap = (size.width / values.length) * 0.5;

    final paint = Paint()..color = barColor.withOpacity(0.8);
    final bgPaint = Paint()
      ..color = (isDark ? Colors.white : Colors.black).withOpacity(0.05);
    final labelStyle = TextStyle(
      fontSize: 10,
      color: isDark ? kSubtextLight : kSubtextDark,
    );

    for (int i = 0; i < values.length; i++) {
      final x = (gap / 2) + i * (barWidth + gap);
      final barH = (values[i] / maxVal) * (size.height - 20);

      // Background bar
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, 0, barWidth, size.height - 20),
          const Radius.circular(3),
        ),
        bgPaint,
      );

      // Value bar
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, size.height - 20 - barH, barWidth, barH),
          const Radius.circular(3),
        ),
        paint,
      );

      // Label
      final tp = TextPainter(
        text: TextSpan(text: labels[i], style: labelStyle),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(x + (barWidth - tp.width) / 2, size.height - 18));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
