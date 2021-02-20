import 'dart:async';
import 'dart:developer';

import 'package:clashofclans/bloc/player_cubit_json/player_cubit_state.dart';
import 'package:clashofclans/repositories/database/data_base.dart';
import 'package:clashofclans/repositories/json/json_players.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(PlayerLoadingState());

  SFDataBase sfDataBase = SFDataBase();

  void delete(playerTag) async {
    try {
      await sfDataBase.deleteJsonSF(playerTag);
      log('все забись  add');

      List<PlayerInfo> playerInfoList = await _playerInfoList();
      if (playerInfoList == null) {
        log('playerInfoList == null');
        emit(PlayerLoadedState(playersInfoList: playerInfoList));
      } else {
        emit(PlayerLoadedState(playersInfoList: playerInfoList));
      }
    } catch (e) {
      log('add error  ' + e.toString());
    }
  }

  void add(playerTag) async {
    try {
      await sfDataBase.addJsonToSF(playerTag);
      log('все забись  add');
      List<PlayerInfo> playerInfoList = await _playerInfoList();
      log(playerInfoList[0].clan.name.toString());
      emit(PlayerLoadedState(playersInfoList: playerInfoList));
    } catch (e) {
      log('add error  ' + e.toString());
    }
  }

  Future<List<PlayerInfo>> _playerInfoList() async {
    List<String> tags = await getTags();
    log('и тут норм _playerInfoList');
    if (tags.length != 0) {
      List<PlayerInfo> listPlayerInfo = await Future.wait(Iterable.generate(
          tags.length, (i) => sfDataBase.getJsonOfSF(tags[i])));
      log(listPlayerInfo.length.toString() + '  _playerInfoList lenght');
      log(listPlayerInfo[0].expLevel.toString() + '  _playerInfoList');
      return listPlayerInfo;
    } else {
      return null;
    }
  }

  Future<List<String>> getTags() async {
    List<String> _tag = await sfDataBase.getSFTagList();
    return _tag;
  }
}
