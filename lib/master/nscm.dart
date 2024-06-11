class NscmData {
  final String exchange;
  final String segment;
  final String token;
  final String symbol;
  final String stockName;
  final String instrumentType;
  final String exp;

  final String lotSize;

  final String multiplier;
  final String freezeQty;
  final String priceBandHigh;
  final String priceBandLow;
  final String futureToken;
  final String close;

  NscmData({
    required this.exchange,
    required this.segment,
    required this.token,
    required this.symbol,
    required this.stockName,
    required this.instrumentType,
    required this.exp,
    required this.lotSize,
    required this.multiplier,
    required this.freezeQty,
    required this.priceBandHigh,
    required this.priceBandLow,
    required this.futureToken,
    required this.close,
  });

  factory NscmData.fromJson(Map<String, dynamic> json) => NscmData(
        exchange: json['Exchange'].toString(),
        segment: json['Segment'].toString(),
        token: json['Token'].toString(),
        symbol: json['symbol'].toString(),
        stockName: json['Stock_name'].toString(),
        instrumentType: json['instrument_type'].toString(),
        exp: json['exp'].toString(),
        // tickSize: json['tick_size'] .toString(),
        lotSize: json['lot_size'].toString(),
        //  strike1: json['strike1'] .toString(),
        multiplier: json['Multiplier'].toString(),
        freezeQty: json['FreezeQty'].toString(),
        priceBandHigh: json['PriceBand_High'].toString(),
        priceBandLow: json['PriceBand_Low'].toString(),
        futureToken: json['futureToken'].toString(),
        close: json['close'].toString(),
      );

  Map<String, Object?> toJson() {
    return {
      'Exchange': exchange,
      'Segment': segment,
      'Token': token,
      'symbol': symbol,
      'Stock_name': stockName,
      'instrument_type': instrumentType,
      'exp': exp,
      // 'tick_size': tickSize,
      'lot_size': lotSize,
      // 'strike1': strike1,
      'Multiplier': multiplier,
      'FreezeQty': freezeQty,
      'PriceBand_High': priceBandHigh,
      'PriceBand_Low': priceBandLow,
      'futureToken': futureToken,
      'close': close,
    };
  }


}
