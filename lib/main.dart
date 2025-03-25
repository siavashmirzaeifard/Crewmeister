import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/util/data_loader.dart';
import '/data/provider/get_api.dart';
import '/data/repository/absence_repository.dart';
import '/presentation/screens/main_screen.dart';
import 'logic/absence/absence_bloc.dart';
import 'logic/absence/absence_event.dart';

void main() {
  final absenceRepository = AbsenceRepository(
    api: GetApi(loader: DataLoader()),
  );
  runApp(MyApp(repository: absenceRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.repository});
  final AbsenceRepository repository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AbsenceBloc>(
          create:
              (context) =>
                  AbsenceBloc(repository: repository)
                    ..add(LoadAbsences(page: 1)),
        ),
      ],
      child: MaterialApp(
        title: 'Crewmeister Sample',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
