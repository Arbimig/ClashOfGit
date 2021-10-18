import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/bloc/switch_player_cubit.dart';
import 'data/bloc/switch_th_lvl_cubit.dart';
import 'data/bloc/navigation_cubit.dart';
import 'data/bloc/player_cubit.dart';
import 'data/bloc/swith_theme_cubit.dart';
import 'data/bloc/timer_cubit.dart';
import 'internal/apps_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
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
        BlocProvider(
          create: (_) => ThLevlel(),
        ),
        BlocProvider(
          create: (_) => SwitchPlayerCubit(),
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            theme: theme,
            home: DefaultTabController(length: 3, child: AppsPage()),
          );
        },
      ),
    );
  }
}
