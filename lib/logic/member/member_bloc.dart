import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/repository/member_repository.dart';
import 'member_event.dart';
import 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final MemberRepository repository;
  MemberBloc({required this.repository}) : super(MemberInitial()) {
    on<LoadMembers>((event, emit) async {
      emit(MemberLoading());
      try {
        final members = await repository.getMembers();
        emit(MemberSuccess(response: members));
      } catch (e) {
        emit(MemberFailure(message: e.toString()));
      }
    });
  }
}
