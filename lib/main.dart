import 'package:aspen_travelle/splashpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(

      options: const
      FirebaseOptions(
    apiKey: "AIzaSyBI-lKrdjcdyOou6z5BKYoFcmIiM57E0WA",
    appId: "1:448038904489:ios:9489c54c76fc155c603fb8",
    messagingSenderId: "448038904489",
    projectId: "aspen-travlle",
    storageBucket:  "aspen-travlle.appspot.com",


  )
  );





  runApp(const ProviderScope(child:MyApp() ) );
}

class MyApp extends StatefulWidget {



  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {




    return const MaterialApp(


      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

