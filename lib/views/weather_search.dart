import 'package:flutter/material.dart';

class WeatherSearch extends StatelessWidget {
  final Function(String) onSubmitted;

  const WeatherSearch({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Saisissez un nom de ville",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
      onSubmitted: (newString) {
        onSubmitted.call(newString);
      },
    );
  }
}
