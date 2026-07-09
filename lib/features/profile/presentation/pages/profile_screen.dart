import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/profile/presentation/widgets/profile_header.dart';
import 'package:orange_hr_dev/features/profile/presentation/widgets/profile_info_section.dart';
import 'package:orange_hr_dev/features/profile/presentation/widgets/menu_option_tile.dart';
import 'package:orange_hr_dev/core/theme/app_colors_extension.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColors.primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),

            Center(
              child: ProfileHeader(
                imageUrl:
                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=256',
                name: 'Mohammed Omar',
                jobTitle: 'Lead UX/UI',
              ),
            ),

            SizedBox(height: 28),

            ProfileInfoSection(
              email: 'mohammed.a.omar@orange.com',
              mobile: '0776804730',
              unit: 'CBU',
              organization: 'Digital Sales Directorate',
              address: 'Amman, Digital Village',
            ),

            SizedBox(height: 28),

            MenuOptionTile(title: 'My Qualification'),

            SizedBox(height: 24),
            MenuOptionTile(title:"jte emp assets"),
          ],
        ),
      ),
    );
  }
}