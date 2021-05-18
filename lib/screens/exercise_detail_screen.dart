import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/exercise_provider.dart';

class ExerciseDetailScreen extends StatelessWidget {
  static const routeName = '/exercise-detail';

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildTxt(String txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
      child: Text(
        txt,
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey.shade800,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final exerciseId = ModalRoute.of(context).settings.arguments as String;
    final selectedExercise =
        Provider.of<ExerciseProvider>(context, listen: false)
            .exerciseSelector(exerciseId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedExercise.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedExercise.imageUrl,
              ),
            ),
            //Divider(color: Colors.black),
            buildTitle('PART'),
            buildTxt('${selectedExercise.part}'),
            Divider(color: Colors.black),
            buildTitle('SETS x REPS'),
            buildTxt(
                '${selectedExercise.setsNumber} x ${selectedExercise.repsNumber}'),
            Divider(color: Colors.black),
            buildTitle('EXECUTION'),
            buildTxt('${selectedExercise.description}'),
            Divider(color: Colors.black),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     'EXECUTION',
            //     style: TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
            //   child: Text(
            //     '${selectedExercise.description}',
            //     style: TextStyle(
            //       fontSize: 18,
            //       color: Colors.grey.shade800,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
