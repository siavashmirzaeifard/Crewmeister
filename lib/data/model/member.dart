class Member {
  final int id;
  final int userId;
  final int crewId;
  final String name;
  final String image;

  Member({
    required this.id,
    required this.userId,
    required this.crewId,
    required this.name,
    required this.image,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      userId: json['userId'],
      crewId: json['crewId'],
      name: json['name'],
      image: json['image'],
    );
  }
}
