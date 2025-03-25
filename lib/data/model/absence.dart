class Absence {
  final int id;
  final int userId;
  final String type;
  final String startDate;
  final String endDate;
  final String createdAt;
  final String? confirmedAt;
  final String? rejectedAt;
  final int crewId;
  final String memberNote;
  final int? admitterId;
  final String admitterNote;

  Absence({
    required this.id,
    required this.userId,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    this.confirmedAt,
    this.rejectedAt,
    required this.crewId,
    required this.memberNote,
    this.admitterId,
    required this.admitterNote,
  });

  factory Absence.fromJson(Map<String, dynamic> json) {
    return Absence(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      createdAt: json['createdAt'],
      confirmedAt: json['confirmedAt'],
      rejectedAt: json['rejectedAt'],
      crewId: json['crewId'],
      memberNote: json['memberNote'],
      admitterId: json['admitterId'],
      admitterNote: json['admitterNote'],
    );
  }
}
