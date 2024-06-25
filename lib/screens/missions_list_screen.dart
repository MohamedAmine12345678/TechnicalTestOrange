import 'package:flutter/material.dart';
import 'package:post_planning_app/models/mission.dart';
import 'package:post_planning_app/providers/mission_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/mission_item.dart';

class MissionsListScreen extends StatefulWidget {
  @override
  _MissionsListScreenState createState() => _MissionsListScreenState();
}

class _MissionsListScreenState extends State<MissionsListScreen> {
  late TextEditingController _searchController;
  late List<Mission> _missions; // Store original list of missions
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final missionProvider = Provider.of<MissionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : Text('SpaceX Missions'),
        actions: _buildActions(),
      ),
      body: FutureBuilder<List<Mission>>(
        future: missionProvider.fetchMissions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No missions available'));
          }

          _missions = snapshot.data!; // Store the original list of missions

          if (_isSearching && _searchController.text.isNotEmpty) {
            final filteredMissions = _missions.where((mission) =>
                mission.missionName.toLowerCase().contains(_searchController.text.toLowerCase())).toList();

            return _buildMissionList(filteredMissions);
          } else {
            return _buildMissionList(_missions);
          }
        },
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search missions...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white70),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) {
        setState(() {});
      },
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return [
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _searchController.clear();
            });
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
      ];
    }
  }

  Widget _buildMissionList(List<Mission> missions) {
    return ListView.builder(
      itemCount: missions.length,
      itemBuilder: (context, index) {
        final mission = missions[index];
        return MissionItem(mission: mission);
      },
    );
  }
}
