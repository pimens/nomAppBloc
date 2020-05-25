import 'package:equatable/equatable.dart';
import 'package:KimochiApps/src/models/makananModels.dart';

class MakananState extends Equatable {
  MakananState([List props = const []]) : super();
  @override
  List<Object> get props => null;
}

class MakananStateDefault extends MakananState {}

class MakananStateLoading extends MakananState {}

class MakananStateError extends MakananState {
  final String message;
  MakananStateError({this.message});
}

class MakananStateLoaded extends MakananState {
  @override
  List<Object> get props => [data];
  final List<Makanan> data;
  MakananStateLoaded(this.data);
}

class MakananStateOrder extends MakananState {
  @override
  List<Object> get props => [data];
  final List<Makanan> data;
  MakananStateOrder(this.data);
}
