import 'package:flutter/foundation.dart';

import './exercise.dart';

class Part with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final List<Exercise> partExercises;

  Part({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    this.partExercises,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "imageUrl": this.imageUrl,
      "partExercises": this.partExercises
    };
  }
}
