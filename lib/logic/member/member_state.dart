import 'package:equatable/equatable.dart';

import '/data/model/member.dart';

abstract class MemberState extends Equatable {
  const MemberState();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class MemberInitial extends MemberState {
  const MemberInitial();
}

class MemberLoading extends MemberState {
  const MemberLoading();
}

class MemberSuccess extends MemberState {
  final List<Member> response;

  const MemberSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class MemberFailure extends MemberState {
  final String message;

  const MemberFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
