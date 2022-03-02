import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simple_flutter_app/data/api/models/api_list_model.dart';

final String url1 =
    "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=10&page=1&sparkline=false";

final String url2 =
    "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false";

Future<List<GetApiList>> fetch_10_coins() async {
  final response = await http.get(Uri.parse(url1));
  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<GetApiList> resBody =
        body.map((dynamic data) => GetApiList.fromJson(data)).toList();
    return resBody;
  } else {
    throw Exception("Data fetch Failed");
  }
}

Future<List<GetApiList>> fetch_all_coins() async {
  final response = await http.get(Uri.parse(url2));
  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<GetApiList> resBody =
        body.map((dynamic data) => GetApiList.fromJson(data)).toList();
    return resBody;
  } else {
    throw Exception("Data fetch of all coins  Failed");
  }
}
