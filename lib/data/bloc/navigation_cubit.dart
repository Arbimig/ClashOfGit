import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0); 

  // void updateIndex(int index) => emit(index);

  void getStat() => emit(0);
  void getClan() => emit(1);
  void getMaps() => emit(2);
  void getGuide() => emit(3);
  void getProfiles() => emit(4);
  void getSettings() => emit(5);

}
