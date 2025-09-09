import 'package:flutter/material.dart';
import 'editprofile_screen.dart';
import 'contact_us_screen.dart';
import 'social_account_screen.dart';
import 'refer_screen.dart';
import 'housify_home_screen.dart';
import 'offers_screen.dart';
import 'history_screen.dart';
import 'notification_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3; // Profile tab selected

  void _onNavItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HousifyHomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HistoryScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OffersScreen()),
        );
        break;
      case 3:
      // Already on ProfileScreen
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2526), // Black background
      body: Column(
        children: [
          // Custom AppBar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🔥 App icon instead of back arrow
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HousifyHomeScreen()),
                      );
                    },
                    child: Image.asset(
                      'assets/app_icon.png', // Apna logo ka path do
                      height: 32,
                      width: 32,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      const Icon(Icons.notifications,
                          color: Colors.white, size: 28),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // White Rounded Container
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Picture & Email
                    Center(
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0xFFFF7043),
                            child: Icon(Icons.person,
                                size: 50, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'uiuxseju@email.com',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFFFF7043)),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const EditProfileScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF7043),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Edit',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // GENERAL
                    _sectionTitle('GENERAL'),
                    _profileTile(Icons.credit_card, 'Payment Methods',
                        'Add your credit & debit cards', onTap: () {}),
                    _profileTile(Icons.location_on, 'Locations',
                        'Add your home & work locations', onTap: () {}),
                    _profileTile(Icons.account_circle, 'Add Social Account',
                        'Add Facebook, Instagram, Twitter etc',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                const AddSocialAccountsScreen()),
                          );
                        }),
                    _profileTile(Icons.share, 'Refer to Friends',
                        'Get rewards for referring friends', onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ReferScreen()),
                          );
                        }),
                    const SizedBox(height: 24),
                    // NOTIFICATIONS
                    _sectionTitle('NOTIFICATIONS'),
                    _switchTile(
                      title: 'Push Notifications',
                      subtitle: 'For daily update and others.',
                      icon: Icons.notifications,
                    ),
                    _switchTile(
                      title: 'Promotional Notifications',
                      subtitle: 'New Campaign & Offers',
                      icon: Icons.campaign,
                    ),
                    const SizedBox(height: 24),
                    // MORE
                    _sectionTitle('MORE'),
                    _profileTile(Icons.contact_phone, 'Contact Us',
                        'For more information', onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ContactUsScreen()),
                          );
                        }),
                    _profileTile(Icons.logout, 'Logout', '', onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const HousifyHomeScreen()),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),

          // Bottom NavBar
          Container(
            height: 70,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavItem(Icons.home, 'Home', 0, () {
                  _onNavItemTapped(0);
                }),
                _buildBottomNavItem(Icons.history, 'History', 1, () {
                  _onNavItemTapped(1);
                }),
                _buildBottomNavItem(Icons.local_offer, 'Offers', 2, () {
                  _onNavItemTapped(2);
                }),
                _buildBottomNavItem(Icons.person, 'Profile', 3, () {
                  _onNavItemTapped(3);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFF7043),
      ),
    );
  }

  Widget _profileTile(IconData icon, String title, String subtitle,
      {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      trailing:
      const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _switchTile(
      {required String title,
        required String subtitle,
        required IconData icon}) {
    return SwitchListTile(
      title: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
              maxLines: 2,
              overflow:TextOverflow.ellipsis,
              title),
        ],
      ),
      subtitle: Text(subtitle),
      value: true,
      onChanged: (bool value) {},
      activeColor: const Color(0xFFFF7043),
    );
  }

  Widget _buildBottomNavItem(
      IconData icon, String label, int index, VoidCallback onTap) {
    Color color = _selectedIndex == index ? Colors.orange : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
