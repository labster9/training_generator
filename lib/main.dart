import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/trainings.dart';
import './providers/exercise_provider.dart';
import './providers/part_provider.dart';
import './providers/auth.dart';
import './screens/parts_overview_screen.dart';
import './screens/part_exercises.dart';
import './screens/exercise_detail_screen.dart';
import './screens/generator_screen.dart';
import './screens/generated_training.dart';
import './screens/tabs_screen.dart';
import './screens/user_trainings.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, PartProvider>(
          update: (ctx, auth, previousParts) => PartProvider(
            auth.token,
            previousParts == null ? [] : previousParts.parts,
          ),
          create: null,
        ),
        ChangeNotifierProxyProvider<Auth, ExerciseProvider>(
          update: (ctx, auth, previousExercises) => ExerciseProvider(
            auth.token,
            auth.userId,
            previousExercises == null ? [] : previousExercises.exercises,
          ),
          create: null,
        ),
        ChangeNotifierProxyProvider<Auth, Trainings>(
          update: (ctx, auth, previousTrainings) => Trainings(
            auth.token,
            auth.userId,
            previousTrainings == null ? [] : previousTrainings.trainings,
          ),
          create: null,
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'trainIT',
          theme: ThemeData(
            primaryColor: Colors.deepOrange,
            accentColor: Colors.deepOrangeAccent,
          ),
          home: auth.isAuth ? TabsScreen() : AuthScreen(),
          routes: {
            UserTrainings.routeName: (ctx) => UserTrainings(),
            TabsScreen.routeName: (ctx) => TabsScreen(),
            GeneratedTraining.routeName: (ctx) => GeneratedTraining(),
            GeneratorScreen.routeName: (ctx) => GeneratorScreen(),
            PartsOverviewScreen.routeName: (ctx) => PartsOverviewScreen(),
            PartExercises.routeName: (ctx) => PartExercises(),
            ExerciseDetailScreen.routeName: (ctx) => ExerciseDetailScreen(),
          },
        ),
      ),
    );
  }
}
