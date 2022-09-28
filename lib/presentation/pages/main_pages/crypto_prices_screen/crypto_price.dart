import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:simple_flutter_app/data/api/models/api_list_model.dart';
import 'package:simple_flutter_app/data/api/models/api_methods.dart';
import 'package:simple_flutter_app/data/stream/api_stream.dart';
import 'package:simple_flutter_app/presentation/pages/main_pages/crypto_prices_screen/carasoule.dart';
import 'package:simple_flutter_app/presentation/pages/main_pages/crypto_prices_screen/row_container.dart';

class CryptoPrice extends StatefulWidget {
  const CryptoPrice({Key? key}) : super(key: key);

  @override
  _CryptoPriceState createState() => _CryptoPriceState();
}

class _CryptoPriceState extends State<CryptoPrice> {
  List<GetApiList> coins_list_from_stream = [];

  var apiStreamInstance = ApiStream();

  @override
  void initState() {
    apiStreamInstance.fetchCoinsEveryThreeSecs();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          color: Color(0xf5f5f5),
          child: Carousel(),
        ),
        Container(
          child: Text(
            "Market Capitalization(Top 10)",
            style: TextStyle(fontSize: 18, color: Colors.black45),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.20,
          child: StreamBuilder<List<GetApiList>>(
            stream: apiStreamInstance.outputApiListStream,
            builder: (context, apiStreamData) {
              if (apiStreamData.connectionState == ConnectionState.waiting) {
                return ListView(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                    )
                  ],
                );
              } else if (apiStreamData.connectionState ==
                      ConnectionState.active ||
                  apiStreamData.connectionState == ConnectionState.done) {
                if (apiStreamData.hasError) {
                  return const Text('Error');
                } else if (apiStreamData.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: apiStreamData.data?.length,
                      itemBuilder: (context, int index) {
                        return ContainerWid(
                            name: "${apiStreamData.data?[index].coinName}",
                            imageUrl:
                                "${apiStreamData.data?[index].coinImageUrl}",
                            price: "${apiStreamData.data?[index].coinPrice}",
                            price_24_hour:
                                "${apiStreamData.data?[index].price_change_percentage_24h}",
                            symbol: "${apiStreamData.data?[index].symbol}");
                      });
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${apiStreamData.connectionState}');
              }
            },
          ),
        )
      ],
    );
  }
}

class ContainerWid extends StatelessWidget {
  const ContainerWid(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.price_24_hour,
      required this.symbol})
      : super(key: key);
  final String name;
  final String imageUrl;
  final String price;
  final String price_24_hour;
  final String symbol;

  intModifier(dynamic money) {
    bool isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.tryParse(s) != null;
    }

    if (isNumeric(money)) {
      return NumberFormat.currency(
        symbol: '₹ ',
        locale: "HI",
        decimalDigits: 3,
      ).format(double.parse(money));
    } else {
      return NumberFormat.currency(
        symbol: '₹ ',
        locale: "HI",
      ).format(int.parse(money));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Image.network(
                      imageUrl,
                      height: 50,
                      width: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "$name",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(
                      "${symbol.toUpperCase()}",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Wrap(
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(intModifier(price),
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                ],
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ), // width: MediaQuery.of(context).size.width * 0.3,
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      constraints:
          BoxConstraints(minWidth: MediaQuery.of(context).size.height * 0.15),
      height: 100,
    );
  }
}

// margin: EdgeInsets.all(5),
// padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
// decoration: BoxDecoration(
// border: Border.all(color: Colors.blueGrey, width: 0.3),
//

// SizedBox(
// child: Image.network(imageUrl),
// height: 50,
// width: 50,
// ),
// SizedBox(
// height: 5,
// ),
// Text(
// name,
// style: TextStyle(
// fontWeight: FontWeight.w700,
// fontSize: 18,
// ),
// ),
// Text(
// intModifier(price),
// style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
// ),
// Text(
// "${price_24_hour.contains("-") ? double.parse(price_24_hour.replaceAll("-", "")).toStringAsFixed(4) : intModifier(price_24_hour)}",
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 18,
// color:
// price_24_hour.contains("-") ? Colors.red : Colors.green),
// ),
// ],
