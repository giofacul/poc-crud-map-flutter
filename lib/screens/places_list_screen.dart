import 'package:flutter/material.dart';
import 'package:poc_crud_app/providers/greate_places.dart';
import 'package:poc_crud_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                builder: (context, greatPlaces, child) => greatPlaces
                            .itemsCount ==
                        0
                    ? child!
                    : ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (context, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                    greatPlaces.getItemByIndex(i).image!),
                              ),
                              title: Text(greatPlaces.getItemByIndex(i).title!),
                              onTap: () {},
                            )),
                child: const Center(
                  child: Text('Nenhum Local Cadastrado'),
                ),
              ),
      ),
    );
  }
}
