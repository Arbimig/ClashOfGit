import 'package:clashofclans/repositories/json/json_players.dart';

abstract class PlayerState {}

class PlayerEmptyState extends PlayerState {}

class PlayerLoadingState extends PlayerState {}

class PlayerLoadedState extends PlayerState {
  List<PlayerInfo> playersInfoList;
  PlayerLoadedState({
    this.playersInfoList,
  });
}

class PlayerErrorState extends PlayerState {}
