import 'package:flutter/material.dart';
import 'package:taller2_corregido/screens/destination.dart';

class FavoritesScreen extends StatelessWidget {
  final ValueNotifier<Set<Destination>> favoritesNotifier;

  const FavoritesScreen({super.key, required this.favoritesNotifier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Set<Destination>>(
        valueListenable: favoritesNotifier,
        builder: (context, favoriteDestinations, child) {
          return favoriteDestinations.isEmpty
              ? const Center(child: Text('No tienes favoritos'))
              : ListView.builder(
                  itemCount: favoriteDestinations.length,
                  itemBuilder: (context, index) {
                    final destination = favoriteDestinations.elementAt(index);
                    return Dismissible(
                      key: Key(destination.name),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // Eliminar el destino de favoritos
                        favoritesNotifier.value.remove(destination);
                        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                        favoritesNotifier.notifyListeners(); // Notificar los cambios
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        leading: Image.network(destination.imageUrl),
                        title: Text(destination.name),
                        trailing: const Icon(Icons.favorite, color: Colors.red),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
