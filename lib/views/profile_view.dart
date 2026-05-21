import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final AppController controller = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E6CA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5F4339),
        title: const Text(
          "Profile",
          style: TextStyle(color: Color(0xFFF5E6CA)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5E6CA)),
          onPressed: () => Get.offAllNamed('/books'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFFF5E6CA)),
            onPressed: () {
              Get.offAllNamed('/login');
              Get.snackbar(
                "LogOut",
                "Berhasil Logout!",
                backgroundColor: const Color(0xFFA6332E),
                colorText: const Color.fromARGB(255, 255, 255, 255),
                icon: const Icon(Icons.auto_fix_normal),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50),
            const SizedBox(height: 20),
            Text(
              "Kazuha",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "oke mantap, aku cuma mau makan",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
