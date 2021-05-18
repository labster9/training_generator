import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/trainings.dart';
import '../widgets/exercise_item.dart';
import '../widgets/main_drawer.dart';

class GeneratedTraining extends StatelessWidget {
  static const routeName = '/generated-training';

  @override
  Widget build(BuildContext context) {
    final training = ModalRoute.of(context).settings.arguments as TrainingItem;
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated training'),
      ),
      drawer: MainDrawer(),
      body: ListView.builder(
        itemCount: training.exercises.length,
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          // create: (c) => partExercises[index],
          value: training.exercises[index],
          child: Column(
            children: [
              ExerciseItem(
                  // partExercises[index].id,
                  // partExercises[index].title,
                  // partExercises[index].imageUrl,
                  ),
              Divider(color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
