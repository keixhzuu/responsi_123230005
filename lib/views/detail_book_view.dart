import 'package:flutter/material.dart';
import '../models/book_model.dart';

class DetailBookView extends StatelessWidget {
  final Book book;
  const DetailBookView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tema Vintage Parchment
      backgroundColor: const Color(0xFFF5E6CA),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF5F4339),
        elevation: 2,
        iconTheme: const IconThemeData(color: Color(0xFFF5E6CA)),
        title: Text(
          book.title,
          style: const TextStyle(
            fontFamily: 'Georgia',
            fontWeight: FontWeight.bold,
            color: Color(0xFFF5E6CA),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // Border sekarang mengikuti warna house secara dinamis
                  border: Border.all(color: const Color(0xFFD4A373), width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4A373).withValues(alpha: 0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: book.cover.isNotEmpty
                      ? Image.network(
                          book.cover,
                          height: 350,
                          width: 250,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 350,
                          width: 250,
                          color: const Color(0xFFE9EDC9),
                          child: const Icon(
                            Icons.person,
                            size: 150,
                            color: Color(0xFF5F4339),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                color: const Color(0xFFFFF9F0),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  // Border kartu deskripsi juga mengikuti warna house
                  side: BorderSide(color: const Color(0xFFD4A373), width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        "Title",
                        book.title,
                        const Color(0xFFD4A373),
                      ),
                      const Divider(color: Colors.brown, thickness: 0.5),
                      _buildDetailRow(
                        "Original Title",
                        book.originalTitle,
                        const Color(0xFFD4A373),
                      ),
                      const Divider(color: Colors.brown, thickness: 0.5),
                      _buildDetailRow(
                        "Release Date",
                        book.releaseDate,
                        const Color(0xFFD4A373),
                      ),
                      const Divider(color: Colors.brown, thickness: 0.5),
                      _buildDetailRow(
                        "Pages",
                        book.pages.toString(),
                        const Color(0xFFD4A373),
                      ),
                      const Divider(color: Colors.brown, thickness: 0.5),
                      _buildDetailRow(
                        "Description",
                        book.description,
                        const Color(0xFFD4A373),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                letterSpacing: 1.1,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              value == null || value.isEmpty ? "-" : value,
              style: const TextStyle(
                color: Color(0xFF5F4339),
                fontSize: 16,
                fontFamily: 'Georgia',
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
