import 'package:flutter/foundation.dart';
import 'package:post_planning_app/models/mission.dart';
import 'package:post_planning_app/services/api_service.dart';

class MissionProvider with ChangeNotifier {
  ApiService _apiService = ApiService();

  Future<List<Mission>> fetchMissions() async {
    try {
      // Fetch list of missions
      List<Mission> missions = await _apiService.fetchMissions();
      return missions;
    } catch (error) {
      throw Exception('Failed to fetch missions: $error');
    }
  }

  Future<Mission> fetchMissionDetails(String missionId) async {
    try {
      // Fetch details for the specific mission
      Mission mission = await _apiService.fetchMissionDetails(missionId);
      return mission;
    } catch (error) {
      throw Exception('Failed to fetch mission details: $error');
    }
  }


}
