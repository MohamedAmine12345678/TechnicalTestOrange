import 'package:flutter/foundation.dart';
import 'package:post_planning_app/models/launch.dart';
import 'package:post_planning_app/services/api_service.dart';

class LaunchProvider with ChangeNotifier {
  ApiService _apiService = ApiService();

  Future<List<Launch>> fetchLaunches() async {
    try {
      List<Launch> launches = await _apiService.fetchLaunches();
      return launches;
    } catch (error) {
      throw Exception('Failed to fetch launches: $error');
    }


  }
  Future<Launch> fetchLaunchDetails(int flightNumber) async {
    try {
      // Fetch details for the specific launch by flight number
      Launch launch = await _apiService.fetchLaunchByFlightNumber(flightNumber);
      return launch;
    } catch (error) {
      throw Exception('Failed to fetch launch details by flight number: $error');
    }
  }
}
