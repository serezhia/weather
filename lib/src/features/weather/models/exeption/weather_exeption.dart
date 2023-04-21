class WeatherExeption implements Exception {
  factory WeatherExeption.noConnection() {
    return WeatherExeption._(code: 0, message: 'No internet connection');
  }

  factory WeatherExeption.cityNotFound() {
    return WeatherExeption._(code: 4001, message: 'City not found');
  }
  factory WeatherExeption.weatherNotFound() {
    return WeatherExeption._(code: 4002, message: 'Weather not found');
  }

  factory WeatherExeption.unimplemented() {
    return WeatherExeption._(code: 999, message: 'Unimplemented exeption');
  }
  factory WeatherExeption.internetUnimplemented() {
    return WeatherExeption._(
      code: 9999,
      message: 'Internet unimplemented exeption',
    );
  }

  WeatherExeption._({required this.code, required this.message});

  final int code;
  final String message;
}
