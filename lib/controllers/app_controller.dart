import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../services/api_service.dart';
import '../models/book_model.dart';
import '../models/spell_model.dart';

class AppController extends GetxController {
  final ApiService _apiService = ApiService();
  var books = <Book>[].obs;
  // var spells = [].obs;
  var spells = <Spell>[].obs;
  var favoriteSpells = [].obs;
  late Box favoriteBox;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    favoriteBox = Hive.box('favorite_spells');
    loadFavorites();
    _initNotifications();
    fetchSpells();
  }

  Future<void> login(String user, String pass) async {
    if (user == "kazuha" && pass == "123230005") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Get.offAllNamed('/books');
      Get.snackbar(
        "Success",
        "Login Berhasil!",
        backgroundColor: const Color(0xFF2F5C33),
        colorText: const Color.fromARGB(255, 255, 255, 255),
        icon: const Icon(Icons.auto_fix_high),
      );
    } else {
      Get.snackbar(
        "Error",
        "Username/Password Salah",
        backgroundColor: const Color(0xFFA6332E),
        colorText: const Color.fromARGB(255, 255, 255, 255),
        icon: const Icon(Icons.error),
      );
    }
  }

  Future<void> fetchBooks() async {
    try {
      List<dynamic> dataMentah = await _apiService.getBooks();

      List<Book> listBuku = dataMentah
          .map((json) => Book.fromJson(json))
          .toList();

      books.assignAll(listBuku);
    } catch (e) {
      debugPrint("Error Fetching Books: $e");
    }
  }

  Future<void> fetchSpells() async {
    try {
      List<dynamic> dataMentah = await _apiService.getSpells();

      List<Spell> listSpell = dataMentah
          .map((json) => Spell.fromJson(json))
          .toList();

      spells.assignAll(listSpell);
    } catch (e) {
      debugPrint("Error Fetching Spells: $e");
    }
  }

  void toggleFavorite(Spell spell) {
    String key = spell.index.toString();

    if (favoriteBox.containsKey(key)) {
      favoriteBox.delete(key);
      Get.snackbar(
        "Removed",
        "${spell.name} dihapus",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 1),
        backgroundColor: const Color(0xFFA6332E),
        colorText: const Color.fromARGB(255, 255, 255, 255),
      );
    } else {
      favoriteBox.put(key, {
        'index': spell.index,
        'spell': spell.name,
        'use': spell.use,
      });
      Get.snackbar(
        "Added",
        "${spell.name} favorit!",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 1),
        backgroundColor: const Color(0xFF2F5C33),
        colorText: const Color.fromARGB(255, 255, 255, 255),
      );
    }

    loadFavorites();
    favoriteSpells.refresh();
  }

  void loadFavorites() {
    favoriteSpells.assignAll(List<dynamic>.from(favoriteBox.values.toList()));
  }

  void removeFavoriteWithNotification(dynamic spell) {
    String name = spell.name;
    String key = spell.index.toString();
    favoriteBox.delete(key);
    loadFavorites();
    _showNotification(name);
  }

  void _initNotifications() {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(android: androidSettings),
    );
  }

  Future<void> _showNotification(String spellName) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'fav_channel',
          'Favorite',
          importance: Importance.max,
          priority: Priority.high,
        );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Favorite Removed',
      'Spell $spellName telah dihapus',
      const NotificationDetails(android: androidDetails),
    );
  }
}
