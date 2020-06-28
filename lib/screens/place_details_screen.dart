import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import './map_screen.dart';

class PlaceDetail extends StatelessWidget {
  static const String routeName = '/place-details';

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatePlaces>(context, listen: false).getPlace(placeId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            width: double.infinity,
            height: 200,
          ),
          SizedBox(height: 10),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    initialLocation: selectedPlace.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
            child: Text('View On Map'),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
