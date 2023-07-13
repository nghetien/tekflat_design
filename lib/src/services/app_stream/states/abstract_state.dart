import 'package:equatable/equatable.dart';

abstract class TekState<T> extends Equatable {
  final T data;

  const TekState(this.data);
}
