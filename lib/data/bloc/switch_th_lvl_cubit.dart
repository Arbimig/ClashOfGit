import 'package:flutter_bloc/flutter_bloc.dart';

class ThLevlel extends Cubit<String> {
  ThLevlel() : super('4th');

  // void updateIndex(int index) => emit(index);

  void getLevel(value) => emit(value);
}
