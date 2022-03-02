import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_flutter_app/data/stream/all_crypto_api_stream.dart';
import 'package:simple_flutter_app/presentation/pages/main_pages/crypto_prices_screen/crypto_price.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);


  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  var _allApiStreamClass = AllCryptoApiStream();
  @override
  void initState() {
    _allApiStreamClass.fetchAllCoinsStream();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CryptoPrice(),
    );
  }
}

