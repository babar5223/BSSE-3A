import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';
import '../widgets/app_drawer.dart';

class ManufacturingScreen extends StatelessWidget {
  const ManufacturingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final isWide = MediaQuery.of(context).size.width >= 768;

    return ResponsiveScaffold(
      title: 'Manufacturing',
      currentRoute: '/manufacturing',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ──
            _buildHeader(context, isDark),

            // ── Process Steps ──
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SectionTitle(
                    title: 'Our Process',
                    subtitle: 'End-to-end manufacturing excellence',
                  ),
                  const SizedBox(height: 28),
                  ...mockManufacturingSteps.asMap().entries.map(
                    (entry) => _buildStepCard(
                        context, isDark, theme, entry.value, entry.key.isEven, isWide),
                  ),
                ],
              ),
            ),

            // ── Capacity ──
            _buildCapacity(context, isDark, theme, isWide),

            // ── Equipment ──
            _buildEquipment(context, isDark, theme),

            // ── CTA ──
            Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [kDeepBlue.withOpacity(0.3), kDarkCard]
                        : [kDeepBlue, const Color(0xFF283593)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      '🏭 Start Your Manufacturing Order',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Get a custom quote for your bulk order requirements.',
                      style: const TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/wholesale'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGold,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Request a Quote',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [kDarkBg, kDarkCard]
              : [kDeepBlue, const Color(0xFF3949AB)],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: GridView.count(
                crossAxisCount: 6,
                children: List.generate(
                  24,
                  (_) => const Icon(Icons.settings, color: Colors.white, size: 40),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '🏭 Manufacturing',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                const Text(
                  'State-of-the-art garment production\nfrom concept to delivery',
                  style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    _chip('1,200+ Workers'),
                    _chip('50,000 pcs/day'),
                    _chip('ISO Certified'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: kGold.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kGold.withOpacity(0.5)),
      ),
      child: Text(label,
          style: const TextStyle(
              color: kGold, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildStepCard(BuildContext context, bool isDark, ThemeData theme,
      ManufacturingStep step, bool isEven, bool isWide) {
    final accent = isDark ? kGold : kDeepBlue;
    final imageWidget = ImagePlaceholder(
      height: 200,
      icon: Icons.precision_manufacturing_outlined,
      label: step.title,
    );
    final textWidget = Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '${step.stepNumber}',
                    style: TextStyle(
                      color: isDark ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(step.icon, style: const TextStyle(fontSize: 28)),
            ],
          ),
          const SizedBox(height: 14),
          Text(step.title, style: theme.textTheme.headlineLarge),
          const SizedBox(height: 8),
          Text(step.description,
              style: theme.textTheme.bodyLarge, maxLines: 4),
        ],
      ),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: isDark ? kDarkCard : kLightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accent.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isWide
          ? Row(
              children: isEven
                  ? [Expanded(child: textWidget), Expanded(child: imageWidget)]
                  : [Expanded(child: imageWidget), Expanded(child: textWidget)],
            )
          : Column(children: [imageWidget, textWidget]),
    );
  }

  Widget _buildCapacity(BuildContext context, bool isDark, ThemeData theme, bool isWide) {
    final capacities = [
      {'icon': '👕', 'label': 'T-Shirts / Day', 'value': '15,000+'},
      {'icon': '🧥', 'label': 'Hoodies / Day', 'value': '8,000+'},
      {'icon': '👔', 'label': 'Formal Shirts / Day', 'value': '10,000+'},
      {'icon': '👖', 'label': 'Denim / Day', 'value': '5,000+'},
      {'icon': '🦺', 'label': 'Uniforms / Day', 'value': '6,000+'},
      {'icon': '🏃', 'label': 'Sportswear / Day', 'value': '7,000+'},
    ];
    final accent = isDark ? kGold : kDeepBlue;

    return Container(
      color: isDark ? kDarkSurface : const Color(0xFFF0F4FF),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Production Capacity',
            subtitle: 'Our daily output across all garment categories',
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isWide ? 3 : 2,
              childAspectRatio: 1.8,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: capacities.length,
            itemBuilder: (_, i) {
              final c = capacities[i];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? kDarkCard : kLightCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: accent.withOpacity(0.15)),
                ),
                child: Row(
                  children: [
                    Text(c['icon']!, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(c['value']!,
                              style: TextStyle(
                                color: accent,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              )),
                          Text(c['label']!,
                              style: theme.textTheme.bodySmall,
                              maxLines: 2),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEquipment(BuildContext context, bool isDark, ThemeData theme) {
    final equipment = [
      '1,200+ Industrial Sewing Machines',
      '32-Head Computerized Embroidery Machines',
      'CAD Pattern Making Systems',
      'Automated Fabric Cutting Machines',
      'DTG & Screen Printing Units',
      'In-House Fabric Testing Lab',
      'Steam Ironing & Finishing Lines',
      'Computerized Inventory System',
    ];
    final accent = isDark ? kGold : kDeepBlue;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Equipment & Technology',
            subtitle: 'State-of-the-art machinery for precision manufacturing',
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width >= 600 ? 2 : 1,
              childAspectRatio: 5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 10,
            ),
            itemCount: equipment.length,
            itemBuilder: (_, i) => Row(
              children: [
                Icon(Icons.check_circle, color: accent, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(equipment[i], style: theme.textTheme.bodyLarge),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
