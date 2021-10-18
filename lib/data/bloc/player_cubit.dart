import 'dart:async';
import 'dart:developer';
import 'package:clashofclans/data/database/data_base.dart';
import 'package:clashofclans/domain/models/player_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(PlayerLoadingState());

  SFDataBase sfDataBase = SFDataBase();

  void delete(playerTag) async {
    try {
      await sfDataBase.deleteJsonSF(playerTag);

      List<PlayerModel>? playerInfoList = await fplayerInfoList();
      // ignore: unnecessary_null_comparison
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

  ///Swithed player account by index

  Future<List<PlayerModel>> fplayerInfoList() async {
    List<String> tags = await getTags();
    log('playerInfoList');
    if (tags.length != 0) {
      List<PlayerModel> listPlayerInfo = await Future.wait(Iterable.generate(
          tags.length, (i) => sfDataBase.getJsonOfSF(tags[i])));
      return listPlayerInfo;
    } else {
      return [];
    }
  }

  Future<PlayerModel?> fplayerInfo(i) async {
    List<String> tags = await getTags();
    log('playerInfoList');
    print(tags.length);
    if (tags.length != 0) {
      PlayerModel playerInfo = await sfDataBase.getJsonOfSF(tags[i]);
      log(playerInfo.name);
      return playerInfo;
    } else {
      return null;
    }
  }

  Future<List<String>> getTags() async {
    List<String> _tag = await sfDataBase.getSFTagList();
    return _tag;
  }
}

abstract class PlayerState {}

class PlayerLoadingState extends PlayerState {
  // int index;

  // PlayerLoadingState({required this.index});
}

class PlayerErrorState extends PlayerState {}
