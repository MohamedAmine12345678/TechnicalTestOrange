import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:post_planning_app/providers/mission_provider.dart';
import 'package:post_planning_app/models/mission.dart';

class MissionDetailsScreen extends StatelessWidget {
  final String missionId;

  MissionDetailsScreen({required this.missionId});

  @override
  Widget build(BuildContext context) {
    final missionProvider = Provider.of<MissionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Mission Details')),
      body: FutureBuilder<Mission>(
        future: missionProvider.fetchMissionDetails(missionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data'));
          }

          final mission = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mission Name: ${mission.missionName}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                // Display other details
              ],
            ),
          );
        },
      ),
    );
  }
}
