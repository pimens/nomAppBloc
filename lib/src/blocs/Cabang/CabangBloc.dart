import 'package:KimochiApps/src/blocs/cabang/CabangEvent.dart';
import 'package:KimochiApps/src/blocs/cabang/CabangState.dart';
import 'package:KimochiApps/src/models/CabangModels.dart';
import 'package:KimochiApps/src/resources/CabangRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class CabangBloc extends Bloc<CabangEvent, CabangState> {
  CabangRepo cbgRepo = new CabangRepo();
  List<Cabang> allCabang;
  @override
  get initialState => CabangStateDefault();
  @override
  Stream<CabangState> mapEventToState(CabangEvent event) async* {
    if (event is CabangEventLoad) {
      try {
        yield CabangStateLoading();
        var result = await cbgRepo.getCabang();
        this.allCabang = result;
        yield CabangStateLoaded(this.allCabang);
      } catch (e) {
        yield CabangStateError();
      }
    }
  }
}
