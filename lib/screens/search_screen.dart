import 'package:flutter/material.dart';
import 'package:taller2_corregido/screens/destination.dart';

// Lista de ciudades importantes del mundo
const List<String> _cities = <String>[
  'Nueva York', 'Londres', 'París', 'Tokio', 'Sídney', 'Los Ángeles', 'Roma', 'Barcelona', 'Berlín', 'Dubái',
  'Toronto', 'San Francisco', 'Hong Kong', 'Singapur', 'Ámsterdam', 'Madrid', 'Buenos Aires', 'São Paulo',
  'Moscú', 'Estambul', 'Seúl', 'Viena', 'Copenhague', 'Sao Paulo', 'Lima', 'Mexico City',
];

class SearchScreen extends StatefulWidget {
  final List<Destination> destinations;
  final ValueNotifier<Set<Destination>> favoritesNotifier;

  const SearchScreen({
    super.key,
    required this.destinations,
    required this.favoritesNotifier,
  });

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  DateTimeRange? selectedDateRange;
  List<Destination> filteredDestinations = [];
  final TextEditingController _adultsController = TextEditingController();
  final TextEditingController _childrenController = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredDestinations = widget.destinations;
  }

  void _search() {
    int.tryParse(_adultsController.text);
    int.tryParse(_childrenController.text);

    setState(() {
      filteredDestinations = widget.destinations.where((destination) {
        // Lógica de filtrado si es necesario
        return true; // Reemplaza con la lógica real de filtrado
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  final String input = textEditingValue.text.toLowerCase();
                  if (input.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return _cities.where((city) => city.toLowerCase().contains(input));
                },
                onSelected: (String selectedCity) {
                  _searchController.text = selectedCity;
                },
                fieldViewBuilder: (BuildContext context, TextEditingController controller, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                  _searchController = controller;
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Buscar destinos',
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pasajeros para la reserva',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _adultsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Adultos',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      controller: _childrenController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Niños',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  final DateTimeRange? dateRange = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (dateRange != null) {
                    setState(() {
                      selectedDateRange = dateRange;
                    });
                  }
                },
                child: const Text('Seleccionar fechas'),
              ),
            ),
            if (selectedDateRange != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Seleccionar fechas: ${selectedDateRange!.start.toLocal()} - ${selectedDateRange!.end.toLocal()}',
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  int.tryParse(_adultsController.text);
                  int.tryParse(_childrenController.text);

                  // Usa los valores para filtrar o realizar otras acciones
                  _search();
                },
                child: const Text('Buscar'),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Lugares favoritos',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: filteredDestinations.length,
                itemBuilder: (context, index) {
                  final destination = filteredDestinations[index];
                  final isFavorite = widget.favoritesNotifier.value.contains(destination);
                  return Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(destination.imageUrl, fit: BoxFit.cover),
                        ),
                        Text(destination.name),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isFavorite) {
                                widget.favoritesNotifier.value.remove(destination);
                              } else {
                                widget.favoritesNotifier.value.add(destination);
                              }
                            });
                            // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                            widget.favoritesNotifier.notifyListeners();
                          },
                        ),
                      ],
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
