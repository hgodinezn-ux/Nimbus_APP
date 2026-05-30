import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_linked_list.dart';
import '../models/weather_node.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();

  final WeatherService weatherService = WeatherService();
  final WeatherLinkedList historyList = WeatherLinkedList();

  String cityName = '';
  String temperature = '';
  String description = '';
  String weatherIconCode = '';
  int totalSearches = 0;
  Map<String, int> cityCounter = {};
  IconData weatherIcon = Icons.wb_sunny;
  Color backgroundColor = Colors.blue;

  void fetchWeather() async {
    String getMostSearchedCity() {
      if (cityCounter.isEmpty) {
        return 'Sin datos';
      }

      String mostCity = '';

      int max = 0;

      cityCounter.forEach((city, count) {
        if (count > max) {
          max = count;

          mostCity = city;
        }
      });

      return mostCity;
    }

    try {
      final data = await weatherService.getWeather(_cityController.text);

      setState(() {
        cityName = data['name'];

        temperature = data['main']['temp'].toString();

        description = data['weather'][0]['description'];
        weatherIconCode = data['weather'][0]['icon'];
        String climate = description.toLowerCase();
        totalSearches++;
        if (cityCounter.containsKey(cityName)) {
          cityCounter[cityName] = cityCounter[cityName]! + 1;
        } else {
          cityCounter[cityName] = 1;
        }

        historyList.insert(cityName, temperature, description);

        if (climate.contains('cloud')) {
          weatherIcon = Icons.cloud;
          backgroundColor = Colors.grey;
        } else if (climate.contains('rain')) {
          weatherIcon = Icons.water_drop;
          backgroundColor = Colors.blueGrey;
        } else if (climate.contains('clear')) {
          weatherIcon = Icons.wb_sunny;

          backgroundColor = Colors.orange;
        } else {
          weatherIcon = Icons.cloud;

          backgroundColor = Colors.lightBlue;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error al consultar clima')));
    }
  }

  String getMostSearchedCity() {
    if (cityCounter.isEmpty) {
      return 'Sin datos';
    }

    String mostCity = '';

    int max = 0;

    cityCounter.forEach((city, count) {
      if (count > max) {
        max = count;

        mostCity = city;
      }
    });

    return mostCity;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(title: const Text('Consultar Clima')),

        body: SingleChildScrollView(
          child: Padding(
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
                  onPressed: fetchWeather,

                  child: const Text('Consultar'),
                ),

                const SizedBox(height: 30),
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),

                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Column(
                    children: [
                      weatherIconCode.isNotEmpty
                          ? Image.network(
                              'https://openweathermap.org/img/wn/$weatherIconCode@4x.png',
                              width: 120,
                              height: 120,
                            )
                          : const Icon(
                              Icons.cloud,
                              size: 100,
                              color: Colors.white,
                            ),

                      const SizedBox(height: 10),

                      Text(
                        cityName,

                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      Text(
                        '$temperature °C',

                        style: const TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),

                      Text(
                        description,

                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                const Text(
                  'Historial',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: historyList.getAll().length,
                    itemBuilder: (context, index) {
                      final item = historyList.getAll()[index];

                      return ListTile(
                        leading: const Icon(Icons.history),
                        title: Text(item.city),
                        subtitle: Text(
                          '${item.temperature} °C - ${item.description}',
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Total de consultas: $totalSearches',

                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Promedio temperatura: '
                  '${historyList.getAverageTemperature().toStringAsFixed(1)} °C',

                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Ciudad más consultada: '
                  '${getMostSearchedCity()}',

                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
