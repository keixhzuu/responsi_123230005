import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart';
import '../models/spell_model.dart';

class SpellsView extends StatelessWidget {
  SpellsView({super.key});
  final AppController controller = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    if (controller.spells.isEmpty) {
      controller.fetchSpells();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5E6CA),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF5F4339),
        elevation: 2,
        iconTheme: const IconThemeData(color: Color(0xFFF5E6CA)),
        title: const Text(
          "Spells Gallery",
          style: TextStyle(
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Color(0xFFF5E6CA),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Color(0xFFF5E6CA)),
            onPressed: () => Get.toNamed('/favorites'),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFFF5E6CA)),
            onPressed: () {
              Get.offAllNamed('/login');
              Get.snackbar(
                "Logged Out",
                "Mischief Managed!",
                backgroundColor: const Color(0xFFA6332E),
                colorText: const Color.fromARGB(255, 255, 255, 255),
                icon: const Icon(Icons.auto_fix_normal),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.spells.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF5F4339)),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.spells.length,
          itemBuilder: (context, index) {
            final Spell spell = controller.spells[index];
            

            return Card(
              // Card putih gading
              color: const Color(0xFFFFF9F0),
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: const Color(0xFFD4A373).withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFE9EDC9),
                  child: Icon(
                    Icons.auto_fix_high,
                    color: Color(0xFF5F4339),
                    size: 20,
                  ),
                ),
                title: Text(
                  spell.name,
                  style: const TextStyle(
                    color: Color(0xFF5F4339),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    spell.use ,
                    style: TextStyle(
                      color: Colors.brown[300],
                      fontFamily: 'Georgia',
                    ),
                  ),
                ),
                trailing: Obx(() {
                  bool isFav = controller.favoriteSpells.any(
                    (element) => element['spell'] == spell.name,
                  );
                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav
                          ? const Color(0xFFA6332E)
                          : Colors.brown[200],
                    ),
                    onPressed: () => controller.toggleFavorite(spell),
                  );
                }),
              ),
            );
          },
        );
      }),
    );
  }
}