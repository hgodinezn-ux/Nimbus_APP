import 'package:flutter/material.dart';
import 'pages/weather_page.dart';
import 'pages/stats_page.dart';
import 'pages/forecast_page.dart';
import 'pages/todo_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Nimbus APP"),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset('assets/logo.png', height: 140),
            ),

            const SizedBox(height: 20),

            const Text(
              "Bienvenido a Nimbus APP",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WeatherPage()),
                );
              },

              child: const Text("Consultar Clima"),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(builder: (context) => const TodoPage()),
                );
              },

              child: const Text('Tareas API'),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForecastPage()),
                );
              },

              child: const Text('Ver Pronóstico'),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cerrar Sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
