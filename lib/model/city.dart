import 'package:xml/xml.dart';

class City {
  final String name;
  final String country;

  City({required this.name, required this.country});

  factory City.fromXml(XmlElement xml) {
    return City(
      name: xml.findElements('name').first.text,
      country: xml.findElements('countryCode').first.text,
    );
  }
}
