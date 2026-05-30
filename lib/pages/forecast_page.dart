import 'package:flutter/material.dart';
import '../services/forecast_service.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final TextEditingController _cityController = TextEditingController();

  final ForecastService forecastService = ForecastService();

  List<dynamic> forecastList = [];

  void fetchForecast() async {
    try {
      final data = await forecastService.getForecast(_cityController.text);

      setState(() {
        forecastList = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al obtener pronóstico')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pronóstico')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: _cityController,

              decoration: const InputDecoration(
                labelText: 'Ingrese ciudad',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: fetchForecast,

              child: const Text('Consultar Pronóstico'),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: forecastList.length > 10 ? 10 : forecastList.length,

                itemBuilder: (context, index) {
                  final item = forecastList[index];

                  final temp = item['main']['temp'];

                  final desc = item['weather'][0]['description'];

                  final date = item['dt_txt'];

                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        'https://openweathermap.org/img/wn/${item['weather'][0]['icon']}@2x.png',
                      ),
                      title: Text(
                        '$temp °C',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        '$desc\n$date',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
