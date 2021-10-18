import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<int> {
  TimerCubit() : super(0);

  // ignore: unused_field

  void startTimer() {
    // ignore: unused_local_variable
    Timer _timer;
    int _start = 60;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          timer.cancel();
          emit(_start);
        } else {
          _start--;
          emit(_start);
        }
      },
    );
  }
}
