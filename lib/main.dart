import 'package:flutter/material.dart';
import 'package:poc_crud_app/screens/places_form_screen.dart';
import 'package:poc_crud_app/screens/places_list_screen.dart';
import 'package:poc_crud_app/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Um bom Lugar',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber
      ),
      home: const PlacesListScreen(),
      routes: {
        AppRoutes.PLACE_FORM: (context) => const PlaceFormScreen(),
      },
    );
  }
}
