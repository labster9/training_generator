import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './exercise.dart';

class ExerciseProvider with ChangeNotifier {
  List<Exercise> _exercises = [
    // Exercise(
    //   id: 'e1',
    //   title: 'Dip',
    //   part: 'Chest',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Dipexercise.svg/300px-Dipexercise.svg.png',
    //   description:
    //       'Stand between two handrails as their handles are directed perpendicular to your body.'
    //       ' In the first phase, jump on the handles and lift your body with your arms, straightening them.'
    //       ' Make a motion down, bending arms in elbows, as you would do a push up. During moving down, inhale, and exhale going up.'
    //       ' It is a hard exercise and requires a bit of experience. Elbows should be a bit distant from your torso. Torso should be leaning a bit.',
    //   setsNumber: 3,
    //   repsNumber: 10,
    // ),
    // Exercise(
    //   id: 'e2',
    //   title: 'Barbell bench press',
    //   part: 'Chest',
    //   imageUrl:
    //       'https://i1.sndcdn.com/artworks-000176216230-gizsh6-t500x500.jpg',
    //   description:
    //       'Lie on your back on a bench with a barbell grasped in both hands.'
    //       ' Lower the barbell to chest level, then press the barbell upwards, extending the arms until the elbows are locked out.'
    //       ' Inhale during lowering the barbell, exhale while pressing upwards.',
    //   setsNumber: 4,
    //   repsNumber: 8,
    // ),
    // Exercise(
    //   id: 'e3',
    //   title: 'Dumbbell incline bench press',
    //   part: 'Chest',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/6/6e/Dumbbell-incline-bench-press-2.png',
    //   description:
    //       'Hold a dumbbell in each hand, with hands positioned at your shoulders, elbows bent and angled down below your ribs.'
    //       ' Relax your neck against the bench. Keep your feet flat on the floor. Brace your core and press both dumbbells straight up over your chest as you exhale.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e4',
    //   title: 'Machine fly',
    //   part: 'Chest',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/8/87/Butterfly-machine-2.png',
    //   description:
    //       'Grip the handles keeping your shoulders down your chest out your feet firmly on the floor.'
    //       ' Back straight exhale as you bring the weights around like you\'re hugging a tree inhale on the return exhale.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e5',
    //   title: 'Chest fly',
    //   part: 'Chest',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/2/24/Dumbbell-flys-2.png',
    //   description:
    //       'Lie flat on your back on a bench holding 2 dumbbels, one in each hand.'
    //       ' Lift arms up above the head so they are extended but not locked out.'
    //       ' Inhale and slowly lower dumbbels in an arc motion until they are in line with the chest.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e6',
    //   title: 'Push up',
    //   part: 'Chest',
    //   imageUrl:
    //       'https://static.vecteezy.com/system/resources/previews/000/639/920/non_2x/vector-pushups-black-silhouette.jpg',
    //   description:
    //       'Get down on all fours, placing your hands slightly wider than your shoulders.'
    //       ' Straighten your arms and legs. Lower your body until your chest nearly touches the floor.'
    //       ' Pause, then push yourself back up.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e7',
    //   title: 'Deadlift',
    //   part: 'Back',
    //   imageUrl:
    //       'https://miro.medium.com/max/865/1*kgmZTXLpCjK2bWGkUBl7Jg@2x.png',
    //   description:
    //       'Stand with your mid-foot under the barbell. Bend over and grab the bar with a shoulder-width grip. Bend your knees until your shins touch the bar.'
    //       ' Lift your chest up and straighten your lower back. Take a big breath, hold it, and stand up with the weight.',
    //   setsNumber: 5,
    //   repsNumber: 5,
    // ),
    // Exercise(
    //   id: 'e8',
    //   title: 'Pull up',
    //   part: 'Back',
    //   imageUrl: 'https://i.stack.imgur.com/AY9Xl.png',
    //   description:
    //       'Stand directly below a pull-up bar. Place your hands in an overhand grip with your hands slightly further than shoulder-width apart.'
    //       ' Lift your feet up from the floor so that you are hanging from the bar and engage your core by pulling your belly button in toward your spine.'
    //       ' Bend your elbows and raise your upper body up toward the bar until your chin is over the bar. Avoid swinging your legs. '
    //       ' Extend your elbows and lower your body back down to the starting position.',
    //   setsNumber: 4,
    //   repsNumber: 8,
    // ),
    // Exercise(
    //   id: 'e9',
    //   title: 'Barbell row',
    //   part: 'Back',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/a/af/Barbell-rear-delt-row-2.png',
    //   description:
    //       'Stand with your mid-foot under the bar. Bend over and grab the bar. Unlock your knees while keeping your hips high. Lift your chest and straighten your back.'
    //       ' Pull the bar against your lower chest. Lower the bar to the floor.',
    //   setsNumber: 3,
    //   repsNumber: 10,
    // ),
    // Exercise(
    //   id: 'e10',
    //   title: 'Dumbbell row',
    //   part: 'Back',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/a/a9/Rear-deltoid-row-1.png',
    //   description:
    //       'Put your left leg on the bench and grab the far side with your left hand, then bend over so your upper body is parallel with the ground.'
    //       ' Reach down and pick up the dumbbell in your right hand with a neutral grip (palm facing you), then hold it with your arm extended, keeping your back straight.'
    //       ' Bring the dumbbell up to your chest, concentrating on lifting it with your back and shoulder muscles rather than your arms.'
    //       ' Keep your chest still as you lift. At the top of the movement, squeeze your shoulder and back muscles. Lower the dumbbell slowly until your arm is fully extended again.'
    //       ' Do all your reps on one arm before switching to the other side.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e11',
    //   title: 'Cable seated row',
    //   part: 'Back',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/4/4d/Cable-seated-rows-2.png',
    //   description:
    //       'Pull the handle and weight back toward the lower abdomen while trying not to use the momentum of the row too much by moving the torso backward with the arms.'
    //       ' Target the middle to upper back by keeping your back straight and squeezing your shoulder blades together as you row, chest out.'
    //       ' Return the handle forward under tension to full stretch, remembering to keep that back straight even though flexed at the hips.'
    //       ' Repeat the exercise for the desired number of repetitions.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e12',
    //   title: 'Hyperextensions',
    //   part: 'Back',
    //   imageUrl:
    //       'https://gym.dromosys.com/media/exercise-images/128/Hyperextensions-1.png',
    //   description:
    //       'Place your thighs on the pad. Bend your knees slightly and secure your feet, keeping them in line with your knees. Extend your arms toward the floor.'
    //       ' Exhale and move up until your shoulders, spine, and hips are in line. Engage your core and gently slide your shoulders back.'
    //       ' Inhale and bend down from your waist. Touch the floor.'
    //       ' Complete the desired number of reps and sets.',
    //   setsNumber: 3,
    //   repsNumber: 15,
    // ),
    // Exercise(
    //   id: 'e13',
    //   title: 'Overhead press',
    //   part: 'Shoulders',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/6/62/Seated-military-shoulder-press-1.png',
    //   description:
    //       'Stand or sit with the bar on your front shoulders, and your hands next to your shoulders.'
    //       ' Press the bar over your head, until it’s balanced over your shoulders.'
    //       ' Lock your elbows at the top, and shrug your shoulders to the ceiling.',
    //   setsNumber: 4,
    //   repsNumber: 8,
    // ),
    // Exercise(
    //   id: 'e14',
    //   title: 'Dumbbell press',
    //   part: 'Shoulders',
    //   imageUrl:
    //       'https://wger.de/media/exercise-images/123/dumbbell-shoulder-press-large-1.png',
    //   description:
    //       'Sit on an upright bench holding a dumbbell in each hand at shoulder height with your palms facing away from you.'
    //       ' Keep your chest up and your core braced, and look straight forward throughout the move.'
    //       ' Press the weights directly upwards until your arms are straight and the weights touch above your head.',
    //   setsNumber: 3,
    //   repsNumber: 15,
    // ),
    // Exercise(
    //   id: 'e15',
    //   title: 'Arnold press',
    //   part: 'Shoulders',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/5/56/Arnold-press-2.png',
    //   description:
    //       'Hold a dumbbell in each hand with your arm bent, as in the top of a biceps curl, so your palms are facing you.'
    //       ' Now, instead of pushing straight up, spread your arms to each side laterally, then press your arms up and twist your hands so your palms face forwards.'
    //       ' For full range of motion, finish by pushing your head forwards and reaching as high as you can so your biceps are close to your ears.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e16',
    //   title: 'Lateral raises',
    //   part: 'Shoulders',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/f/fd/Dumbbell-lateral-raises-1.png',
    //   description: 'Stand or sit with a dumbbell in each hand at your sides.'
    //       'Keep your back straight, brace your core, and then slowly lift the weights out to the side until your arms are parallel with the floor,'
    //       'with the elbow slightly bent.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e17',
    //   title: 'Dumbbell shrugs',
    //   part: 'Shoulders',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/5/54/Dumbbell-shrugs-1.png',
    //   description:
    //       'Assume a standing position with the dumbbells on both sides of your body.'
    //       ' Hinge forward, inhale, and grab the dumbbells with a neutral grip. Stand up tall and ensure your spine remains neutral.'
    //       ' Contract the traps to elevate the shoulders. Squeeze hard at the top and slowly lower the dumbbells back to the starting position.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e18',
    //   title: 'Dumbbell curls',
    //   part: 'Biceps',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/3/3c/Alternate-bicep-curl-2.png',
    //   description:
    //       'Stand holding a dumbbell in each hand with your arms hanging by your sides.'
    //       'Ensure your elbows are close to your torso and your palms facing forward.'
    //       'Keeping your upper arms stationary, exhale as you curl the weights up to shoulder level while contracting your biceps.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e19',
    //   title: 'Barbell curls',
    //   part: 'Biceps',
    //   imageUrl: 'https://www.gymwolf.com/images/exercises/1141_1.jpg',
    //   description:
    //       'Stand tall with your chest up and core braced, holding the barbell with your hands just outside of your hips, using an underhand grip.'
    //       ' Keeping your chest up and your elbows tight to your sides, initiate the move by raising your hands slightly so you feel your biceps become engaged.'
    //       ' While maintaining tension on your biceps, curl the bar up to shoulder height, then give your biceps a one-second squeeze.'
    //       ' Start to lower the bar slowly, keeping your biceps tensed and engaged to work as many muscle fibres as possible.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e20',
    //   title: 'Preacher barbell curls',
    //   part: 'Biceps',
    //   imageUrl:
    //       'https://www.pngitem.com/pimgs/m/201-2013505_biceps-drawing-workout-preacher-curl-drawing-hd-png.png',
    //   description:
    //       'Sit on the preacher bench and adjust the height so your armpits are just touching the top of the sloped section.'
    //       ' Hold the weight using an underhand grip (palms facing up) with your arms extended and your upper arms resting on the bench.'
    //       ' Curl the weight up, keeping your upper arms on the bench, until your forearms are vertical.'
    //       ' Pause for a second at the top of the curl, then slowly lower the weight until your arms are fully extended once again.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e21',
    //   title: 'Preacher hammer curls',
    //   part: 'Biceps',
    //   imageUrl:
    //       'https://www.steroizi.ro/public/upload/images/steroizi-ro_1Fri06December2013142426.jpg',
    //   description:
    //       'Select the desired weight from the rack, and sit in an upright position with your chest flat against the preacher bench.'
    //       ' Keep your upper arm pressed into the pad and use a neutral (palms facing up) grip.'
    //       ' Take a deep breath and slowly lower the dumbbell away from your shoulder.'
    //       ' Once the bicep is fully lengthened, curl the weight back to the starting position.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e22',
    //   title: 'Chin up',
    //   part: 'Biceps',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/b/bd/Chin-ups-1.png',
    //   description:
    //       'Stand under the bar. Put your hands on the bar with your palms facing your body.'
    //       ' Raise your body until your chin is above the bar. Avoid swinging your legs.'
    //       ' Using a slow, controlled motion, lower yourself until your arms are straight.',
    //   setsNumber: 5,
    //   repsNumber: 8,
    // ),
    // Exercise(
    //   id: 'e23',
    //   title: 'Reverse push up',
    //   part: 'Triceps',
    //   imageUrl:
    //       'https://noticias.minuto5.com/wp-content/uploads/2019/08/fondos-triceps.png',
    //   description:
    //       'Instead of having your hands on the floor, place your hands behind you on a bench or sturdy chair.'
    //       ' With your weight on your hands, lower yourself until your upper arms are almost parallel to the floor.'
    //       ' Push up until your arms are straight again. Repeat the move.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e24',
    //   title: 'Close grip push up',
    //   part: 'Triceps',
    //   imageUrl:
    //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJriQz1pEM_xxu7G6kg18Lsu6Dz5cymGgCxg&usqp=CAU',
    //   description:
    //       'The close grip push up is a variation of the push up that focuses on hitting the triceps.'
    //       ' Set up by placing your palms on the floor with your thumbs touching on another.'
    //       ' Bend slightly at the elbows to keep tension in your triceps.'
    //       ' Keeping your body straight, slowly lower yourself as far as possible without hitting the floor.'
    //       ' Pause, and then push back up to the starting position without locking your elbows out.',
    //   setsNumber: 3,
    //   repsNumber: 15,
    // ),
    // Exercise(
    //   id: 'e25',
    //   title: 'French press',
    //   part: 'Triceps',
    //   imageUrl:
    //       'https://www.seekpng.com/png/detail/966-9667965_exercises-to-avoid-aka-skullcrushers-lying-tricep-extension.png',
    //   description:
    //       'Grasp the barbell with an overhand grip (palms facing down) with your hands about 8-12 inches apart. Lie down on a bench.'
    //       ' Lift the bar above your head and bend at your elbows slightly to take the tension onto your triceps.'
    //       ' Your palms are now facing upward. This is the starting position for the exercise.'
    //       ' Slowly lower the bar down behind your head as far as comfortably possible. Pause, and then slowly raise the bar back to the starting position',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e26',
    //   title: 'Triceps kickback',
    //   part: 'Triceps',
    //   imageUrl:
    //       'https://i.pinimg.com/originals/92/da/5b/92da5b15d2d6cae98a661ecc0658b91c.png',
    //   description:
    //       'Stand holding a dumbbell in your hand. Lean forwards at your hips until your back is parallel to the ground or use a bench.'
    //       ' Your elbow should be bent at 90° so you’re holding the dumbbell in front of your torso.'
    //       ' Straighten your arm behind you, then reverse the movement to return to the starting position.',
    //   setsNumber: 3,
    //   repsNumber: 15,
    // ),
    // Exercise(
    //   id: 'e27',
    //   title: 'Straight bar extensions',
    //   part: 'Triceps',
    //   imageUrl:
    //       'https://gym.dstealth.com/all/arms/a_Reverse-Grip-Pushdowns.jpg',
    //   description:
    //       'Attach a straight bar to a cable stack as high as possible and assume a standing position.'
    //       ' Grasp the straight bar with palms facing down or up and lean forward slightly by hinging at the hips.'
    //       ' Pull the handle downward until the elbows are almost locked out and then slowly lower under control back to the starting position.',
    //   setsNumber: 3,
    //   repsNumber: 15,
    // ),
    // Exercise(
    //   id: 'e28',
    //   title: 'Squat',
    //   part: 'Legs',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/6/6f/Squats-2.png',
    //   description:
    //       'Stand with feet hip- or shoulder-width apart. Place the barbell just above the shoulders on the trapezius muscles (i.e., the "meaty" part of the shoulders).'
    //       ' Bend the knees and lower into a squat. Stop when your knees are at 90-degree angles or before you lose the natural arch of your back.'
    //       ' Contract the glutes and legs while stabilizing your body with a strong torso. Slowly stand back up without locking the knees.',
    //   setsNumber: 5,
    //   repsNumber: 5,
    // ),
    // Exercise(
    //   id: 'e29',
    //   title: 'Romanian deadlift',
    //   part: 'Legs',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/e/e8/Romanian-deadlift-1.png',
    //   description:
    //       'Use an overhand grip to hold the bar at hip level. Draw your shoulders back and keep your spine straight.'
    //       ' Push your hips back as you slowly lower the bar toward your feet.'
    //       ' Press your hips forward to come into a standing position with the barbell in front of your thighs.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e30',
    //   title: 'Leg extensions',
    //   part: 'Legs',
    //   imageUrl:
    //       'http://2.bp.blogspot.com/-fc_gJZeZB8A/VRL-q0eb0CI/AAAAAAAAALE/UbEZYSY4R-k/s1600/leg%2Bextension.png',
    //   description:
    //       'Sit up straight on the leg extension machine – imagine you have a seat belt pulling your waist into the seat.'
    //       ' Adjust the pad so it sits on top of your shins just above your feet, which should be pointing forward.'
    //       ' Hold the side bars. Ensuring that you are using your quads to power the movement, rather than kicking up with your feet,'
    //       ' extend your legs straight out in front of you. Then slowly lower them back to the starting position.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e31',
    //   title: 'Leg press',
    //   part: 'Legs',
    //   imageUrl: 'https://zelsh.com/wp-content/uploads/2013/09/Legpress.png',
    //   description:
    //       'When you sit down at a leg press machine, your body should be in a particular position.'
    //       ' Sit on the machine with your back and head resting comfortably against the padded support.'
    //       ' Place your feet on the footplate about hip-width apart while ensuring that your heels are flat.'
    //       ' Brace your abdominal muscles and push the platform away with your heels and forefoot.'
    //       ' While exhaling, extend your legs and keep your head and back flat against the seat pad.'
    //       ' While inhaling, return the footplate to the starting position by gradually bending the knees.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e32',
    //   title: 'Leg curls',
    //   part: 'Legs',
    //   imageUrl:
    //       'https://www.pngitem.com/pimgs/m/251-2512667_lying-leg-curl-diagram-hd-png-download.png',
    //   description:
    //       'Start by lying flat on your stomach. Adjust the roller pad so that it rests comfortably a few inches under your calves, just above the heels.'
    //       ' Stretch your legs out fully. On an inhale, lightly grasp the support handles on each side of the machine.'
    //       ' Lift your feet smoothly as you exhale, keeping your hips firmly on the bench.'
    //       ' Inhale as you flex your knees and pull your ankles as close to your buttocks as you can.'
    //       ' Hold this position for a beat, allowing yourself to make sure you are focused as you prepare to lower your legs.'
    //       ' Inhale fully as you return your feet to starting position in a smooth, slow, controlled movement.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e34',
    //   title: 'Reverse barbell curl',
    //   part: 'Forearms',
    //   imageUrl:
    //       'https://www.thehealthsite.com/wp-content/uploads/2013/03/reverse-grip-barbell-curls.gif',
    //   description:
    //       'The reverse barbell curl is similar to the classic barbell curl; the only difference being that instead of up, your palms are facing down.'
    //       ' Stand straight with your legs as wide as you hold a shoulder-wide grip with palms facing down.'
    //       ' With your elbows side by side raise the barbell as high as you can and then lower until your arms are fully extended.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e35',
    //   title: 'Free bar hang',
    //   part: 'Forearms',
    //   imageUrl:
    //       'https://gymjp.com/wp-content/uploads/2014/09/expullupsbottom.gif',
    //   description:
    //       'Simply grasp the bar with an overhand grip and perform a free body overhang. Try to relax muscles which are not engaged in a grip.'
    //       ' Stay in this position until your forearms will not allow you to anymore.',
    //   setsNumber: 3,
    //   repsNumber: 1,
    // ),
    // Exercise(
    //   id: 'e36',
    //   title: 'Wrist curls',
    //   part: 'Forearms',
    //   imageUrl:
    //       'https://gymjp.com/wp-content/uploads/2014/10/exwristcurlsbottom.gif',
    //   description:
    //       'Sitting on a bench, grab a barbell with your palms facing up and your hands shoulder-width apart.'
    //       ' Rest your forearms on your thighs, and allow your wrists to hang over your knees. You can also place your forearms on a bench.'
    //       ' Perform the movement by curling your palms and wrists toward your face.',
    //   setsNumber: 3,
    //   repsNumber: 15,
    // ),
    // Exercise(
    //   id: 'e37',
    //   title: 'Leg raises',
    //   part: 'ABS',
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Leg-raises-1.png/250px-Leg-raises-1.png',
    //   description: 'Lie on your back, legs straight and together.'
    //       'Keep your legs straight and lift them all the way up to the ceiling until your butt comes off the floor.'
    //       ' Slowly lower your legs back down till they are just above the floor. Hold for a moment. Raise your legs back up. Repeat.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e38',
    //   title: 'Hip raises',
    //   part: 'ABS',
    //   imageUrl:
    //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZuCBdmNFSdy1FHbDRPHWdYMXpoZuG25e34w&usqp=CAU',
    //   description: 'Lie flat on the floor with your arms at your sides.'
    //       'Bend your knees at approximately a 75 degree angle. Lift your feet 2 inches off the floor.'
    //       ' Use your lower abs to bring your knees towards you, keeping your legs bent. Continue moving your legs up until your hips are raised off the floor.'
    //       ' Breathe out while rolling your hips forward and doing so. When you are finished, your knees will be positioned over your chest.'
    //       ' Once you get to the top of the movement, squeeze your abs for a second. Return to the starting position as you slowly breathe in.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
    // Exercise(
    //   id: 'e39',
    //   title: 'Crunches',
    //   part: 'ABS',
    //   imageUrl:
    //       'https://www.fitforflight.org/wp-content/uploads/2018/02/crunches-1.jpg',
    //   description:
    //       'Lie down on your back. Plant your feet on the floor, hip-width apart. Bend your knees and place your arms across your chest. Contract your abs and inhale.'
    //       ' Exhale and lift your upper body, keeping your head and neck relaxed.'
    //       ' Inhale and return to the starting position.',
    //   setsNumber: 3,
    //   repsNumber: 20,
    // ),
    // Exercise(
    //   id: 'e40',
    //   title: 'Barbell roll out',
    //   part: 'ABS',
    //   imageUrl:
    //       'https://www.makeoverfitness.com/images/ab-rollout-on-knees-finish.gif',
    //   description:
    //       'Place an exercise mat under your knees and get into a kneeling position. Place a barbell on the floor and grab it with an overhand grip,'
    //       'your hands shoulder-width apart. Your shoulders should be directly over the barbell. This is your starting position.'
    //       ' Keeping your knees in a fixed position, roll the bar out in front of you until your arms fully extend in front of your body.'
    //       ' Pause, reverse the direction back to the starting position.',
    //   setsNumber: 3,
    //   repsNumber: 12,
    // ),
  ];

