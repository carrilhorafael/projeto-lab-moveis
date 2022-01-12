// https://stackoverflow.com/questions/27673781/enum-from-string/44060511
T enumFromString<T>(List<T> values, String value) {
  return values.firstWhere((v) => v.toString().split('.')[1] == value);
}

/// Meant to be used with enums to get only the variant's name
String enumToString<T>(T variant) {
  return variant.toString().split('.')[1];
}
