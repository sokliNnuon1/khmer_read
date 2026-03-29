import 'package:flutter/material.dart';
import 'package:khmer_read/module/Simple/FloatingHeaderExample.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool isNotification = true;
  String language = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      body: Column(
        children: [
          // 🔷 HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
              bottom: 25,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00519C), Color(0xFF3A7BD5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/300",
                  ), // placeholder
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "NUON SOKLIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Premium User",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ⚙️ SETTINGS CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 GENERAL
                  const Text(
                    "General",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildTile(
                    icon: Icons.person,
                    title: "Profile",
                    onTap: () {},
                  ),
                  _buildTile(
                    icon: Icons.person,
                    title: "Simple",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FloatingHeaderExample(),
                        ),
                      );
                    },
                  ),
                  _buildTile(
                    icon: Icons.lock,
                    title: "Change Password",
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Preferences",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildSwitchTile(
                    icon: Icons.dark_mode,
                    title: "Dark Mode",
                    value: isDarkMode,
                    onChanged: (val) {
                      setState(() => isDarkMode = val);
                    },
                  ),

                  _buildSwitchTile(
                    icon: Icons.notifications,
                    title: "Notifications",
                    value: isNotification,
                    onChanged: (val) {
                      setState(() => isNotification = val);
                    },
                  ),

                  _buildTile(
                    icon: Icons.language,
                    title: "Language",
                    trailing: Text(language),
                    onTap: () {
                      _showLanguageBottomSheet();
                    },
                  ),

                  const SizedBox(height: 20),

                  // 🔹 SUPPORT
                  const Text(
                    "Support",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  _buildTile(
                    icon: Icons.help_outline,
                    title: "Help Center",
                    onTap: () {},
                  ),

                  _buildTile(
                    icon: Icons.info_outline,
                    title: "About App",
                    onTap: () {},
                  ),

                  const SizedBox(height: 30),

                  // 🚪 LOGOUT
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF00519C)),
        title: Text(title),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        secondary: Icon(icon, color: const Color(0xFF00519C)),
        title: Text(title),
      ),
    );
  }

  void _showLanguageBottomSheet() {
    String tempLanguage = language;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return DraggableScrollableSheet(
              initialChildSize:
                  0.7, // 70% of screen is usually enough for beauty
              minChildSize: 0.5,
              maxChildSize: 0.95,
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Select Language",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          children: [
                            _languageItem(
                              "English",
                              tempLanguage,
                              (val) => setModalState(() => tempLanguage = val),
                            ),
                            _languageItem(
                              "Khmer",
                              tempLanguage,
                              (val) => setModalState(() => tempLanguage = val),
                            ),
                            _languageItem(
                              "Chinese",
                              tempLanguage,
                              (val) => setModalState(() => tempLanguage = val),
                            ),
                            _languageItem(
                              "French",
                              tempLanguage,
                              (val) => setModalState(() => tempLanguage = val),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () => language = tempLanguage,
                            );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00519C),
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            "Apply Language",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _languageItem(
    String lang,
    String currentTemp,
    Function(String) onSelect,
  ) {
    final isSelected = currentTemp == lang;

    return GestureDetector(
      onTap: () => onSelect(lang),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF00519C).withOpacity(0.05)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? const Color(0xFF00519C) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Text(
              lang == "English"
                  ? "🇺🇸"
                  : lang == "Khmer"
                  ? "🇰🇭"
                  : "🇨🇳",
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 15),
            Text(
              lang,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? const Color(0xFF00519C) : Colors.black87,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: Color(0xFF00519C)),
          ],
        ),
      ),
    );
  }
}
