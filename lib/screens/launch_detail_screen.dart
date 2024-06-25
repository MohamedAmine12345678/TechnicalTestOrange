import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:post_planning_app/providers/launch_provider.dart';
import 'package:post_planning_app/models/launch.dart';

class LaunchDetailsScreen extends StatelessWidget {
  final String flightNumber;

  LaunchDetailsScreen({required this.flightNumber});

  @override
  Widget build(BuildContext context) {
    final launchProvider = Provider.of<LaunchProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Launch Details')),
      body: FutureBuilder<Launch>(
        future: launchProvider.fetchLaunchDetails(int.parse(flightNumber)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data'));
          }

          final launch = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mission Name: ${launch.missionName}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Launch Date: ${launch.launchDate}'),
                // Display other details
              ],
            ),
          );
        },
      ),
    );
  }
}
