import 'package:flutter/material.dart';

class ForecastNotFound extends StatelessWidget {
  const ForecastNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.black54,
      elevation: 3,
      child: Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.not_interested,
              color: Colors.red,
              size: 80,
            ),
            Text(
              "Pas de prévisions météo",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
