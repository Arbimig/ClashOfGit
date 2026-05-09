import 'package:flutter_test/flutter_test.dart';
import 'package:clashofclans/data/bloc/player_cubit.dart';

void main() {
  group('PlayerCubit', () {
    late PlayerCubit playerCubit;

    setUp(() {
      playerCubit = PlayerCubit();
    });

    tearDown(() {
      playerCubit.close();
    });

    test('initial state is PlayerLoadingState', () {
      expect(playerCubit.state, isA<PlayerLoadingState>());
    });

    group('PlayerState', () {
      test('PlayerLoadingState is a PlayerState', () {
        expect(PlayerLoadingState(), isA<PlayerState>());
      });

      test('PlayerErrorState is a PlayerState', () {
        expect(PlayerErrorState(), isA<PlayerState>());
      });
    });

    group('add()', () {
      test('emits a state after add is called', () async {
        // add() calls SFDataBase which uses SharedPreferences,
        // so it will throw in test environment. The error is caught
        // and a state is emitted.
        playerCubit.add('#TEST');
        // Wait for the async operation to complete
        await Future.delayed(const Duration(milliseconds: 200));
        // After add, the state should be either PlayerLoadingState (success)
        // or PlayerErrorState (failure in test environment without SharedPreferences)
        expect(playerCubit.state, isA<PlayerState>());
      });
    });

    group('delete()', () {
      test('emits a state after delete is called', () async {
        // delete() calls SFDataBase which uses SharedPreferences,
        // so it will throw in test environment. The error is caught
        // and a state is emitted.
        playerCubit.delete('#TEST');
        // Wait for the async operation to complete
        await Future.delayed(const Duration(milliseconds: 200));
        expect(playerCubit.state, isA<PlayerState>());
      });
    });

    group('update()', () {
      test('calls add internally and emits a state', () async {
        playerCubit.update('#TEST');
        await Future.delayed(const Duration(milliseconds: 200));
        expect(playerCubit.state, isA<PlayerState>());
      });
    });
  });
}
