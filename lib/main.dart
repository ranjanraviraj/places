import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './providers/great_places.dart';
import './screens/place_list_screen.dart';
import './screens/add_new_place_screen.dart';
import './screens/place_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatePlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlaceListScreen(),
        routes: {
          AddNewPlace.routeName: (ctx) => AddNewPlace(),
          PlaceDetail.routeName : (ctx) => PlaceDetail(),
        },
      ),
    );
  }
}
