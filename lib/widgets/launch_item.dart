import 'package:flutter/material.dart';
import 'package:post_planning_app/models/launch.dart';

class LaunchItem extends StatelessWidget {
  final Launch launch;
  final Function onTap;

  LaunchItem({required this.launch, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(launch.missionName),
      subtitle: Text('Launch Date: ${launch.launchDate}'),
      onTap: () => onTap(),
    );
  }
}
