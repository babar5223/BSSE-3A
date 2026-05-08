import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/app_drawer.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final isWide = MediaQuery.of(context).size.width >= 768;

    return ResponsiveScaffold(
      title: 'Contact Us',
      currentRoute: '/contact',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, isDark),
            _buildContactInfo(context, isDark, theme, isWide),
            _buildMapPlaceholder(context, isDark),
            if (!_sent)
              _buildForm(context, isDark, theme)
            else
              _buildSentConfirmation(context, isDark, theme),
            _buildSocialLinks(context, isDark, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [kDarkBg, kDarkCard]
              : [kDeepBlue, const Color(0xFF3949AB)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📞 Contact Us',
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            'We\'d love to hear from you. Reach out for inquiries, quotes, or support.',
            style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context, bool isDark, ThemeData theme, bool isWide) {
    final accent = isDark ? kGold : kDeepBlue;
    final contacts = [
      {
        'icon': Icons.location_on_outlined,
        'title': 'Our Address',
        'value': '23-B, Quaid-e-Azam Industrial Estate\nLahore, Punjab 54000, Pakistan',
      },
      {
        'icon': Icons.phone_outlined,
        'title': 'Phone / WhatsApp',
        'value': '+92-42-3591-2345\n+92-300-8452-678',
      },
      {
        'icon': Icons.email_outlined,
        'title': 'Email',
        'value': 'info@benefitsindustries.com\nexports@benefitsindustries.com',
      },
      {
        'icon': Icons.access_time_outlined,
        'title': 'Business Hours',
        'value': 'Mon – Sat: 9:00 AM – 6:00 PM\nSunday: Closed',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isWide ? 4 : 2,
          childAspectRatio: isWide ? 1.2 : 1.0,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemCount: contacts.length,
        itemBuilder: (_, i) {
          final c = contacts[i];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? kDarkCard : kLightCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: accent.withOpacity(0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(c['icon'] as IconData, color: accent, size: 28),
                const SizedBox(height: 10),
                Text(c['title'] as String,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Expanded(
                  child: Text(c['value'] as String,
                      style: theme.textTheme.bodySmall,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMapPlaceholder(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF1A1A2E), const Color(0xFF2E2E4A)]
              : [const Color(0xFFE8EFF5), const Color(0xFFD0E2EE)],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Simulated map grid
            GridView.count(
              crossAxisCount: 6,
              children: List.generate(
                24,
                (i) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: (isDark ? Colors.white : Colors.black)
                          .withOpacity(0.05),
                    ),
                  ),
                ),
              ),
            ),
            // Roads
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_pin,
                      color: Colors.red, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    'Benefits Industries',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isDark ? kTextLight : kTextDark,
                    ),
                  ),
                  Text(
                    'Quaid-e-Azam Industrial Estate, Lahore',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? kSubtextLight : kSubtextDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: kDeepBlue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '📍 View on Google Maps',
                      style: TextStyle(
                          color: Colors.white, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, bool isDark, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'Send a Message',
              subtitle: 'We respond within 24 business hours',
              centered: false,
            ),
            const SizedBox(height: 20),
            LayoutBuilder(builder: (_, constraints) {
              final isWide = constraints.maxWidth >= 600;
              return isWide
                  ? Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _nameController,
                            validator: (v) =>
                                v!.isEmpty ? 'Required' : null,
                            decoration:
                                const InputDecoration(labelText: 'Your Name *'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _emailController,
                            validator: (v) =>
                                v!.isEmpty ? 'Required' : null,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                labelText: 'Email Address *'),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                          decoration:
                              const InputDecoration(labelText: 'Your Name *'),
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _emailController,
                          validator: (v) => v!.isEmpty ? 'Required' : null,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelText: 'Email Address *'),
                        ),
                      ],
                    );
            }),
            const SizedBox(height: 14),
            TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Subject'),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              validator: (v) => v!.isEmpty ? 'Required' : null,
              decoration: const InputDecoration(
                labelText: 'Your Message *',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                PrimaryButton(
                  label: 'Send Message',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _sent = true);
                    }
                  },
                  icon: Icons.send_outlined,
                ),
                _buildWhatsAppButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhatsAppButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Opening WhatsApp...')),
      ),
      icon: const Text('💬', style: TextStyle(fontSize: 16)),
      label: const Text('WhatsApp Us',
          style: TextStyle(fontWeight: FontWeight.w600)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF25D366),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildSentConfirmation(BuildContext context, bool isDark, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 64),
          const SizedBox(height: 16),
          Text('Message Sent!', style: theme.textTheme.displaySmall),
          const SizedBox(height: 8),
          Text(
            'Thank you for reaching out. We\'ll respond to your message within 24 hours.',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Send Another Message',
            onPressed: () => setState(() {
              _sent = false;
              _nameController.clear();
              _emailController.clear();
              _subjectController.clear();
              _messageController.clear();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context, bool isDark, ThemeData theme) {
    final accent = isDark ? kGold : kDeepBlue;
    final socials = [
      {'icon': Icons.facebook, 'name': 'Facebook', 'handle': '@BenefitsIndustries'},
      {'icon': Icons.camera_alt_outlined, 'name': 'Instagram', 'handle': '@benefits_industries'},
      {'icon': Icons.link, 'name': 'LinkedIn', 'handle': 'Benefits Industries Pakistan'},
      {'icon': Icons.play_circle_outline, 'name': 'YouTube', 'handle': 'Benefits Industries'},
    ];

    return Container(
      color: isDark ? kDarkSurface : const Color(0xFFF8F9FF),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Follow Us',
            subtitle: 'Stay connected on social media',
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: socials.map((s) => GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isDark ? kDarkCard : kLightCard,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: accent.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(s['icon'] as IconData, color: accent, size: 20),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s['name'] as String,
                            style: theme.textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700)),
                        Text(s['handle'] as String,
                            style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
