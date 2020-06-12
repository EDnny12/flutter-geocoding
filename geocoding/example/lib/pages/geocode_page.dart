import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class GeocodeWidget extends StatefulWidget {
  @override
  _GeocodeWidgetState createState() => _GeocodeWidgetState();
}

class _GeocodeWidgetState extends State<GeocodeWidget> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  String _output = '';

  @override
  void initState() {
    _addressController.text = "Gronausestraat 710, Enschede";
    _latitudeController.text = '52.2165157';
    _longitudeController.text = '6.9437819';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                autocorrect: false,
                controller: _latitudeController,
                decoration: InputDecoration(
                  hintText: 'Latitude',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextField(
                autocorrect: false,
                controller: _longitudeController,
                decoration: InputDecoration(
                  hintText: 'Longitude',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        Center(
          child: RaisedButton(
              child: Text('Look up address'),
              onPressed: () {
                final latitude = double.parse(_latitudeController.text);
                final longitude = double.parse(_longitudeController.text);

                placemarkFromCoordinates(latitude, longitude)
                    .then((placemarks) {
                  final output = placemarks[0].toString();

                  print(placemarks[0].toString());
                  setState(() {
                    _output = output;
                  });
                });
              }),
        ),
        TextField(
          autocorrect: false,
          controller: _addressController,
          decoration: InputDecoration(
            hintText: 'Address',
          ),
          keyboardType: TextInputType.text,
        ),
        Center(
          child: RaisedButton(
              child: Text('Look up location'),
              onPressed: () {
                locationFromAddress(_addressController.text).then((locations) {
                  final output = locations[0].toString();

                  print(locations[0].toString());
                  setState(() {
                    _output = output;
                  });
                });
              }),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
            child: Text(_output),
          ),
        ),
      ],
    );
  }
}
