import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';
import 'package:orange_hr_dev/features/profile/presentation/pages/profile_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 85,

      leading: _buildOrangeLogo(),

      actions: [_buildProfileAvatar(context), const SizedBox(width: 16)],
    );
  }

  Widget _buildOrangeLogo() {
    return Center(
      child: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
    );
  }

  Widget _buildProfileAvatar(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: appColors.avatarPlaceholder,
            border: Border.all(color: appColors.dividerColor, width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=256',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.person, color: appColors.iconDefault);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}