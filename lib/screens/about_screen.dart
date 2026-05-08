import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';
import '../widgets/app_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return ResponsiveScaffold(
      title: 'About Us',
      currentRoute: '/about',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Page Header ──
            _buildPageHeader(context, isDark),

            // ── Company History ──
            _buildSection(context, 'Our History',
                'A journey of excellence since 2006',
                _buildHistory(context, isDark, theme)),

            // ── Vision & Mission ──
            _buildVisionMission(context, isDark, theme),

            // ── Manufacturing Process ──
            _buildSection(
              context,
              'Our Manufacturing Process',
              'From raw fabric to finished garment',
              _buildProcess(context, isDark),
            ),

            // ── Team ──
            _buildSection(context, 'Leadership Team',
                'The people behind Benefits Industries',
                _buildTeam(context, isDark, theme)),

            // ── Certifications ──
            _buildCertifications(context, isDark, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context, bool isDark) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [kDarkBg, kDarkCard]
              : [kDeepBlue, const Color(0xFF3949AB)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'About Us',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Crafting Quality Apparel Since 2006',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String subtitle,
    Widget child,
  ) {
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

  Widget _buildHistory(
      BuildContext context, bool isDark, ThemeData theme) {
    final milestones = [
      {'year': '2006', 'event': 'Founded in Lahore with 50 employees and 2 stitching units'},
      {'year': '2009', 'event': 'Expanded to 500+ workforce and secured first international export contract'},
      {'year': '2012', 'event': 'Achieved ISO 9001 certification and opened second manufacturing facility'},
      {'year': '2015', 'event': 'Launched B2B export division, supplying to UK, UAE, and European markets'},
      {'year': '2018', 'event': 'Opened state-of-the-art embroidery & printing unit with 32-head machines'},
      {'year': '2021', 'event': 'Reached milestone of 2 million garments per year production capacity'},
      {'year': '2024', 'event': 'Serving 500+ global clients across 45+ countries with 1,200+ workforce'},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: milestones.length,
      separatorBuilder: (_, __) => const SizedBox(height: 0),
      itemBuilder: (_, i) {
        final m = milestones[i];
        final accent = isDark ? kGold : kDeepBlue;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 60,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      m['year']!,
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (i < milestones.length - 1)
                    Container(
                      width: 2,
                      height: 60,
                      color: accent.withOpacity(0.3),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? kDarkCard : kLightCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: accent.withOpacity(0.15),
                  ),
                ),
                child: Text(m['event']!, style: theme.textTheme.bodyLarge),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildVisionMission(
      BuildContext context, bool isDark, ThemeData theme) {
    final accent = isDark ? kGold : kDeepBlue;

    return Container(
      color: isDark ? kDarkSurface : const Color(0xFFF0F4FF),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          SectionTitle(
            title: 'Vision & Mission',
            subtitle: 'Guiding principles that drive us forward',
          ),
          const SizedBox(height: 28),
          LayoutBuilder(builder: (_, constraints) {
            final isWide = constraints.maxWidth >= 600;
            return isWide
                ? Row(
                    children: [
                      Expanded(child: _vmCard(theme, isDark, accent, '🎯 Our Vision',
                          'To be the most trusted garment manufacturing partner globally, known for unwavering quality, ethical practices, and innovative design solutions.')),
                      const SizedBox(width: 20),
                      Expanded(child: _vmCard(theme, isDark, accent, '🚀 Our Mission',
                          'Deliver premium quality garments at competitive prices through state-of-the-art manufacturing, a skilled workforce, and a commitment to sustainable practices.')),
                    ],
                  )
                : Column(
                    children: [
                      _vmCard(theme, isDark, accent, '🎯 Our Vision',
                          'To be the most trusted garment manufacturing partner globally, known for unwavering quality, ethical practices, and innovative design solutions.'),
                      const SizedBox(height: 16),
                      _vmCard(theme, isDark, accent, '🚀 Our Mission',
                          'Deliver premium quality garments at competitive prices through state-of-the-art manufacturing, a skilled workforce, and a commitment to sustainable practices.'),
                    ],
                  );
          }),
        ],
      ),
    );
  }

  Widget _vmCard(ThemeData theme, bool isDark, Color accent, String title, String body) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? kDarkCard : kLightCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.headlineMedium),
          const SizedBox(height: 12),
          Text(body, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget _buildProcess(BuildContext context, bool isDark) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mockManufacturingSteps.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, i) {
        final step = mockManufacturingSteps[i];
        final accent = isDark ? kGold : kDeepBlue;
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? kDarkCard : kLightCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: accent.withOpacity(0.15)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: accent.withOpacity(0.15),
                child: Text(step.icon, style: const TextStyle(fontSize: 22)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Step ${step.stepNumber}: ${step.title}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 6),
                    Text(step.description,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTeam(BuildContext context, bool isDark, ThemeData theme) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width >= 600 ? 4 : 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: mockTeam.length,
      itemBuilder: (_, i) {
        final member = mockTeam[i];
        final accent = isDark ? kGold : kDeepBlue;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? kDarkCard : kLightCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: accent.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: accent,
                child: Text(
                  member.name.split(' ').map((w) => w[0]).take(2).join(),
                  style: TextStyle(
                    color: isDark ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(member.name,
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: 4),
              Text(member.role,
                  style: TextStyle(
                      color: accent, fontSize: 12, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(member.bio,
                  style: theme.textTheme.bodySmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCertifications(
      BuildContext context, bool isDark, ThemeData theme) {
    final certs = [
      {'icon': '🏆', 'title': 'ISO 9001:2015', 'desc': 'Quality Management System'},
      {'icon': '🌿', 'title': 'OEKO-TEX® Standard 100', 'desc': 'Textile Safety & Sustainability'},
      {'icon': '⚡', 'title': 'WRAP Certification', 'desc': 'Worldwide Responsible Accredited Production'},
      {'icon': '🔒', 'title': 'BSCI Compliant', 'desc': 'Business Social Compliance Initiative'},
      {'icon': '📋', 'title': 'GOTS Certified', 'desc': 'Global Organic Textile Standard'},
      {'icon': '🌊', 'title': 'Bluesign®', 'desc': 'Sustainable Textile Production'},
    ];
    final accent = isDark ? kGold : kDeepBlue;

    return Container(
      color: isDark ? kDarkSurface : const Color(0xFFF8F9FF),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          SectionTitle(
            title: 'Certifications',
            subtitle: 'International standards we proudly uphold',
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).size.width >= 600 ? 3 : 2,
              childAspectRatio: 1.6,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: certs.length,
            itemBuilder: (_, i) {
              final cert = certs[i];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? kDarkCard : kLightCard,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: accent.withOpacity(0.15)),
                ),
                child: Row(
                  children: [
                    Text(cert['icon']!,
                        style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(cert['title']!,
                              style: theme.textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          Text(cert['desc']!,
                              style: theme.textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
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
}
