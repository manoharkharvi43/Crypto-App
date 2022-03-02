import 'dart:async';

import 'package:simple_flutter_app/data/api/models/api_list_model.dart';
import 'package:simple_flutter_app/data/api/models/api_methods.dart';

class AllCryptoApiStream {
  StreamController<List<GetApiList>> _allCryptoListSC =
      StreamController.broadcast();

  Stream<List<GetApiList>> get outputAllApiStream => _allCryptoListSC.stream;
  Sink<List<GetApiList>> get inputAllApiStream => _allCryptoListSC.sink;

  setAllCryptoPriceList(List<GetApiList> data) {
    inputAllApiStream.add(data);
  }

  fetchAllCoinsStream() async {
    List<GetApiList> response = await fetch_all_coins();
    inputAllApiStream.add(response);
  }

  fetchAllCoinsPriceAfterInterval(context) async {
    // Stream.periodic(Duration(minutes: 1), (e) async* {
    //   List<GetApiList> response = await fetch_all_coins();
    //   inputAllApiStream.add(response);
    // });
    List<GetApiList> response = await fetch_all_coins();
    inputAllApiStream.add(response);

    // Timer.periodic(const Duration(seconds: 10), (timer) {
    // });
  }

  @override
  void dispose() {
    _allCryptoListSC.close();
  }
}
