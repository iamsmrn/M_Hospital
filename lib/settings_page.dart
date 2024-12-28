import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget _buildSettingItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF00B894),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00B894),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/img_3.png'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Frank Lewis',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'franklewis79@gmail.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSettingItem('Account', Icons.person_outline),
          _buildSettingItem('Notification', Icons.notifications_none),
          _buildSettingItem('Appearance', Icons.remove_red_eye_outlined),
          _buildSettingItem('Privacy & Security', Icons.security_outlined),
          _buildSettingItem('Sound', Icons.volume_up_outlined),
          _buildSettingItem('Language', Icons.language_outlined),
        ],
      ),
    );
  }
}