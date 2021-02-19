import 'dart:convert';
import 'dart:developer';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit_state.dart';
import 'package:clashofclans/repositories/database/data_base.dart';
import 'package:clashofclans/repositories/json/json_players.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(PlayerEmptyState());

  SFDataBase sfDataBase = SFDataBase();

  Future<dynamic> deletePlayer(String playerTag) async {
    SFDataBase sfDataBase = SFDataBase();
    emit(PlayerEmptyState());
    try {
      emit(PlayerLoadingState());
      sfDataBase.deleteJsonSF(playerTag);
      int length = sfDataBase.getSFTagList().toString().length;
      List<String> playerTagList = sfDataBase.getSFTagList();
      List<PlayerInfo> stateList = List.generate(length,
          (index) => sfDataBase.getJsonOfSF(jsonDecode(playerTagList[index])));
      emit(PlayerLoadedState(playersInfo: stateList));
    } catch (e) {
      print('deleteError' + e.toString());
      PlayerErrorState();
    }
  }

  Future<dynamic> fetchPlayer(String playerTag) async {
    SFDataBase sfDataBase = SFDataBase();

    try {
      emit(PlayerLoadingState());
      final PlayerInfo _playerInfo =
          await GetPlayerInfo().getData('$playerTag');
      sfDataBase.addJsonToSF(playerTag, jsonEncode(_playerInfo));
      log(_playerInfo.toString() + ' _playerInfo log of fetchPlayer');
      int length = sfDataBase.getSFTagList().toString().length;
      List<String> playerTagList = sfDataBase.getSFTagList();
      List<PlayerInfo> stateList = List.generate(length,
          (index) => sfDataBase.getJsonOfSF(jsonDecode(playerTagList[index])));
      emit(PlayerLoadedState(playersInfo: stateList));
    } catch (e) {
      print('AddError' + e.toString());
      emit(PlayerErrorState());
    }
  }
}

// Во вкладке аккунты передаеться переменная с тегом игрока
// Она отправляеться в кубит и вызывает джейсон
// сохраненная инфа поступает
// GQQC00CL
