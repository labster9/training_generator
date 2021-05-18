import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './part.dart';

class PartProvider with ChangeNotifier {
  List<Part> _parts = [
    // Part(
    //   id: 'p1',
    //   title: 'Chest',
    //   imageUrl:
    //       'https://i1.sndcdn.com/artworks-000176216230-gizsh6-t500x500.jpg',
    // ),
    // Part(
    //   id: 'p2',
    //   title: 'Back',
    //   imageUrl: 'https://i.stack.imgur.com/AY9Xl.png',
    // ),
    // Part(
    //   id: 'p3',
    //   title: 'Shoulders',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/5/56/Arnold-press-2.png',
    // ),
    // Part(
    //   id: 'p4',
    //   title: 'Biceps',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/3/3c/Alternate-bicep-curl-2.png',
    // ),
    // Part(
    //   id: 'p5',
    //   title: 'Triceps',
    //   imageUrl:
    //       'https://noticias.minuto5.com/wp-content/uploads/2019/08/fondos-triceps.png',
    // ),
    // Part(
    //   id: 'p6',
    //   title: 'Legs',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/6/6f/Squats-2.png',
    // ),
    // Part(
    //   id: 'p7',
    //   title: 'Forearms',
    //   imageUrl:
    //       'https://gymjp.com/wp-content/uploads/2014/10/exwristcurlsbottom.gif',
    // ),
    // Part(
    //   id: 'p8',
    //   title: 'ABS',
    //   imageUrl:
    //       'https://www.fitforflight.org/wp-content/uploads/2018/02/crunches-1.jpg',
    // ),
  ];

  final authToken;

  PartProvider(this.authToken, this._parts);

  List<Part> get parts {
    return [..._parts];
  }

  void partsToDatabase() {
    const url =
        'https://training-generator-default-rtdb.europe-west1.firebasedatabase.app/parts.json';
    http.post(url, body: json.encode(_parts, toEncodable: (e) => e.toJson()));
  }

  Future<void> fetchParts() async {
    final url =
        'https://training-generator-default-rtdb.europe-west1.firebasedatabase.app/parts.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Part> loadedParts = [];
      extractedData.forEach((exid, data) {
        data.forEach((e) => loadedParts.add(Part(
              id: e['id'],
              imageUrl: e['imageUrl'],
              title: e['title'],
            )));
      });
      _parts = loadedParts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
