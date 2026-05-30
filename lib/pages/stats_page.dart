import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  final int totalSearches;
  final double averageTemp;
  final String mostSearchedCity;

  const StatsPage({
    super.key,
    required this.totalSearches,
    required this.averageTemp,
    required this.mostSearchedCity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Resumen General',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            Text(
              'Total de consultas: $totalSearches',
              style: const TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 20),

            Text(
              'Temperatura promedio: ${averageTemp.toStringAsFixed(1)} °C',
              style: const TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 20),

            Text(
              'Ciudad más consultada: $mostSearchedCity',
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
