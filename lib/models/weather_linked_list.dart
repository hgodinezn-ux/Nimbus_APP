import 'weather_node.dart';

class WeatherLinkedList {
  WeatherNode? head;

  // INSERTAR
  void insert(String city, String temperature, String description) {
    WeatherNode newNode = WeatherNode(city, temperature, description);

    if (head == null) {
      head = newNode;
    } else {
      WeatherNode current = head!;

      while (current.next != null) {
        current = current.next!;
      }

      current.next = newNode;
    }
  }

  // RECORRER
  List<WeatherNode> getAll() {
    List<WeatherNode> list = [];

    WeatherNode? current = head;

    while (current != null) {
      list.add(current);

      current = current.next;
    }

    return list;
  }

  // PROMEDIO
  double getAverageTemperature() {
    if (head == null) {
      return 0;
    }

    double total = 0;

    int count = 0;

    WeatherNode? current = head;

    while (current != null) {
      total += double.parse(current.temperature);

      count++;

      current = current.next;
    }

    return total / count;
  }
}
