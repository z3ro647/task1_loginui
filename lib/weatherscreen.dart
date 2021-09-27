import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:task_loginui/weatherdataservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

final colorGreen = HexColor("#09b976");

class WeatherApi extends StatefulWidget {
  const WeatherApi({Key? key}) : super(key: key);

  @override
  _WeatherApiState createState() => _WeatherApiState();
}

class _WeatherApiState extends State<WeatherApi> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  String temperature = "";
  String weatherDescription = "Weather Description";
  String weatherIcon = "";
  String _cityName = "";

  void loadCityName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _cityTextController.text = (prefs.getString('CityName') ?? "");
      prefs.setString('CityName', _cityTextController.text);
    });
    _search();
  }

  @override
  void initState() {
    super.initState();
    loadCityName();
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      temperature = response.tempInfo.temperature.toString();
      weatherDescription = response.weatherInfo.description.toString();
      weatherIcon = response.iconUrl.toString();
      prefs.setString('CityName', response.cityName);
    });
    print('CityName: ' + response.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          if (weatherIcon == "")
            SizedBox(
              height: 150.0,
            ),
          if (weatherIcon != "")
            SizedBox(
              height: 150.0,
              child: Image.network(weatherIcon),
            ),
          Text(
            '$weatherDescription',
            textAlign: TextAlign.center,
          ),
          Text(
            'Temperature is: ',
            textAlign: TextAlign.center,
          ),
          Text(
            '$temperature',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: TextField(
              controller: _cityTextController,
              decoration: InputDecoration(labelText: 'City'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ElevatedButton(
              onPressed: _search,
              child: Text('Search'),
            ),
          ),
        ],
      ),
    );
  }
}
