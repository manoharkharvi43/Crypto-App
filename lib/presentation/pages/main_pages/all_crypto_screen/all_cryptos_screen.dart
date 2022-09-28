import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:simple_flutter_app/data/api/models/api_list_model.dart';
import 'package:simple_flutter_app/data/routes/route.dart';
import 'package:simple_flutter_app/data/stream/all_crypto_api_stream.dart';

class AllCryptoScreen extends StatefulWidget {
  const AllCryptoScreen({Key? key}) : super(key: key);

  @override
  _AllCryptoScreenState createState() => _AllCryptoScreenState();
}

class _AllCryptoScreenState extends State<AllCryptoScreen>
    with AutomaticKeepAliveClientMixin {
  var _allApiStreamClass = AllCryptoApiStream();
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    print("called every time without binding========>");
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) => {
          print("called every time with binding======>"),
          _allApiStreamClass.fetchAllCoinsPriceAfterInterval(context)
        });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    /// Remember to add this line!!!
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            decoration: new InputDecoration(
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                hintText: "Search"),
          ),
        ),
        Flexible(
            child: StreamBuilder<List<GetApiList>>(
                initialData: [],
                stream: _allApiStreamClass.outputAllApiStream,
                builder: (context, apiStreamData) {
                  print("apiStreamDataapiStreamData $apiStreamData");
                  if (apiStreamData.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (apiStreamData.connectionState ==
                          ConnectionState.active ||
                      apiStreamData.connectionState == ConnectionState.done) {
                    if (apiStreamData.hasError) {
                      return Text("Error");
                    } else if (apiStreamData.hasData) {
                      return ListView.builder(
                        itemCount: apiStreamData?.data?.length,
                        itemBuilder: (context, int index) {
                          return CryptoRowContainer(
                            name: "${apiStreamData?.data?[index]?.coinName}",
                            price: "${apiStreamData?.data?[index]?.coinPrice}",
                            imageUrl:
                                "${apiStreamData?.data?[index]?.coinImageUrl}",
                            price_24_hour:
                                "${apiStreamData?.data?[index]?.price_change_percentage_24h}",
                            onClickCoin: () => {
                              Navigator.pushNamed(context, Routes.crypto_charts)
                            },
                          );
                        },
                      );
                    } else {
                      return Text("$apiStreamData");
                    }
                  } else {
                    return Text('State: ${apiStreamData.connectionState}');
                  }
                }))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CryptoRowContainer extends StatelessWidget {
  final Function onClickCoin;

  const CryptoRowContainer(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.price_24_hour,
      required this.onClickCoin})
      : super(key: key);

  final String name;
  final String imageUrl;
  final String price;
  final String price_24_hour;

  dynamic zeroRemoverFromInt(String str) {
    print("value============> $str");
    return double.parse(str) > 0 && int.parse(str.split(".")[1]) == 0
        ? int.parse(str)
        : double.parse(str);
  }

  intModifier(dynamic money) {
    return NumberFormat.currency(
      symbol: '₹ ',
      locale: "HI",
      decimalDigits: 3,
    ).format(double.parse(money));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () => {onClickCoin()},
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          // height: 100,
          child: Row(
            children: [
              SizedBox(
                child: Image.network(imageUrl),
                width: 50,
                height: 50,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(
                      "$name",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      NumberFormat.currency(
                        symbol: '₹ ',
                        locale: "HI",
                        decimalDigits: 0,
                      ).format(double.parse(price)),
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "$name",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  price_24_hour.contains("-")
                                      ? Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.arrow_drop_up_sharp,
                                          color: Colors.green,
                                        ),
                                  Text(
                                    "${double.parse(price_24_hour).toStringAsFixed(3).toString()}%",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 18,
                                        color: price_24_hour.contains("-")
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ]),
                          )
                        ],
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  )
                ],
              ))
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.white60, width: 1),
              ),
          padding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
