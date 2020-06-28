import 'package:flutter/material.dart';

import '../models/places.dart';
import '../screens/place_details_screen.dart';

class PlaceItems extends StatelessWidget {

final Place items;

  PlaceItems(
    this.items,
    Key key
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
          leading: CircleAvatar(
            backgroundImage:
                FileImage(items.image),
          ),
          title: Text(items.title),
          subtitle: Text(items.location.address),
          onTap: () {
            Navigator.of(context).pushNamed(PlaceDetail.routeName, arguments: items.id);
          },
        );
  }
}