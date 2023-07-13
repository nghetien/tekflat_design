import 'dart:async';

import 'events/events.dart';
import 'states/states.dart';

abstract class TekStreamService {
  Stream<TekEvent> get eventStream;

  Stream<TekState> get stateStream;

  void add(TekEvent event);

  void emit(TekState state);
}

class TekStreamServiceImpl implements TekStreamService {
  TekStreamServiceImpl.init();

  final _eventStreamController = StreamController<TekEvent>.broadcast();
  final _stateStreamController = StreamController<TekState>.broadcast();

  @override
  void add(TekEvent event) => _eventStreamController.add(event);

  @override
  void emit(TekState state) => _stateStreamController.add(state);

  @override
  Stream<TekEvent> get eventStream => _eventStreamController.stream;

  @override
  Stream<TekState> get stateStream => _stateStreamController.stream;
}
