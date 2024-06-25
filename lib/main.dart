import 'package:flutter/material.dart';
import 'package:post_planning_app/screens/mission_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:post_planning_app/providers/launch_provider.dart';
import 'package:post_planning_app/providers/mission_provider.dart';
import 'package:post_planning_app/screens/launch_list_screen.dart';
import 'package:post_planning_app/screens/missions_list_screen.dart';
import 'package:post_planning_app/screens/launch_detail_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LaunchProvider()),
        ChangeNotifierProvider(create: (_) => MissionProvider()),
      ],
      child: MaterialApp(
        title: 'SpaceX Launches and Missions',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BottomNavigation(),
        onGenerateRoute: (settings) {
          if (settings.name == '/launch-details') {
            final String flightNumber = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => LaunchDetailsScreen(flightNumber: flightNumber),
            );
          } else if (settings.name == '/mission-details') {
            final String missionId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => MissionDetailsScreen(missionId: missionId),
            );
          }
          return null;
        },
      ),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    LaunchesListScreen(),
    MissionsListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpaceX Launches and Missions'),

      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: 'Launches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Missions',
          ),
        ],
      ),
    );
  }
}
