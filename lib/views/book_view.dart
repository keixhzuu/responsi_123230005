import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/app_controller.dart';
import 'detail_book_view.dart';
import '../models/book_model.dart';

class BookView extends StatelessWidget {
  BookView({super.key});
  final AppController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.fetchBooks();

    return Scaffold(
      backgroundColor: const Color(0xFFF5E6CA),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF5F4339),
        elevation: 2,
        title: const Text(
          "Hogwarts Directory",
          style: TextStyle(
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Color(0xFFF5E6CA),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Color(0xFFF5E6CA)),
            onPressed: () => Get.toNamed('/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Color(0xFFF5E6CA)),
            onPressed: () {
              Get.offAllNamed('/login');
              Get.snackbar(
                "Logged Out",
                "Berhasil Logout!",
                backgroundColor: const Color(0xFFA6332E),
                colorText: const Color.fromARGB(255, 255, 255, 255),
                icon: const Icon(Icons.auto_fix_high),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.books.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF5F4339)),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.books.length,
          itemBuilder: (context, index) {
            final Book book = controller.books[index];

            return Card(
              color: const Color(0xFFFFF9F0),
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: const Color(0xFFD4A373), width: 2),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFD4A373),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFFE9EDC9),
                    backgroundImage: (book.cover.isNotEmpty)
                        ? NetworkImage(book.cover)
                        : null,
                  ),
                ),
                title: Text(
                  book.title,
                  style: const TextStyle(
                    color: Color(0xFF5F4339),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Icon(Icons.fort_rounded, size: 14),
                    const SizedBox(width: 5),
                    Text(
                      "Release Date: ${book.releaseDate}",
                      style: TextStyle(
                        color: const Color(0xFFD4A373),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFD4A373),
                  size: 16,
                ),
                onTap: () => Get.to(() => DetailBookView(book: book)),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.transparent,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD4A373),
            foregroundColor: const Color(0xFF5F4339),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 3,
          ),
          onPressed: () => Get.toNamed('/spells'),
          icon: const Icon(Icons.auto_fix_high),
          label: const Text(
            "EXPLORE SPELLS GALLERY",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
          ),
        ),
      ),
    );
  }
}
