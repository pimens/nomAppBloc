import 'package:equatable/equatable.dart';


class MakananEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class MakananEventLoad extends MakananEvent {
 
}
class MakananEventOrder extends MakananEvent {
  // final List<Makanan> m;
  // final String nama;
  // MakananEventOrder({this.m, this.nama});
}
class MakananEventGetNewData extends MakananEvent {
  final int s;
  final int off;
  MakananEventGetNewData(this.s, this.off);
}