  final authToken;
  final userId;

  ExerciseProvider(this.authToken, this.userId, this._exercises);

  List<Exercise> get exercises {
    return [..._exercises];
  }

  void exercisesToDatabase() {
    const url =
        'https://training-generator-default-rtdb.europe-west1.firebasedatabase.app/exercises.json';
    http.post(url, body: json.encode(_exercises));
  }

  Future<void> fetchExercises() async {
    var url =
        'https://training-generator-default-rtdb.europe-west1.firebasedatabase.app/exercises.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://training-generator-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      // print(favoriteData);
      final List<Exercise> loadedExercises = [];
      extractedData.forEach((exid, data) {
        data.forEach((e) => loadedExercises.add(Exercise(
              title: e['title'],
              description: e['description'],
              id: e['id'],
              part: e['part'],
              setsNumber: e['setsNumber'],
              repsNumber: e['repsNumber'],
              imageUrl: e['imageUrl'],
              isFavorite: (favoriteData.length - 1) < int.parse(e['id'])
                  ? false
                  : favoriteData[int.parse(e['id'])] ?? false,
            )));
      });
      _exercises = loadedExercises;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Exercise> get favExercises {
    return _exercises.where((ex) => ex.isFavorite).toList();
  }

  // selecting exercises for given part
  List<Exercise> partSelector(String part) {
    return _exercises.where((partName) => partName.part == part).toList();
  }

  // selecting exercise which was clicked on
  Exercise exerciseSelector(String id) {
    return _exercises.firstWhere((ex) => ex.id == id);
  }

  // filtering exercises depending on filters selected by user (taking random exercises from parts)
  List<Exercise> filterExercisesv2(Map<String, bool> filters) {
    List<Exercise> finalExercises = [];
    List<Exercise> temp = [];

    if (filters['chest']) {
      temp = partSelector('Chest');
      temp.shuffle();
      finalExercises = temp.sublist(0, 4);
      temp.clear();
    }
    if (filters['back']) {
      temp = partSelector('Back');
      temp.shuffle();
      finalExercises.addAll(temp.sublist(0, 4));
      temp.clear();
    }
    if (filters['shoulders']) {
      temp = partSelector('Shoulders');
      temp.shuffle();
      finalExercises.addAll(temp.sublist(0, 4));
      temp.clear();
    }
    if (filters['biceps']) {
      temp = partSelector('Biceps');
      temp.shuffle();
      finalExercises.addAll(temp.sublist(0, 4));
      temp.clear();
    }
    if (filters['triceps']) {
      temp = partSelector('Triceps');
      temp.shuffle();
      finalExercises.addAll(temp.sublist(0, 4));
      temp.clear();
    }
    if (filters['legs']) {
      temp = partSelector('Legs');
      temp.shuffle();
      finalExercises.addAll(temp.sublist(0, 4));
      temp.clear();
    }
    if (filters['forearms']) {
      temp = partSelector('Forearms');
      temp.shuffle();
      finalExercises.addAll(temp.sublist(0, 2));
      temp.clear();
    }
    if (filters['abs']) {
      temp = partSelector('ABS');
      temp.shuffle();
      finalExercises.addAll(temp.sublist(0, 3));
      temp.clear();
    }
    return finalExercises.toList();
  }
}
