import 'package:flutter/material.dart';
import 'package:poc_crud_app/providers/greate_places.dart';
import 'package:poc_crud_app/screens/places_form_screen.dart';
import 'package:poc_crud_app/screens/places_list_screen.dart';
import 'package:poc_crud_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: 'Um bom Lugar',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          primaryColor: Colors.amber
        ),
        home: const PlacesListScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (context) => const PlaceFormScreen(),
        },
      ),
    );
  }
}
