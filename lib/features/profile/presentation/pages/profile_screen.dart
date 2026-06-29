import 'package:flutter/material.dart';
import 'package:orange_hr_dev/features/profile/presentation/widgets/profile_header.dart';
import 'package:orange_hr_dev/features/profile/presentation/widgets/profile_info_section.dart';
import 'package:orange_hr_dev/features/profile/presentation/widgets/menu_option_tile.dart';

/// Profile screen showing the logged-in user's details.
///
/// Uses dummy data for now — in a real app these values would
/// come from a ProfileProvider or a User entity passed in.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),

            // --- Avatar + Name + Title ---
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
