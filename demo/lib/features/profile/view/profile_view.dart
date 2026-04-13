import 'package:demo/core/constants/color_const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/profile_controller.dart';
import '../../../core/constants/text_const.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileController>().fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildOptionsList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Consumer<ProfileController>(
      builder: (context, controller, child) {
        final user = controller.userData;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ColorConst.cardBg,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildProfileAvatar(user?.profilePicture),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'David Arnold',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:  ColorConst.white),
                          ),
                          Text(
                            user?.email ?? 'david012@cabzing',
                            style: const TextStyle(color: Color(0xFF5D9AFF), fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: ColorConst.white),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildStatCard(
                      icon: Icons.hub_outlined,
                      title: '${user?.rating ?? 4.3}',
                      icon2: Icons.star_border,
                      subtitle: '${user?.rides ?? 2211}\nrides',
                      color: const Color(0xFFB5CDFE),
                      iconColor: const Color(0xFF1B6AEE),
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      icon: Icons.verified_outlined,
                      title: 'KYC',
                      icon2: Icons.verified_outlined,
                      subtitle: 'Verified',
                      color: const Color(0xFFA9C9C5),
                      iconColor: const Color(0xFF125C43),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildLogoutButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileAvatar(String? url) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: const Icon(Icons.person, color: Colors.white, size: 40),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color iconColor,
    required IconData icon2,
  }) {
    return Expanded(
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 40,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: iconColor, size: 15),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    spacing: 3,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: color)),
                      Icon(icon2, color: ColorConst.white, size: 15),
                    ],
                  ),
                  Text(subtitle, style: const TextStyle(color: Color(0xFF5D9AFF), fontSize: 10)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<ProfileController>().logout(context),
      style: TextButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(24),
           side: const BorderSide(color: Colors.white10),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout_outlined, color: Color(0xFFFF5D5D), size: 18),
          SizedBox(width: 8),
          Text(
            'Logout',
            style: TextStyle(color: Color(0xFFFF5D5D), fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildOptionTile(Icons.help_outline, TextConst.profile['help']!),
          _buildOptionTile(Icons.quiz_outlined, TextConst.profile['faq']!),
          _buildOptionTile(Icons.people_outline, TextConst.profile['invite']!),
          _buildOptionTile(Icons.description_outlined, TextConst.profile['tos']!),
          _buildOptionTile(Icons.security_outlined, TextConst.profile['privacy']!),
        ],
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Color(0xffB5CDFE)),
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
      onTap: () {},
    );
  }
}
