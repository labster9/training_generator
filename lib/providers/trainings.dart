import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'exercise.dart';

class TrainingItem with ChangeNotifier {
  final List<Exercise> exercises;
  final DateTime date;
  String id;

  TrainingItem({
    @required this.date,
    @required this.exercises,
    this.id,
  });
}

class Trainings with ChangeNotifier {
  List<TrainingItem> _trainings = [];
  final String authToken;
  final String userId;

  Trainings(this.authToken, this.userId, this._trainings);

  List<TrainingItem> get trainings {
    return [..._trainings];
  }

  Future<void> addTraining(TrainingItem ti) async {
    var urlFav =
        'https://training-generator-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken';
    final favoriteResponse = await http.get(urlFav);
    final favoriteData = json.decode(favoriteResponse.body);
    var url =
        'https://training-generator-default-rtdb.europe-west1.firebasedatabase.app/userTrainings/$userId.json?auth=$authToken';
    final response = await http.post(url,
        body: json.encode({
          'date': ti.date.toIso8601String(),
          'exercises': ti.exercises
              .map((ex) => {
                    'id': ex.id,
                    'title': ex.title,
                    'part': ex.part,
                    'description': ex.description,
                    'setsNumber': ex.setsNumber,
                    'repsNumber': ex.repsNumber,
                    'imageUrl': ex.imageUrl,
                    'isFavorite': (favoriteData.length - 1) < int.parse(ex.id)
                        ? false
                        : favoriteData[int.parse(ex.id)] ?? false,
                  })
              .toList()
        }));
    ti.id = json.decode(response.body)['name'];
    _trainings.add(ti);
    notifyListeners();
  }

  Future<void> fetchUserTrainings() async {
    var urlFav =
        'https://training-generator-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken';
    final favoriteResponse = await http.get(urlFav);
    final favoriteData = json.decode(favoriteResponse.body);
    var url =
        'https://training-generator-default-rtdb.europe-west1.firebasedatabase.app/userTrainings/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    final List<TrainingItem> loadedTrainings = [];
    extractedData.forEach((trainingId, trainingData) {
      loadedTrainings.add(
        TrainingItem(
            date: DateTime.parse(trainingData['date']),
            exercises: (trainingData['exercises'] as List<dynamic>)
                .map((exercise) => Exercise(
                      description: exercise['description'],
                      id: exercise['id'],
                      imageUrl: exercise['imageUrl'],
                      part: exercise['part'],
                      repsNumber: exercise['repsNumber'],
                      setsNumber: exercise['setsNumber'],
                      title: exercise['title'],
                      isFavorite: (favoriteData.length - 1) <
                              int.parse(exercise['id'])
                          ? false
                          : favoriteData[int.parse(exercise['id'])] ?? false,
                    ))
                .toList(),
            id: trainingId),
      );
    });
    _trainings = loadedTrainings;
    notifyListeners();
  }

  Future<void> removeTraining(TrainingItem ti) async {
    var url =
        'https://training-generator-default-rtdb.europe-west1.firebasedatabase.app/userTrainings/$userId/${ti.id}.json?auth=$authToken';
    await http.delete(url);
    _trainings.remove(ti);
    notifyListeners();
  }
}
