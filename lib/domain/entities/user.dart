import 'location/address.dart';

class User {
  String id;
  String name;
  Address address;
  String email;
  String phone;
  String description;

  User({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    this.description = "",
  });
}
