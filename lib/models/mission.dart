class Mission {
  final String missionName;
  final String missionId;
  final List<String> manufacturers;
  final List<String> payloadIds;
  final String wikipedia;
  final String website;
  final String twitter;
  final String description;

  Mission({
    required this.missionName,
    required this.missionId,
    required this.manufacturers,
    required this.payloadIds,
    required this.wikipedia,
    required this.website,
    required this.twitter,
    required this.description,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      missionName: json['mission_name']?? '',
      missionId: json['mission_id']?? '',
      manufacturers: List<String>.from(json['manufacturers']?? ''),
      payloadIds: List<String>.from(json['payload_ids']?? ''),
      wikipedia: json['wikipedia']?? '',
      website: json['website']?? '',
      twitter: json['twitter']?? '',
      description: json['description']?? '',
    );
  }
}


