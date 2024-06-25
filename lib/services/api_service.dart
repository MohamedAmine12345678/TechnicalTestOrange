import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:post_planning_app/models/launch.dart';
import 'package:post_planning_app/models/mission.dart';

class ApiService {
  static const String _baseUrl = 'https://api.spacexdata.com/v3';

  Future<List<Launch>> fetchLaunches() async {
    final response = await http.get(Uri.parse('$_baseUrl/launches'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Launch> launches = data.map((json) => Launch.fromJson(json)).toList();
      return launches;
    } else {
      throw Exception('Failed to load launches');
    }
  }


  Future<Launch> fetchLaunchByFlightNumber(int flightNumber) async {
    final response = await http.get(Uri.parse('$_baseUrl/launches/$flightNumber'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Launch launch = Launch.fromJson(data); // Ensure to parse as a single Launch object
      return launch;
    } else {
      throw Exception('Failed to load launch details');
    }
  }

  Future<List<Mission>> fetchMissions() async {
    final response = await http.get(Uri.parse('$_baseUrl/missions'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Mission> missions = data.map((e) => Mission.fromJson(e)).toList();
      return missions;
    } else {
      throw Exception('Failed to load missions');
    }
  }

  Future<Mission> fetchMissionDetails(String missionId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/missions'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        var missionData = data.firstWhere((element) => element['mission_id'] == missionId);
        return Mission.fromJson(missionData);
      } else {
        throw Exception('Failed to load mission details');
      }
    } catch (error) {
      throw Exception('Failed to fetch mission details: $error');
    }
  }
}
