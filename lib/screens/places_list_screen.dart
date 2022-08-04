import 'package:flutter/material.dart';
import 'package:poc_crud_app/providers/greate_places.dart';
import 'package:poc_crud_app/utils/app_routes.dart';
import 'package:poc_crud_app/utils/db_util.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatefulWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  State<PlacesListScreen> createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  DbUtil dbUtil = DbUtil();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text('Meus Lugares'),
                actions: [
                  Consumer<GreatPlaces>(
                    builder: (ctx, greatPlaces, ch) =>
                        greatPlaces.itemsCount == 0
                            ? Container()
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    dbUtil.deleteTodo();
                                  });
                                },
                                icon: const Icon(Icons.delete)),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
                      },
                      icon: const Icon(Icons.add))
                ],
              ),
              body: Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('Nenhum local cadastrado!'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.getItemByIndex(i).image!),
                          ),
                          title: Text(greatPlaces.getItemByIndex(i).title!),
                          subtitle: Text(
                              greatPlaces.getItemByIndex(i).location!.address!),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                AppRoutes.PLACE_DETAIL,
                                arguments: greatPlaces.getItemByIndex(i));
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                dbUtil.deletePlace(int.parse(
                                    greatPlaces.getItemByIndex(i).id!));
                              });
                            },
                          ),
                        ),
                      ),
              ),
            ),
    );
  }
}
