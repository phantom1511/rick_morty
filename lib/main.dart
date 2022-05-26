import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_morty/service/web_service.dart';
import 'package:rick_morty/view/episode_page.dart';
import 'package:rick_morty/view/hero_page.dart';

void main() {
  runApp(const MyApp());
  GetIt.I.registerSingleton<Dio>(_dio);
  GetIt.I.registerSingleton<WebService>(WebService());
}

final Dio _dio = Dio()
  ..options.baseUrl = 'https://rickandmortyapi.com/api'
  ..options.headers = {'Accept': 'application/json'}
  ..options.followRedirects = false;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _pages = [const HeroPage(), const EpisodePage()];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Hero',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Episode',
          ),
        ],
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
