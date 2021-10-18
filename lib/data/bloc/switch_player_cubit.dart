import 'package:clashofclans/internal/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchPlayerCubit extends Cubit<PlayerIndex> {
  SwitchPlayerCubit() : super(NoPlayerIndexState());

  void switchPlayer(int i) async {
    var tags = await playerCubitFunc.getTags();
    var indexwhere = tags.indexWhere((note) => note.startsWith(tags[i]));
    // ignore: unnecessary_null_comparison
    if (tags != null) {
      emit(PlayerIndexState(index: indexwhere));
    } else
      emit(NoPlayerIndexState());
  }

  // void swith(int index) => emit(PlayerIndexState(index: index));
}

abstract class PlayerIndex {}

class PlayerIndexState extends PlayerIndex {
  int index;
  PlayerIndexState({required this.index});
}

class NoPlayerIndexState extends PlayerIndex {}
