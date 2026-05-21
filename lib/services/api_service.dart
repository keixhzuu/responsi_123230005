import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String bookUrl =
      "https://potterapi-fedeperin.vercel.app/en/books";
  static const String spellUrl =
      "https://potterapi-fedeperin.vercel.app/en/spells";

  Future<List<dynamic>> getBooks() async {
    final response = await http.get(Uri.parse(bookUrl));
    return response.statusCode == 200 ? json.decode(response.body) : [];
  }

  Future<List<dynamic>> getSpells() async {
    final response = await http.get(Uri.parse(spellUrl));
    return response.statusCode == 200 ? json.decode(response.body) : [];
  }
}
