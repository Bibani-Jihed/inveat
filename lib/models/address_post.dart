

import 'package:inveat/models/user_model.dart';
import 'package:meta/meta.dart';

class Address {
  String city;
  String country;
  String governerate;
  String street;
  int street_number;
  int zip_code;
  double latitude;
  double longitude;


  Address({
     this.city,
    this.country,
     this.governerate,
     this.street,
     this.street_number,
     this.zip_code,
     this.latitude,
     this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    if(json==null || json.isEmpty) return null;
    return Address(
      city: json['city'],
      country: json['country'],
      governerate: json['governerate'],
      street: json['street'],
      street_number: json['street_number'],
      zip_code: json['zip_code'],
      latitude: json['latitude'],
      longitude: json['longitude'],

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['country'] = this.country;
    data['governerate'] = this.governerate;
    data['street'] = this.street;
    data['street_number'] = this.street_number;
    data['zip_code'] = this.zip_code;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;

    return data;
  }
}
