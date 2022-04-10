// lib/api/json_parsers/json_parser.dart
library json_parser;

import 'dart:convert';

mixin ObjectDecoder<T> on JsonParser<T> {
  Map<String, dynamic> decodeJsonObject(String json) =>
      jsonDecode(json) as Map<String, dynamic>;
}
mixin ListDecoder<T> on JsonParser<T> {
  List<dynamic> decodeJsonList(String json) =>
      jsonDecode(json) as List<dynamic>;
}

abstract class JsonParser<T> {
  const JsonParser();
  Future<T> parseFromJson(String json);
}
