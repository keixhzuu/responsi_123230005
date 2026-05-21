import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final AppController controller = Get.find<AppController>();
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan warna dasar krem parchment
      backgroundColor: const Color(0xFFF5E6CA),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFD4A373).withValues(alpha: 0.3),
              const Color(0xFFF5E6CA),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),

                const Icon(
                  Icons.auto_fix_high,
                  size: 80,
                  color: Color(0xFF5F4339),
                ),
                const SizedBox(height: 20),
                const Text(
                  "HOGWARTS",
                  style: TextStyle(
                    color: Color(0xFF5F4339),
                    fontSize: 32,
                    fontFamily: 'Georgia',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                const Text(
                  "Book Directory",
                  style: TextStyle(
                    color: Color(0xFFB08968),
                    fontSize: 16,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 50),

                // Field Username
                _buildTextField(
                  controller: userCtrl,
                  label: "Username",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),

                // Field Password
                _buildTextField(
                  controller: passCtrl,
                  label: "Password",
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5F4339),
                      foregroundColor: const Color(0xFFF5E6CA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () =>
                        controller.login(userCtrl.text, passCtrl.text),
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Forget your password? Send an owl.",
                  style: TextStyle(
                    color: Colors.brown[400],
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Georgia',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Color(0xFF5F4339)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFB08968)),
        prefixIcon: Icon(icon, color: const Color(0xFFB08968)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFD4A373), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF5F4339), width: 2),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.4),
      ),
    );
  }
}
