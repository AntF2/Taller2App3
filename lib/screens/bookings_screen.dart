import 'package:flutter/material.dart';
import 'package:taller2_corregido/screens/destination.dart';

class BookingsScreen extends StatelessWidget {
  final List<Destination> destinations;

  const BookingsScreen({super.key, required this.destinations});

  @override
  Widget build(BuildContext context) {
    final bookings = destinations;

    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final destination = bookings[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0), // Espacio vertical entre elementos
          child: ListTile(
            leading: Image.network(destination.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(destination.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingDetailScreen(destination: destination),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class BookingDetailScreen extends StatelessWidget {
  final Destination destination;

  const BookingDetailScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destination.name),
      ),
      body: Center(
        child: Hero(
          tag: destination.name,
          child: Image.network(destination.imageUrl),
        ),
      ),
    );
  }
}
