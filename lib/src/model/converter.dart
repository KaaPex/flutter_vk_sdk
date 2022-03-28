import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime?, int> {
  const DateTimeConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(DateTime? object) => object?.millisecondsSinceEpoch ?? -1;
}

class BooleanConverter implements JsonConverter<bool, int> {
  const BooleanConverter();

  @override
  bool fromJson(int json) => json <= 0 ? false : true;

  @override
  int toJson(bool object) => object == true ? 1 : 0;
}
