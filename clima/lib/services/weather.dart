import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/networking_unsplash.dart';

const String apiKey = '5df6831635662edbb845c37279833081';
const String openWeatherMapURL =
    'https://api.openweathermap.org/data/2.5/weather';

const String apiKeyUnsplash = 'uRKKeDtBOfqtdN2FWykohK8WtIo6Xv4spP7ogG0pzu0';
const String unsplashURL = 'https://api.unsplash.com/search/photos';

class WeatherModel {
  Future<dynamic> getImageUrl(String cityName) async {
    Uri url =
        Uri.parse('$unsplashURL?query=$cityName&client_id=$apiKeyUnsplash');
    NetworkUnsplash networkUnsplash = NetworkUnsplash(url);

    var imageData = await networkUnsplash.getData();
    return imageData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    Uri url =
        Uri.parse('$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    Uri url = Uri.parse(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
