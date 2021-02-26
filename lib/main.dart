import 'package:clashofclans/bloc/player_cubit_json/player_cubit.dart';
import 'package:clashofclans/bloc/swith_theme_cubit.dart';
import 'package:clashofclans/ui/pages/apps_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/navigation_cubit.dart';
import 'package:clashofclans/bloc/timer_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(
          create: (_) => NavigationCubit(),
        ),
        BlocProvider(
          create: (_) => PlayerCubit(),
        ),
        BlocProvider(
          create: (_) => TimerCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            theme: theme,
            home: AppsPage(),
          );
        },
      ),
    );
  }
}
