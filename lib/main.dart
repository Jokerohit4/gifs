import 'package:flutter/material.dart';
import 'package:gifs/pages/home_page.dart';
import 'package:gifs/services/helper_methods.dart';

void main() {
  runApp(MyApp());
}



///I haven't any state management tool due to lack of time but provider was on mind
///I have given an idea of the kind of code structure I used but I could optimize the code
///as well as make it more readable with enough time
///app_route , provider, cubit and get_it were on mind
///haven't defined the themes but made the operation, so it prints on theme change

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _helper = HelperMethods();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: _helper.currentTheme,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}


