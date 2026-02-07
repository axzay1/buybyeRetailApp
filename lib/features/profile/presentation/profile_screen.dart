import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../config/theme/app_theme.dart';
import '../../auth/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profile),
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('Please login'));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                // Profile Picture
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Theme.of(context).primaryColor,
                  backgroundImage: user.photoURL != null
                      ? NetworkImage(user.photoURL!)
                      : null,
                  child: user.photoURL == null
                      ? const Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  user.displayName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 32),
                // Menu Items
                _buildMenuItem(
                  context,
                  icon: Icons.edit_outlined,
                  title: AppStrings.editProfile,
                  onTap: () => context.push('/profile/edit'),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.shopping_bag_outlined,
                  title: AppStrings.orders,
                  onTap: () => context.push('/orders'),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.sell_outlined,
                  title: AppStrings.sellingHistory,
                  onTap: () => context.push('/selling-history'),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.location_on_outlined,
                  title: AppStrings.addresses,
                  onTap: () {
                    // TODO: Navigate to addresses
                  },
                ),
                const Divider(),
                _buildMenuItem(
                  context,
                  icon: Icons.dark_mode_outlined,
                  title: AppStrings.darkMode,
                  trailing: Switch(
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (value) {
                      ref.read(themeModeProvider.notifier).toggleTheme();
                    },
                  ),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.settings_outlined,
                  title: AppStrings.settings,
                  onTap: () {
                    // TODO: Navigate to settings
                  },
                ),
                const Divider(),
                _buildMenuItem(
                  context,
                  icon: Icons.logout,
                  title: AppStrings.logout,
                  onTap: () async {
                    await ref.read(authControllerProvider).signOut();
                    if (context.mounted) {
                      context.go('/auth/login');
                    }
                  },
                  iconColor: Colors.red,
                  titleColor: Colors.red,
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    Color? iconColor,
    Color? titleColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(color: titleColor),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
