import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'controllers/app_controller.dart';
import 'views/login_view.dart';
import 'views/book_view.dart';
import 'views/spell_view.dart';
import 'views/favorite_view.dart';
import 'views/profile_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('favorite_spells');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Harry Potter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      // Inisialisasi Controller di sini agar tersedia di semua halaman
      initialBinding: BindingsBuilder(() {
        Get.put(AppController());
      }),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/books', page: () => BookView()),
        GetPage(name: '/spells', page: () => SpellsView()),
        GetPage(name: '/favorites', page: () => FavoriteSpellsView()),
        GetPage(name: '/profile', page: () => ProfileView()),
      ],
    );
  }
}