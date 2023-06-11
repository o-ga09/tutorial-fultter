import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './lisy_items.dart';
import './setting.dart';
import './models/model.dart';
import './models/entity.dart';
import './const/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final themeModeNotifier = ThemeModeNotifier(pref);
  final entityNotifier = EntityNotifier();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => themeModeNotifier,
        ),
        ChangeNotifierProvider(
          create: (context) => entityNotifier
        ),
      ],
      child: const MyApp(),
    ),
  );
  // runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(
      builder: (context, mode, child) => MaterialApp(
        title: 'Pokemon Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: mode.mode,
        home: const TopPage(),
      )
    );
  }
}

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int currentbnb = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currentbnb == 0 ? const List() : const Setting(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {
          setState(
            () => currentbnb = index,
          )
        },
        currentIndex: currentbnb,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
      ),
    );
  }
}

class List extends StatefulWidget {
  const List({Key? key}) : super(key: key);
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  static const int more = 30;
  int EntityCount = more;
  @override
  Widget build(BuildContext context) {
    return Consumer<EntityNotifier>(
      builder: (context,entity,child) => ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      itemCount: EntityCount + 1,
      itemBuilder: (context, index) {
          if(index == EntityCount) {
            return OutlinedButton(
              onPressed: () => {
                setState(
                  (){
                    EntityCount = EntityCount + more;
                    if(EntityCount > MaxId) {
                      EntityCount = MaxId;
                    }
                  }
                )
              },
              child: const Text('more'),
            );
          } else {
            return ListItems(
              entity: entity.byId(index + 1),
            );
          }
        }
      ),
    );
  }
}