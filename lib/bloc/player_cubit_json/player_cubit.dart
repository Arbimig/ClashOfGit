import 'dart:async';
import 'dart:developer';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit_state.dart';
import 'package:clashofclans/repositories/database/data_base.dart';
import 'package:clashofclans/repositories/json/player_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(PlayerLoadingState());

  SFDataBase sfDataBase = SFDataBase();

  void delete(playerTag) async {
    try {
      await sfDataBase.deleteJsonSF(playerTag);

      List<PlayerInfo> playerInfoList = await fplayerInfoList();
      if (playerInfoList == null) {
        log('playerInfoList == null, player_cubit.dart, delete()');
        emit(PlayerLoadingState());
      } else {
        log('playerInfoList != null, player_cubit.dart, delete()');
        emit(PlayerLoadingState());
      }
    } catch (e) {
      log('delete error  ' + e.toString());
      emit(PlayerLoadingState());
    }
  }

  void add(String playerTag) async {
    try {
      await sfDataBase.addJsonToSF(playerTag);
      log('adding player info, player_cubit.dart, add() ');
      emit(PlayerLoadingState());
    } catch (e) {
      log('add error  ' + e.toString());
      emit(PlayerLoadingState());
    }
  }

  void update(playerTag) {
    log('updating player info, player_cubit.dart, update() ');
    add(playerTag);
  }

  void swith(int index) => emit(PlayerLoadingState(index: index));
///Swithed player account by index
  Future<List<PlayerInfo>> fplayerInfoList() async {
    List<String> tags = await getTags();
    log('playerInfoList');
    if (tags.length != 0) {
      List<PlayerInfo> listPlayerInfo = await Future.wait(Iterable.generate(
          tags.length, (i) => sfDataBase.getJsonOfSF(tags[i])));
      log(listPlayerInfo[0].toString());
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
