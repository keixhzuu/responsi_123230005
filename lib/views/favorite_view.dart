import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart';
import '../models/spell_model.dart';

class FavoriteSpellsView extends StatelessWidget {
  FavoriteSpellsView({super.key});
  final AppController controller = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E6CA),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF5F4339),
        elevation: 2,
        title: const Text(
          "My Spellbook",
          style: TextStyle(
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Color(0xFFF5E6CA),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFF5E6CA)),
          onPressed: () => Get.back(),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF5E6CA)),
      ),
      body: Obx(() {
        if (controller.favoriteSpells.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.auto_fix_off,
                  size: 80,
                  color: Color(0xFFD4A373),
                ),
                const SizedBox(height: 16),
                Text(
                  "Your spellbook is empty.",
                  style: TextStyle(
                    color: Colors.brown[400],
                    fontSize: 16,
                    fontFamily: 'Georgia',
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.favoriteSpells.length,
          itemBuilder: (context, index) {
            final rawSpell = controller.favoriteSpells[index];
            final Spell spell = Spell.fromJson(
              Map<String, dynamic>.from(rawSpell),
            );

            return Card(
              color: const Color(0xFFFFF9F0),
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                // Border cokelat tipis agar senada
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
                  backgroundColor: Color(0xFFE9EDC9), // Hijau sage soft
                  child: Icon(Icons.bolt, color: Color(0xFF5F4339)),
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
                    spell.use,
                    style: TextStyle(
                      color: Colors.brown[300],
                      fontFamily: 'Georgia',
                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    controller.removeFavoriteWithNotification(spell);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}