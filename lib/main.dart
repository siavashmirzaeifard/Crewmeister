import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/util/data_loader.dart';
import '/data/provider/get_api.dart';
import '/data/repository/absence_repository.dart';
import '/logic/absence/absence_bloc.dart';
import '/logic/absence/absence_event.dart';
import '/presentation/screens/main_screen.dart';

/// Entry point of the app.
void main() {
  final absenceRepository = AbsenceRepository(
    api: GetApi(loader: DataLoader()),
  );

  // Run the app, as it acts as a runner of our application.
  runApp(MyApp(repository: absenceRepository));
}

/// MyApp is the root widget of the application.
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
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
      ),
    );
  }
}
