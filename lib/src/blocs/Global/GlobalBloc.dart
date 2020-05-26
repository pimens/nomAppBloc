import 'package:KimochiApps/src/blocs/Global/GlobalEvent.dart';
import 'package:KimochiApps/src/blocs/Global/GlobalState.dart';
import 'package:KimochiApps/src/models/TrxModels.dart';
import 'package:KimochiApps/src/resources/globalRepo.dart';
import 'package:bloc/bloc.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalRepo gr = new GlobalRepo();
  List<Trx> allTrx;
  @override
  GlobalState get initialState => GlobalStateDefault();

  @override
  Stream<GlobalState> mapEventToState(GlobalEvent event) async* {
    if (event is GlobalTrxLoad) {
      try {
        yield GlobalStateLoading();
        var result = await gr.getDetailOrder(event.t.toString());
        print("====================xxx" + result.toString());
        this.allTrx = result;
        yield GlobalStateLoaded(result);
      } catch (message) {
        yield GlobalStateError(message: message.toString());
      }
    }
    if (event is GlobalTrxCancel) {
      try {
        yield GlobalStateLoading();
        var result = await gr.delete(event.notrx.toString());
        print("====================xxx" + result.toString());        
        yield GlobalStateDefault();
      } catch (message) {
        yield GlobalStateError(message: message.toString());
      }
    }
  }
}
