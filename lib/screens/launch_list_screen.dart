import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:post_planning_app/providers/launch_provider.dart';
import 'package:post_planning_app/models/launch.dart';


class LaunchesListScreen extends StatefulWidget {
  @override
  _LaunchesListScreenState createState() => _LaunchesListScreenState();
}

class _LaunchesListScreenState extends State<LaunchesListScreen> {
  late TextEditingController _searchController;
  late List<Launch> _launches;
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
    final launchProvider = Provider.of<LaunchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : Text('SpaceX Launches'),

        actions: _buildActions(),
      ),
      body: FutureBuilder<List<Launch>>(
        future: launchProvider.fetchLaunches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No launches available'));
          }

          _launches = snapshot.data!; // Store the original list of launches

          if (_isSearching && _searchController.text.isNotEmpty) {
            final filteredLaunches = _launches.where((launch) =>
                launch.missionName.toLowerCase().contains(_searchController.text.toLowerCase())).toList();

            return _buildLaunchList(filteredLaunches);
          } else {
            return _buildLaunchList(_launches);
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
        hintText: 'Search launches...',
        labelStyle: TextStyle(color: Colors.black),
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black),
      ),
      style: TextStyle(color: Colors.black, fontSize: 16.0),
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

  Widget _buildLaunchList(List<Launch> launches) {
    return ListView.builder(
      itemCount: launches.length,
      itemBuilder: (context, index) {
        final launch = launches[index];
        return ListTile(
          title: Text(launch.missionName),
          subtitle: Text('Launch Date: ${launch.launchDate}'),

          onTap: () {
            Navigator.pushNamed(
              context,
              '/launch-details',
              arguments: launch.flightNumber.toString(), // Convert int to String
            );
          },
        );
      },
    );
  }
}
