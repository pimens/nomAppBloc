import 'package:equatable/equatable.dart';
import 'package:KimochiApps/src/models/CabangModels.dart';

class CabangState extends Equatable {
  CabangState([List props = const []]) : super();
  @override
  List<Object> get props => null;
}

class CabangStateDefault extends CabangState {
   @override
  List<Object> get props => null;
}

class CabangStateLoading extends CabangState {
}

class CabangStateError extends CabangState {
  final String message;
  CabangStateError({this.message}); 
}

class CabangStateLoaded extends CabangState {
  @override
  List<Object> get props => [data];
  final List<Cabang> data;
  CabangStateLoaded(this.data);
}

class CabangStateLoad extends CabangState {
  @override
  List<Object> get props => [data];
  final List<Cabang> data;
  CabangStateLoad(this.data);  
}
