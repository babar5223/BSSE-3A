import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _heroController = PageController();
  int _currentHero = 0;

  final List<Map<String, String>> _heroSlides = [
    {
      'title': 'Crafting Quality\nApparel for the Future',
      'subtitle': 'Premium garments manufactured with precision & passion',
      'cta': 'Explore Collections',
    },
    {
      'title': 'B2B Manufacturing\nPartners Worldwide',
      'subtitle': 'Export-ready garments for 45+ countries',
      'cta': 'Get Wholesale Quote',
    },
    {
      'title': 'From Fabric to\nFashion — We Do It All',
      'subtitle': 'Complete manufacturing solutions under one roof',
      'cta': 'Our Process',
    },
  ];

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 768;

    return ResponsiveScaffold(
      title: 'Benefits Industries',
      currentRoute: '/',
      floatingActionButton: const ChatbotWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Hero Section ──
            _buildHeroSection(context, isDark, isWide),

            // ── Featured Products ──
            _buildSection(
              context,
              title: 'Featured Products',
              subtitle: 'Handpicked from our latest collections',
              child: _buildFeaturedProducts(context),
            ),

            // ── Company Intro ──
            _buildCompanyIntro(context, isDark, isWide),

            // ── Stats ──
            _buildStatsSection(context),

            // ── Categories ──
            _buildSection(
              context,
              title: 'Product Categories',
              subtitle: 'Browse our full range of manufacturing capabilities',
              child: _buildCategories(context),
            ),

            // ── Testimonials ──
            _buildSection(
              context,
              title: 'Client Testimonials',
              subtitle: 'Trusted by buyers from 45+ countries',
              child: _buildTestimonials(context),
            ),

            // ── CTA ──
            _buildCTA(context, isDark),

            // ── Newsletter ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: const NewsletterSection(),
            ),

            // ── Footer ──
            _buildFooter(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isDark, bool isWide) {
    final theme = Theme.of(context);
    final accent = isDark ? kGold : kGold;

    return SizedBox(
      height: isWide ? 500 : 380,
      child: Stack(
        children: [
          PageView.builder(
            controller: _heroController,
            onPageChanged: (i) => setState(() => _currentHero = i),
            itemCount: _heroSlides.length,
            itemBuilder: (_, i) {
              final slide = _heroSlides[i];
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF050505), kDarkCard]
                        : [kDeepBlue, const Color(0xFF283593)],
                  ),
                ),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.05,
                        child: GridView.count(
                          crossAxisCount: 8,
                          children: List.generate(
                            64,
                            (_) => Icon(Icons.checkroom,
                                color: Colors.white, size: 40),
                          ),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWide ? 80 : 28,
                        vertical: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: accent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: accent.withOpacity(0.5)),
                            ),
                            child: Text(
                              '✦ Since 2006',
                              style: TextStyle(
                                  color: accent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            slide['title']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isWide ? 42 : 28,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            slide['subtitle']!,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: isWide ? 16 : 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, '/products'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accent,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Text(slide['cta']!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700)),
                              ),
                              const SizedBox(width: 14),
                              OutlinedButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, '/wholesale'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(
                                      color: Colors.white54, width: 1.5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text('B2B Inquiry',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Page indicator
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _heroSlides.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentHero == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentHero == i ? kGold : Colors.white38,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    String? subtitle,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          SectionTitle(title: title, subtitle: subtitle),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    final featured = mockProducts.where((p) => p.isFeatured).toList();
    final isWide = MediaQuery.of(context).size.width >= 768;
    final crossAxisCount = isWide ? 4 : 2;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.72,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: featured.length,
      itemBuilder: (_, i) => ProductCard(
        product: featured[i],
        onTap: () => Navigator.pushNamed(
          context,
          '/product-detail',
          arguments: featured[i],
        ),
        onAddToCart: () => _addToCart(context, featured[i]),
      ),
    );
  }

  Widget _buildCompanyIntro(BuildContext context, bool isDark, bool isWide) {
    final theme = Theme.of(context);
    final accent = isDark ? kGold : kDeepBlue;

    return Container(
      color: isDark ? kDarkSurface : const Color(0xFFF0F4FF),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 80 : 24,
        vertical: 48,
      ),
      child: isWide
          ? Row(
              children: [
                Expanded(child: _companyIntroText(context, isDark, accent, theme)),
                const SizedBox(width: 48),
                Expanded(
                  child: ImagePlaceholder(
                    height: 320,
                    icon: Icons.factory_outlined,
                    label: 'Benefits Industries Factory\nLahore, Pakistan',
                  ),
                ),
              ],
            )
          : Column(
              children: [
                _companyIntroText(context, isDark, accent, theme),
                const SizedBox(height: 24),
                ImagePlaceholder(
                  height: 220,
                  icon: Icons.factory_outlined,
                  label: 'Benefits Industries Factory\nLahore, Pakistan',
                ),
              ],
            ),
    );
  }

  Widget _companyIntroText(
      BuildContext context, bool isDark, Color accent, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accent.withOpacity(0.3)),
          ),
          child: Text(
            '✦ About Benefits Industries',
            style: TextStyle(color: accent, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Pakistan\'s Premier\nGarment Manufacturer',
          style: theme.textTheme.displaySmall,
        ),
        const SizedBox(height: 16),
        Text(
          'Founded in 2006, Benefits Industries has grown from a local stitching unit to one of Pakistan\'s leading garment manufacturing companies. We serve retail brands, corporate buyers, and international exporters with a commitment to quality that never wavers.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            _featurePill(context, '🏭 3 Manufacturing Units', accent),
            _featurePill(context, '🌍 45+ Countries', accent),
            _featurePill(context, '✅ ISO Certified', accent),
            _featurePill(context, '⚡ 50k pcs/day', accent),
          ],
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          label: 'Learn More About Us',
          onPressed: () => Navigator.pushNamed(context, '/about'),
          icon: Icons.arrow_forward,
        ),
      ],
    );
  }

  Widget _featurePill(BuildContext context, String label, Color accent) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isDark ? kTextLight : kTextDark,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWide = MediaQuery.of(context).size.width >= 768;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [kDarkBg, kDarkCard]
              : [kDeepBlue, const Color(0xFF283593)],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Our Numbers Speak',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '18 years of excellence in garment manufacturing',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          GridView.count(
            crossAxisCount: isWide ? 4 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: mockStats.map((s) => StatCard(stat: s)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 768;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isWide ? 4 : 2,
        childAspectRatio: isWide ? 1.0 : 0.95,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: mockCategories.length,
      itemBuilder: (_, i) => CategoryCard(
        category: mockCategories[i],
        onTap: () => Navigator.pushNamed(
          context,
          '/products',
          arguments: mockCategories[i],
        ),
      ),
    );
  }

  Widget _buildTestimonials(BuildContext context) {
    return SizedBox(
      height: 280,
      child: PageView.builder(
        padEnds: false,
        controller: PageController(viewportFraction: 0.88),
        itemCount: mockTestimonials.length,
        itemBuilder: (_, i) => TestimonialCard(testimonial: mockTestimonials[i]),
      ),
    );
  }

  Widget _buildCTA(BuildContext context, bool isDark) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1A1A2E), kDarkCard]
              : [const Color(0xFFFFF8E1), const Color(0xFFFFF3C4)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: kGold.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            '🚀 Ready to Start Your Order?',
            style: theme.textTheme.headlineLarge?.copyWith(
              color: isDark ? kTextLight : kTextDark,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Join 500+ global brands that trust Benefits Industries for their manufacturing needs.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isDark ? kSubtextLight : kSubtextDark,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 14,
            runSpacing: 12,
            children: [
              PrimaryButton(
                label: 'Request B2B Quote',
                onPressed: () => Navigator.pushNamed(context, '/wholesale'),
                icon: Icons.business_center_outlined,
              ),
              OutlineButton(
                label: 'Browse Products',
                onPressed: () => Navigator.pushNamed(context, '/products'),
                icon: Icons.checkroom_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    return Container(
      color: isDark ? kDarkBg : kDeepBlue,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          Text(
            'Benefits Industries',
            style: TextStyle(
              color: kGold,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Crafting Quality Apparel for the Future',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 8,
            children: [
              'Home', 'About', 'Products', 'Manufacturing',
              'Wholesale', 'Contact',
            ].map((link) => TextButton(
              onPressed: () {},
              child: Text(link,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 13)),
            )).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon(Icons.facebook, 'Facebook'),
              _socialIcon(Icons.link, 'LinkedIn'),
              _socialIcon(Icons.camera_alt_outlined, 'Instagram'),
              _socialIcon(Icons.play_circle_outline, 'YouTube'),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '© 2024 Benefits Industries. All rights reserved.',
            style: const TextStyle(color: Colors.white54, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, String tooltip) {
    return IconButton(
      icon: Icon(icon, color: Colors.white70),
      tooltip: tooltip,
      onPressed: () {},
    );
  }

  void _addToCart(BuildContext context, Product product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart!'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ),
    );
  }
}
