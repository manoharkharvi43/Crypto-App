import 'dart:async';

import 'package:simple_flutter_app/data/api/models/api_list_model.dart';
import 'package:simple_flutter_app/data/api/models/api_methods.dart';

class ApiStream {
  ApiStream();

  final StreamController<List<GetApiList>> _cryptoPriceListSC =
      StreamController.broadcast();

  final StreamController<List<GetApiList>> _allCryptoListSC =
      StreamController.broadcast();

  //10 coins list api stream
  Stream<List<GetApiList>> get outputApiListStream =>
      _cryptoPriceListSC.stream.map((val) => val);

  // 100 coins list api stream
  Stream<List<GetApiList>> get outputAllApiListStream =>
      _allCryptoListSC.stream.map((val) => val);

  Sink<List<GetApiList>> get inputApiListStream => _cryptoPriceListSC.sink;

  Sink<List<GetApiList>> get inputAllApiStream => _allCryptoListSC.sink;

  setPriceList(List<GetApiList> data) {
    inputApiListStream.add(data);
  }

  fetchCoinsEveryThreeSecs() async {
    fetchCoins();

    // Stream.periodic(Duration(minutes: 1) , (t) => {
    // });
    // Timer.periodic(const Duration(seconds: 5), (timer) {
    // });
  }

  fetchCoins() async {
    List<GetApiList> response = await fetch_10_coins();
    inputApiListStream.add(response);
  }

  @override
  void dispose() {
    _cryptoPriceListSC.close();
  }
}
