import 'package:KimochiApps/src/blocs/Makanan/MakananEvent.dart';
import 'package:KimochiApps/src/blocs/makanan/MakananState.dart';
import 'package:KimochiApps/src/models/makananModels.dart';
import 'package:KimochiApps/src/resources/makananRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class MakananBloc extends Bloc<MakananEvent, MakananState> {
  MakananRepo mknRepo = new MakananRepo();
  List<Makanan> order = [];
  List<Makanan> allMakanan, tmp;
  @override
  get initialState => MakananStateDefault();
  @override
  Stream<MakananState> mapEventToState(MakananEvent event) async* {
    if (event is MakananEventLoad) {
      try {
        yield MakananStateLoading();
        var result = await mknRepo.getMakanan(0, 3);
        this.allMakanan = result;
        yield MakananStateLoaded(this.allMakanan);
      } catch (e) {
        yield MakananStateError();
      }
    }
    if (event is MakananEventGetNewData) {
      try {
        if (event.s != -1) {
          // print("nedata e");
          this.tmp = [];
          var result = await mknRepo.getMakanan(event.s, event.off);
          this.tmp = result;
          for (int i = 0; i < this.tmp.length; i++) {
            Makanan x = this.tmp[i];
            print("nedata e");
            print(x.nama);
            this.allMakanan.add(x);
          }
        }
        yield MakananStateLoaded(this.allMakanan);
      } catch (e) {
        yield MakananStateError();
      }
    }
    if (event is MakananEventOrder) {
      try {
        this.order = [];
        yield MakananStateLoading();
        // this.allMakanan = event.m;
        for (int i = 0; i < this.allMakanan.length; i++) {
          if (int.parse(this.allMakanan[i].tmp) > 0) {
            {
              Makanan x = this.allMakanan[i];
              this.order.add(x);
            }
          }
        }
        print(this.order.toString());
        yield MakananStateOrder(this.order);
      } catch (e) {
        yield MakananStateError(message: e.toString());
      }
    }
  }
}
