import 'package:equatable/equatable.dart';


class GlobalEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class GlobalTrxLoad extends GlobalEvent {
  final String t;
  GlobalTrxLoad({this.t});
}
class GlobalTrxCancel extends GlobalEvent {
  final String notrx;
  GlobalTrxCancel({this.notrx});
}