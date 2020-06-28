import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_new_place_screen.dart';
import '../providers/great_places.dart';
import '../widget/place_items.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Great Places'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(AddNewPlace.routeName);
                }),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatePlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapShot) => snapShot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatePlaces>(
                  child: Center(
                    child: const Text('Got no places yet, start adding some!'),
                  ),
                  builder: (ctx, greatPlaceData, ch) =>
                      greatPlaceData.items.length <= 0
                          ? ch
                          : ListView.builder(
                              itemCount: greatPlaceData.items.length,
                              itemBuilder: (ctx, i) => PlaceItems(
                                greatPlaceData.items[i],
                                ValueKey(greatPlaceData.items[i].id),
                              ),
                            ),
                ),
        ));
  }
}
