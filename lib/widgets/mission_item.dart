import 'package:flutter/material.dart';
import 'package:post_planning_app/models/mission.dart';
import 'package:post_planning_app/screens/mission_details_screen.dart';

class MissionItem extends StatelessWidget {
  final Mission mission;

  MissionItem({required this.mission});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(mission.missionName),
      subtitle: Text('Mission Name: ${mission.missionName}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MissionDetailsScreen(missionId: mission.missionId),
          ),
        );
      },
    );
  }
}
