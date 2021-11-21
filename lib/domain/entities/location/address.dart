import 'state.dart';

class Address {
  /// AKA CEP in Brazil
  String postalCode;
  String address;
  String complement;
  State state;

  Address({
    required this.postalCode,
    required this.address,
    this.complement = "",
    required this.state,
  });
}
