import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';
import '../widgets/app_drawer.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String? _selectedCategory;
  String _sortBy = 'Featured';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<Product> get _filteredProducts {
    var products = mockProducts.toList();

    if (_selectedCategory != null) {
      products = products.where((p) => p.categoryId == _selectedCategory).toList();
    }
    if (_searchQuery.isNotEmpty) {
      products = products
          .where((p) =>
              p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              p.material.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    switch (_sortBy) {
      case 'Price: Low to High':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Top Rated':
        products.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Newest':
        products = [...products.where((p) => p.isNew), ...products.where((p) => !p.isNew)];
        break;
    }
    return products;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWide = MediaQuery.of(context).size.width >= 768;

    return ResponsiveScaffold(
      title: 'Products',
      currentRoute: '/products',
      body: Column(
        children: [
          // ── Header ──
          _buildHeader(context, isDark),
          // ── Filters ──
          _buildFilters(context, isDark),
          // ── Product Grid ──
          Expanded(
            child: _filteredProducts.isEmpty
                ? _buildEmpty(context)
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isWide ? 4 : 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (_, i) {
                      final product = _filteredProducts[i];
                      return ProductCard(
                        product: product,
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/product-detail',
                          arguments: product,
                        ),
                        onAddToCart: () => _addToCart(context, product),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: isDark ? kSubtextLight : kSubtextDark,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _sortBy,
                items: ['Featured', 'Newest', 'Top Rated',
                  'Price: Low to High', 'Price: High to Low']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 13))))
                    .toList(),
                onChanged: (v) => setState(() => _sortBy = v!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context, bool isDark) {
    final accent = isDark ? kGold : kDeepBlue;

    return SizedBox(
      height: 52,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: mockCategories.length + 1,
        itemBuilder: (_, i) {
          final isAll = i == 0;
          final cat = isAll ? null : mockCategories[i - 1];
          final isSelected =
              isAll ? _selectedCategory == null : _selectedCategory == cat!.id;

          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat?.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isSelected
                    ? accent
                    : (isDark ? kDarkCard : const Color(0xFFEEEEEE)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  isAll ? 'All' : cat!.name,
                  style: TextStyle(
                    color: isSelected
                        ? (isDark ? Colors.black : Colors.white)
                        : (isDark ? kTextLight : kTextDark),
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64,
              color: Theme.of(context).brightness == Brightness.dark
                  ? kSubtextLight
                  : kSubtextDark),
          const SizedBox(height: 16),
          Text('No products found',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('Try a different search or category',
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  void _addToCart(BuildContext context, Product product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart!'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ),
    );
  }
}
