import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/exercise.dart';
import '../providers/auth.dart';
import '../screens/exercise_detail_screen.dart';

class ExerciseItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ExerciseItem(this.id, this.title, this.imageUrl);

  void selectExercise(BuildContext context, String arg) {
    Navigator.of(context).pushNamed(
      ExerciseDetailScreen.routeName,
      arguments: arg,
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercise = Provider.of<Exercise>(context);
    final authData = Provider.of<Auth>(context, listen: false);
    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
      //width: double.infinity,
      height: 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => selectExercise(context, exercise.id),
                child: Image.network(
                  exercise.imageUrl,
                  height: 90,
                  width: 90,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () => selectExercise(context, exercise.id),
                    child: Text(
                      exercise.title,
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  icon: exercise.isFavorite
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    exercise.toggleFavorite(authData.token, authData.userId);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
