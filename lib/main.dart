import 'package:flutter/material.dart';
import 'package:taller2_corregido/screens/destination.dart';
import 'screens/search_screen.dart' as search;
import 'screens/favorites_screen.dart' as favorites;
import 'screens/bookings_screen.dart' as bookings;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesNotifier = ValueNotifier<Set<Destination>>({});

    return MaterialApp(
      title: 'Aplicación de viajes',
      home: TabBarScreen(favoritesNotifier: favoritesNotifier),
    );
  }
}

class TabBarScreen extends StatefulWidget {
  final ValueNotifier<Set<Destination>> favoritesNotifier;

  const TabBarScreen({super.key, required this.favoritesNotifier});

  @override
  TabBarScreenState createState() => TabBarScreenState();
}

class TabBarScreenState extends State<TabBarScreen> {
  List<Destination> destinations = [
    Destination('Paris', 'https://cdn.pixabay.com/photo/2018/04/25/09/26/eiffel-tower-3349075_640.jpg'),
    Destination('Roma', 'https://thumbs.dreamstime.com/b/ventanas-viejas-hermosas-en-roma-italia-el-colosseum-o-coliseo-la-salida-del-sol-144201572.jpg'),
    Destination('Barcelona', 'https://img2.rtve.es/imagenes/ciudades-para-siglo-xxi-barcelona-ciudad-vertebrada-2/1561977571494.jpg'),
    Destination('Dubaí', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/UAE_Dubai_Marina_img1_asv2018-01.jpg/1280px-UAE_Dubai_Marina_img1_asv2018-01.jpg'),
    Destination('New York', 'https://www.civitatis.com/blog/wp-content/uploads/2016/05/Estatua-de-la-Libertad.jpg'),
    Destination('Washington DC', 'https://www.civitatis.com/f/estados-unidos/washington/escala-washington-589x392.jpg'),
    Destination('Cairo', 'https://www.traveltoegypt.net/front/images/blog/Cairo-City.jpg'),
    Destination('Madrid', 'https://estaticos-cdn.prensaiberica.es/clip/645735a6-6176-4b65-baea-9f3529d32723_16-9-discover-aspect-ratio_default_0.webp'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Aplicación de viajes'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.search)),
              Tab(icon: Icon(Icons.favorite)),
              Tab(icon: Icon(Icons.book)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            search.SearchScreen(
              destinations: destinations,
              favoritesNotifier: widget.favoritesNotifier,
            ),
            favorites.FavoritesScreen(favoritesNotifier: widget.favoritesNotifier),
            bookings.BookingsScreen(destinations: destinations),
          ],
        ),
      ),
    );
  }
}
