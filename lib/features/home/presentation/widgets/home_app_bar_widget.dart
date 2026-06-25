import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0, 
      scrolledUnderElevation: 0, 
      
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0), 
        child: _buildOrangeLogo(),
      ),
      leadingWidth: 56,
      
      actions: [
        _buildProfileAvatar(),
        const SizedBox(width: 16), 
      ],
    );
  }

  Widget _buildOrangeLogo() {
    return Center(
      child: Image.asset("assets/images/logo.jpg",height: 170,width: 170,)
    );
  }

  Widget _buildProfileAvatar() {
    return GestureDetector(
     
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200], 
          border: Border.all(
            color: Colors.grey[300]!, 
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=256', 
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.person, color: Colors.grey);
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}