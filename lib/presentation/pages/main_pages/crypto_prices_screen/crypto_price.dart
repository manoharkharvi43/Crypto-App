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
                              "${apiStreamData.data?[index].price_change_24h}",
                        );
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
      required this.price_24_hour})
      : super(key: key);
  final String name;
  final String imageUrl;
  final String price;
  final String price_24_hour;

  intModifier(dynamic money) {
    bool isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.tryParse(s) != null;
    }

    if (isNumeric(money)) {
      print("enyer d");
      return NumberFormat.currency(
        symbol: '₹ ',
        locale: "HI",
        decimalDigits: 3,
      ).format(double.parse(money));
    } else {
      print("enyer i");
      return NumberFormat.currency(
        symbol: '₹ ',
        locale: "HI",
      ).format(int.parse(money));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            SizedBox(
              child: Image.network(imageUrl),
              height: 50,
              width: 50,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            Text(
              intModifier(price),
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
            ),
            Text(
              "${price_24_hour.contains("-") ? double.parse(price_24_hour.replaceAll("-", "")).toStringAsFixed(4) : intModifier(price_24_hour)}",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color:
                      price_24_hour.contains("-") ? Colors.red : Colors.green),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.3,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey, width: 0.3),
            borderRadius: BorderRadius.circular(10)),
        constraints: BoxConstraints(
          maxHeight: double.infinity,
        ));
  }
}
