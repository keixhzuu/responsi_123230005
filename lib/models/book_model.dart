class Book {
  final int number;
  final String title;
  final String originalTitle;
  final String releaseDate;
  final String description;
  final String cover;
  final int pages;
  final int index;

  Book({
    required this.number, 
    required this.title, 
    required this.originalTitle,
    required this.releaseDate,
    required this.description,
    required this.cover, 
    required this.pages,
    required this.index,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      // Nama kunci di JSON API adalah 'number'
      number: json['number'] != null ? int.parse(json['number'].toString()) : 0,
      // Nama kunci di JSON API adalah 'title'
      title: json['title'] ?? 'Unknown Title',
      // Nama kunci di JSON API adalah 'originalTitle'
      originalTitle: json['originalTitle'] ?? 'Unknown Original Title',
      // Nama kunci di JSON API adalah 'releaseDate'
      releaseDate: json['releaseDate'] ?? 'Unknown Release Date',
      // Nama kunci di JSON API adalah 'cover'
      cover: json['cover'] ?? '',
      // Nama kunci di JSON API adalah 'description'
      description: json['description'] ?? 'Unknown Description',
      // Nama kunci di JSON API adalah 'pages'
      pages: json['pages'] != null ? int.parse(json['pages'].toString()) : 0,
      // Nama kunci di JSON API adalah 'index'
      index: json['index'] != null ? int.parse(json['index'].toString()) : 0,
      // Nama kunci di JSON API adalah 'children' dan pastikan itu list string
    );
  }
}