import 'package:equatable/equatable.dart';

abstract class MemberEvent extends Equatable {
  const MemberEvent();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class LoadMembers extends MemberEvent {
  const LoadMembers();
}
