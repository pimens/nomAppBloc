import 'package:KimochiApps/src/models/TrxModels.dart';
import 'package:equatable/equatable.dart';

class GlobalState extends Equatable {
  GlobalState([List props = const []]) : super();
  @override
  List<Object> get props => null;
}

class GlobalStateDefault extends GlobalState {}

class GlobalStateLoading extends GlobalState {}
class GlobalStateError extends GlobalState {
  final String message;
  GlobalStateError({this.message});
}
class GlobalStateLoaded extends GlobalState {
  GlobalStateLoaded(this.data);
  @override
  List<Object> get props => [data];
  final List<Trx> data;
}
