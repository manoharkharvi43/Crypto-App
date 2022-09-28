class GetApiList {
  final String coinName;
  final String coinPrice;
  final String coinImageUrl;
  final String price_change_percentage_24h;
  final String symbol;

  // final String price_change_percentage_24h;

  GetApiList(
      {required this.coinName,
      required this.coinPrice,
      required this.coinImageUrl,
      required this.price_change_percentage_24h,
      required this.symbol
      // required this.price_change_percentage_24h
      });

  factory GetApiList.fromJson(Map<String, dynamic> json) {
    return GetApiList(
      coinName: json["name"] as String,
      coinPrice: json["current_price"].toString() as String,
      coinImageUrl: json["image"] as String,
      price_change_percentage_24h:
          json["price_change_percentage_24h"].toString() as String,
      symbol: json["symbol"] as String,
      // price_change_percentage_24h:
      //     json["price_change_percentage_24h"] as String
    );
  }

  //price_change_percentage_24h:$price_change_percentage_24h
  @override
  String toString() {
    // TODO: implement toString
    return "{coinName :$coinName , coinPrice:$coinPrice ,coinImageUrl:$coinImageUrl ,price_change_percentage_24h: $price_change_percentage_24h , symbol : $symbol }";
  }
}
