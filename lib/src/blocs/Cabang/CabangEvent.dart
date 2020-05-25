import 'package:KimochiApps/src/models/CabangModels.dart';
import 'package:equatable/equatable.dart';


class CabangEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class CabangEventLoad extends CabangEvent {
 
}

class CabangEventOrder extends CabangEvent {
  final List<Cabang> m;
  final String nama;
  CabangEventOrder({this.m, this.nama});
}