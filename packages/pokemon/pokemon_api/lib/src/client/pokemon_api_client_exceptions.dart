class HttpException implements Exception {}

class HttpRequestException implements Exception {
  const HttpRequestException(this.statusCode);

  final int statusCode;
}

class JsonDecodeException implements Exception {}

class JsonDeserializationException implements Exception {}
