class Launch {
  final String missionName;
  final DateTime launchDate;
  final int flightNumber; // New field

  Launch({
    required this.missionName,
    required this.launchDate,
    required this.flightNumber,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      missionName: json['mission_name'] ?? '',
      launchDate: DateTime.parse(json['launch_date_utc']),
      flightNumber: json['flight_number'] ?? 0, // Assuming flight_number is an integer
    );
  }
}
