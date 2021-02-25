abstract class PlayerState {}

class PlayerLoadingState extends PlayerState {
  int index;
  
  PlayerLoadingState({this.index});
}


class PlayerErrorState extends PlayerState {}
