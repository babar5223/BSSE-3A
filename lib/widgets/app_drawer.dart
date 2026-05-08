import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:provider/provider.dart';

const List<_NavItem> _navItems = [
  _NavItem(label: 'Home', icon: Icons.home_outlined, route: '/'),
  _NavItem(label: 'About', icon: Icons.info_outline, route: '/about'),
  _NavItem(label: 'Products', icon: Icons.checkroom_outlined, route: '/products'),
  _NavItem(label: 'Manufacturing', icon: Icons.factory_outlined, route: '/manufacturing'),
  _NavItem(label: 'Wholesale', icon: Icons.business_outlined, route: '/wholesale'),
  _NavItem(label: 'Cart', icon: Icons.shopping_cart_outlined, route: '/cart'),
  _NavItem(label: 'Admin', icon: Icons.dashboard_outlined, route: '/admin'),
  _NavItem(label: 'Contact', icon: Icons.contact_mail_outlined, route: '/contact'),
];

class _NavItem {
  final String label;
  final IconData icon;
  final String route;

  const _NavItem({required this.label, required this.icon, required this.route});
}

// ─────────────── App Drawer (Mobile) ───────────────

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentRoute =
        ModalRoute.of(context)?.settings.name ?? '/';

    return Drawer(
      backgroundColor: isDark ? kDarkSurface : kLightCard,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [kDarkBg, kDarkCard]
                    : [kDeepBlue, const Color(0xFF3949AB)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: kGold,
                  child: Text(
                    'BI',
                    style: TextStyle(
                      color: isDark ? Colors.black : Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Benefits Industries',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Crafting Quality Apparel',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _navItems.map((item) {
                final isSelected = currentRoute == item.route;
                return ListTile(
                  leading: Icon(
                    item.icon,
                    color: isSelected
                        ? (isDark ? kGold : kDeepBlue)
                        : (isDark ? kSubtextLight : kSubtextDark),
                  ),
                  title: Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected
                          ? (isDark ? kGold : kDeepBlue)
                          : (isDark ? kTextLight : kTextDark),
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                    ),
                  ),
                  selected: isSelected,
                  selectedTileColor:
                      (isDark ? kGold : kDeepBlue).withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != item.route) {
                      Navigator.pushNamed(context, item.route);
                    }
                  },
                );
              }).toList(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: isDark ? kGold : kDeepBlue,
            ),
            title: Text(
              isDark ? 'Light Mode' : 'Dark Mode',
              style: TextStyle(
                color: isDark ? kTextLight : kTextDark,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              themeProvider.toggleTheme();
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─────────────── Top Navigation Bar (Web / Tablet) ───────────────

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentRoute;

  const TopNavBar({Key? key, required this.currentRoute}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final accent = isDark ? kGold : kDeepBlue;

    return AppBar(
      backgroundColor: isDark ? kDarkBg : kLightBg,
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.1),
      toolbarHeight: 64,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: accent,
              child: Text(
                'BI',
                style: TextStyle(
                  color: isDark ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Benefits Industries',
              style: TextStyle(
                color: isDark ? kTextLight : kTextDark,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      leadingWidth: 210,
      actions: [
        ..._navItems.take(6).map((item) {
          final isSelected = currentRoute == item.route;
          return TextButton(
            onPressed: () {
              if (currentRoute != item.route) {
                Navigator.pushNamed(context, item.route);
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: isSelected ? accent : (isDark ? kSubtextLight : kSubtextDark),
            ),
            child: Text(
              item.label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          );
        }),
        IconButton(
          icon: Icon(
            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            color: accent,
          ),
          onPressed: themeProvider.toggleTheme,
          tooltip: 'Toggle Theme',
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart_outlined, color: accent),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
          tooltip: 'Cart',
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

// ─────────────── Responsive Scaffold ───────────────

class ResponsiveScaffold extends StatelessWidget {
  final String title;
  final String currentRoute;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const ResponsiveScaffold({
    Key? key,
    required this.title,
    required this.currentRoute,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 768;

    if (isWide) {
      return Scaffold(
        appBar: TopNavBar(currentRoute: currentRoute),
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      );
    }

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
