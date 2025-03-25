/// This model combines both members and absence response in repository layer.
class MemberAbsence {
  final int id;
  final int userId;
  final String memberName;
  final String type;
  final String period;
  final String memberNote;
  final String status;
  final String admitterNote;

  MemberAbsence({
    required this.id,
    required this.userId,
    required this.memberName,
    required this.type,
    required this.period,
    required this.memberNote,
    required this.status,
    required this.admitterNote,
  });
}
