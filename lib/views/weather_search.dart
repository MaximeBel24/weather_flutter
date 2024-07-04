import 'package:flutter/material.dart';

class WeatherSearch extends StatelessWidget {
  final Function(String) onSubmitted;
  final TextEditingController textController = TextEditingController();

  WeatherSearch({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: textController,
          decoration: InputDecoration(
              hoverColor: Colors.white,
              suffixIconColor: Colors.white,
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  onSubmitted(textController.text);
                  textController.clear();
                },
              ),
              labelText: "Recherche de ville",
              labelStyle: const TextStyle(color: Colors.white),
              hintText: "Saisissez un nom de ville",
              hintStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                      color: Color(0xFFFFFFFF),
                      width: 1.0,
                      style: BorderStyle.solid))),
          onSubmitted: (newString) {
            FocusScope.of(context).unfocus();
            onSubmitted.call(newString);
            textController.clear();
          },
        ),
      ],
    );
  }
}
