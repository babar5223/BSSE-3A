import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';
import '../widgets/app_drawer.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedSize;
  String? _selectedColor;
  int _quantity = 1;
  bool _isWishlisted = false;
  int _currentImage = 0;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.product.sizes.first;
    _selectedColor = widget.product.colors.first;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final accent = isDark ? kGold : kDeepBlue;
    final isWide = MediaQuery.of(context).size.width >= 768;
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: Icon(
              _isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: _isWishlisted ? Colors.red : null,
            ),
            onPressed: () => setState(() => _isWishlisted = !_isWishlisted),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: _buildImageGallery(context, isDark),
                ),
                Expanded(
                  flex: 6,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: _buildProductInfo(context, isDark, theme, accent, product),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageGallery(context, isDark),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: _buildProductInfo(context, isDark, theme, accent, product),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: _buildBottomBar(context, isDark, accent),
    );
  }

  Widget _buildImageGallery(BuildContext context, bool isDark) {
    return Column(
      children: [
        SizedBox(
          height: 350,
          child: PageView.builder(
            onPageChanged: (i) => setState(() => _currentImage = i),
            itemCount: 4,
            itemBuilder: (_, i) => ImagePlaceholder(
              height: 350,
              icon: Icons.checkroom_outlined,
              label: '${widget.product.name}\nView ${i + 1}',
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            4,
            (i) => GestureDetector(
              onTap: () => setState(() => _currentImage = i),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _currentImage == i
                        ? kGold
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: ImagePlaceholder(
                    height: 56,
                    icon: Icons.checkroom_outlined,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo(BuildContext context, bool isDark, ThemeData theme,
      Color accent, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name & rating
        Text(product.name, style: theme.textTheme.displaySmall),
        const SizedBox(height: 8),
        Row(
          children: [
            ...List.generate(
              5,
              (i) => Icon(Icons.star,
                  color: i < product.rating ? kGold : Colors.grey, size: 18),
            ),
            const SizedBox(width: 8),
            Text('${product.rating} (${product.reviewCount} reviews)',
                style: theme.textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: 12),

        // Price
        Row(
          children: [
            Text(
              'PKR ${product.price.toStringAsFixed(0)}',
              style: theme.textTheme.displaySmall?.copyWith(
                color: accent,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (product.originalPrice != null) ...[
              const SizedBox(width: 10),
              Text(
                'PKR ${product.originalPrice!.toStringAsFixed(0)}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),

        // Stock
        Row(
          children: [
            Icon(
              product.inStock ? Icons.check_circle : Icons.cancel,
              color: product.inStock ? Colors.green : Colors.red,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              product.inStock ? 'In Stock' : 'Out of Stock',
              style: TextStyle(
                color: product.inStock ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 12),

        // Material
        _infoRow(theme, '🧵 Material', product.material),
        _infoRow(theme, '📦 Min. Order', '${product.moq} pieces'),
        const SizedBox(height: 16),

        // Sizes
        Text('Size:', style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: product.sizes.map((size) {
            final isSelected = _selectedSize == size;
            return GestureDetector(
              onTap: () => setState(() => _selectedSize = size),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? accent : Colors.grey,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    color: isSelected
                        ? (isDark ? Colors.black : Colors.white)
                        : null,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // Colors
        Text('Color:', style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: product.colors.map((color) {
            final isSelected = _selectedColor == color;
            return GestureDetector(
              onTap: () => setState(() => _selectedColor = color),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected
                      ? accent.withOpacity(0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? accent : Colors.grey,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Text(
                  color,
                  style: TextStyle(
                    color: isSelected ? accent : null,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Quantity
        Row(
          children: [
            Text('Quantity:', style: theme.textTheme.titleLarge),
            const SizedBox(width: 16),
            _qtyButton(Icons.remove, () {
              if (_quantity > 1) setState(() => _quantity--);
            }),
            const SizedBox(width: 12),
            Text('$_quantity',
                style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700)),
            const SizedBox(width: 12),
            _qtyButton(Icons.add, () => setState(() => _quantity++)),
          ],
        ),
        const SizedBox(height: 24),

        // Description
        Text('Description', style: theme.textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(product.description, style: theme.textTheme.bodyLarge),
        const SizedBox(height: 24),

        // Reviews
        _buildReviews(context, isDark, theme),
      ],
    );
  }

  Widget _infoRow(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(label, style: theme.textTheme.titleMedium),
          const SizedBox(width: 8),
          Text(value,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(
              color: isDark ? kGold : kDeepBlue),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16,
            color: isDark ? kGold : kDeepBlue),
      ),
    );
  }

  Widget _buildReviews(BuildContext context, bool isDark, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Customer Reviews', style: theme.textTheme.headlineSmall),
        const SizedBox(height: 12),
        ...mockReviews.map((r) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDark ? kDarkCard : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(r.reviewer,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const Spacer(),
                  Text(r.date, style: theme.textTheme.bodySmall),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(Icons.star,
                      color: i < r.rating ? kGold : Colors.grey,
                      size: 14),
                ),
              ),
              const SizedBox(height: 6),
              Text(r.comment, style: theme.textTheme.bodyMedium),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, bool isDark, Color accent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? kDarkSurface : kLightCard,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: widget.product.inStock
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                '${widget.product.name} added to cart!')),
                      );
                    }
                  : null,
              icon: const Icon(Icons.shopping_cart_outlined),
              label: Text(
                  widget.product.inStock ? 'Add to Cart' : 'Out of Stock'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed:
                  widget.product.inStock ? () => Navigator.pushNamed(context, '/cart') : null,
              icon: const Icon(Icons.flash_on),
              label: const Text('Buy Now'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
