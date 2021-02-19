import 'package:clashofclans/repositories/json/json_players.dart';

abstract class PlayerState {}

class PlayerEmptyState extends PlayerState {}

class PlayerLoadingState extends PlayerState {}

class PlayerLoadedState extends PlayerState {
  List<PlayerInfo> playersInfo;

  PlayerLoadedState({
    this.playersInfo,
  }) : assert(playersInfo != null);
}

class PlayerErrorState extends PlayerState {}
