import 'package:hive/hive.dart';


import '../models/launch.dart';
import '../models/mission.dart';

class LocalStorageService {
  Future<void> saveLaunches(List<Launch> launches) async {
    var box = await Hive.openBox('launches');
    await box.put('launches', launches);
  }

  Future<List<Launch>> getLaunches() async {
    var box = await Hive.openBox('launches');
    return box.get('launches', defaultValue: <Launch>[]);
  }

  Future<void> saveMissions(List<Mission> missions) async {
    var box = await Hive.openBox('missions');
    await box.put('missions', missions);
  }

  Future<List<Mission>> getMissions() async {
    var box = await Hive.openBox('missions');
    return box.get('missions', defaultValue: <Mission>[]);
  }
}
