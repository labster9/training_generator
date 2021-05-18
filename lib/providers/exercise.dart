import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Exercise with ChangeNotifier {
  final String id;
  final String part;
  final String title;
  final String imageUrl;
  final String description;
  final int setsNumber;
  final int repsNumber;
  bool isFavorite;

  Exercise({
    @required this.id,
    @required this.part,
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.setsNumber,
    @required this.repsNumber,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String authToken, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://training-generator-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userId/$id.json?auth=$authToken';
    try {
      final response = await http.put(
        url,
        body: json.encode(isFavorite),
      );
      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'part': this.part,
      'title': this.title,
      'imageUrl': this.imageUrl,
      'description': this.description,
      'setsNumber': this.setsNumber,
      'repsNumber': this.repsNumber,
      'isFavorite': this.isFavorite,
    };
  }
}
