import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_loginui/models/weathermodel.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {
      'q': city,
      'appid': 'd2c557e2fb0a15a77dd9aaf2f184919e',
      'units': 'metric'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}

//https://api.openweathermap.org/data/2.5/weather?q=pokhara&appid=d2c557e2fb0a15a77dd9aaf2f184919e