import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import '../widgets/app_drawer.dart';

class WholesaleScreen extends StatefulWidget {
  const WholesaleScreen({Key? key}) : super(key: key);

  @override
  State<WholesaleScreen> createState() => _WholesaleScreenState();
}

class _WholesaleScreenState extends State<WholesaleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _qtyController = TextEditingController();
  final _messageController = TextEditingController();

  String _selectedCategory = "Men's Wear";
  String _selectedTimeline = '2-4 weeks';
  bool _customDesign = false;
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _qtyController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return ResponsiveScaffold(
      title: 'Wholesale Inquiry',
      currentRoute: '/wholesale',
      body: _submitted
          ? _buildSuccess(context, isDark, theme)
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context, isDark),
                  _buildMOQInfo(context, isDark, theme),
                  _buildForm(context, isDark, theme),
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
            '🏭 B2B Wholesale Inquiry',
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            'Submit your bulk order inquiry and get a custom quote within 24 hours.',
            style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              _chip('⚡ 24hr Response'),
              _chip('📦 MOQ from 25 pcs'),
              _chip('🌍 Worldwide Shipping'),
              _chip('✅ Custom Designs'),
            ],
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

  Widget _buildMOQInfo(BuildContext context, bool isDark, ThemeData theme) {
    final moqData = [
      {'category': "T-Shirts", 'moq': '100 pcs', 'lead': '2-3 weeks'},
      {'category': "Hoodies", 'moq': '50 pcs', 'lead': '3-4 weeks'},
      {'category': "Formal Shirts", 'moq': '100 pcs', 'lead': '2-3 weeks'},
      {'category': "Denim", 'moq': '50 pcs', 'lead': '4-5 weeks'},
      {'category': "Uniforms", 'moq': '25 pcs', 'lead': '2-4 weeks'},
      {'category': "Sportswear", 'moq': '50 pcs', 'lead': '3-4 weeks'},
    ];
    final accent = isDark ? kGold : kDeepBlue;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SectionTitle(
            title: 'MOQ Information',
            subtitle: 'Minimum order quantities by garment type',
          ),
          const SizedBox(height: 20),
          Table(
            border: TableBorder.all(
              color: accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.1),
                ),
                children: [
                  _tableHeader(theme, 'Category'),
                  _tableHeader(theme, 'Min. Order'),
                  _tableHeader(theme, 'Lead Time'),
                ],
              ),
              ...moqData.map((row) => TableRow(
                children: [
                  _tableCell(theme, row['category']!),
                  _tableCell(theme, row['moq']!),
                  _tableCell(theme, row['lead']!),
                ],
              )),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '* Prices vary based on design complexity, quantity, and material selection. Contact us for a precise quote.',
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _tableHeader(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Text(text,
          style: theme.textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.w700)),
    );
  }

  Widget _tableCell(ThemeData theme, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Text(text, style: theme.textTheme.bodyMedium),
    );
  }

  Widget _buildForm(BuildContext context, bool isDark, ThemeData theme) {
    final accent = isDark ? kGold : kDeepBlue;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              title: 'Inquiry Form',
              subtitle: 'Fill in your requirements and we\'ll get back to you',
              centered: false,
            ),
            const SizedBox(height: 24),
            LayoutBuilder(builder: (_, constraints) {
              final isWide = constraints.maxWidth >= 600;
              return isWide
                  ? Row(
                      children: [
                        Expanded(child: _field('Full Name *', _nameController, required: true)),
                        const SizedBox(width: 16),
                        Expanded(child: _field('Company Name *', _companyController, required: true)),
                      ],
                    )
                  : Column(
                      children: [
                        _field('Full Name *', _nameController, required: true),
                        const SizedBox(height: 14),
                        _field('Company Name *', _companyController, required: true),
                      ],
                    );
            }),
            const SizedBox(height: 14),
            LayoutBuilder(builder: (_, constraints) {
              final isWide = constraints.maxWidth >= 600;
              return isWide
                  ? Row(
                      children: [
                        Expanded(
                            child: _field('Email Address *', _emailController,
                                keyboardType: TextInputType.emailAddress,
                                required: true)),
                        const SizedBox(width: 16),
                        Expanded(
                            child: _field('Phone / WhatsApp *', _phoneController,
                                keyboardType: TextInputType.phone, required: true)),
                      ],
                    )
                  : Column(
                      children: [
                        _field('Email Address *', _emailController,
                            keyboardType: TextInputType.emailAddress, required: true),
                        const SizedBox(height: 14),
                        _field('Phone / WhatsApp *', _phoneController,
                            keyboardType: TextInputType.phone, required: true),
                      ],
                    );
            }),
            const SizedBox(height: 14),
            LayoutBuilder(builder: (_, constraints) {
              final isWide = constraints.maxWidth >= 600;
              return isWide
                  ? Row(
                      children: [
                        Expanded(child: _field('Country', _countryController)),
                        const SizedBox(width: 16),
                        Expanded(child: _field('Quantity Required', _qtyController,
                            keyboardType: TextInputType.number)),
                      ],
                    )
                  : Column(
                      children: [
                        _field('Country', _countryController),
                        const SizedBox(height: 14),
                        _field('Quantity Required', _qtyController,
                            keyboardType: TextInputType.number),
                      ],
                    );
            }),
            const SizedBox(height: 14),
            LayoutBuilder(builder: (_, constraints) {
              final isWide = constraints.maxWidth >= 600;
              return isWide
                  ? Row(
                      children: [
                        Expanded(child: _dropdownField(
                          'Product Category',
                          _selectedCategory,
                          ["Men's Wear", "Women's Wear", 'Sportswear',
                            'Hoodies', 'T-Shirts', 'Denim', 'Uniforms', 'Export Quality'],
                          (v) => setState(() => _selectedCategory = v!),
                          isDark, theme,
                        )),
                        const SizedBox(width: 16),
                        Expanded(child: _dropdownField(
                          'Delivery Timeline',
                          _selectedTimeline,
                          ['2-4 weeks', '4-6 weeks', '6-8 weeks', '8+ weeks'],
                          (v) => setState(() => _selectedTimeline = v!),
                          isDark, theme,
                        )),
                      ],
                    )
                  : Column(
                      children: [
                        _dropdownField(
                          'Product Category',
                          _selectedCategory,
                          ["Men's Wear", "Women's Wear", 'Sportswear',
                            'Hoodies', 'T-Shirts', 'Denim', 'Uniforms', 'Export Quality'],
                          (v) => setState(() => _selectedCategory = v!),
                          isDark, theme,
                        ),
                        const SizedBox(height: 14),
                        _dropdownField(
                          'Delivery Timeline',
                          _selectedTimeline,
                          ['2-4 weeks', '4-6 weeks', '6-8 weeks', '8+ weeks'],
                          (v) => setState(() => _selectedTimeline = v!),
                          isDark, theme,
                        ),
                      ],
                    );
            }),
            const SizedBox(height: 14),
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Additional Requirements / Message',
                hintText: 'Describe fabric preferences, design details, special requirements...',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            // Custom design toggle
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? kDarkCard : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Custom Design / Logo Embroidery',
                            style: theme.textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(
                          'Request custom printing, embroidery, or your own design specifications',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _customDesign,
                    onChanged: (v) => setState(() => _customDesign = v),
                    activeColor: accent,
                  ),
                ],
              ),
            ),
            if (_customDesign) ...[
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Design upload feature — select your file'),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? kDarkCard : kLightCard,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: accent.withOpacity(0.3),
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.upload_file, size: 40, color: accent),
                      const SizedBox(height: 8),
                      Text('Upload Design File',
                          style: TextStyle(
                              color: accent, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text('PNG, JPG, AI, PDF (Max 10MB)',
                          style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.send_outlined),
                label: const Text('Submit Inquiry',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    bool required = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: required
          ? (v) => (v == null || v.isEmpty) ? 'This field is required' : null
          : null,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _dropdownField(
    String label,
    String value,
    List<String> items,
    void Function(String?) onChanged,
    bool isDark,
    ThemeData theme,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: label),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13))))
          .toList(),
      onChanged: onChanged,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _submitted = true);
    }
  }

  Widget _buildSuccess(BuildContext context, bool isDark, ThemeData theme) {
    final accent = isDark ? kGold : kDeepBlue;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, color: Colors.green, size: 56),
            ),
            const SizedBox(height: 24),
            Text('Inquiry Submitted!', style: theme.textTheme.displaySmall),
            const SizedBox(height: 12),
            Text(
              'Thank you, ${_nameController.text.isEmpty ? "there" : _nameController.text}! We\'ve received your wholesale inquiry and will respond within 24 hours.',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              label: 'Submit Another Inquiry',
              onPressed: () => setState(() {
                _submitted = false;
                _nameController.clear();
                _companyController.clear();
                _emailController.clear();
                _phoneController.clear();
                _countryController.clear();
                _qtyController.clear();
                _messageController.clear();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
