class FiiHistoryData {
  final Success success;

  FiiHistoryData({required this.success});

  factory FiiHistoryData.fromJson(Map<String, dynamic> json) {
    return FiiHistoryData(
      success: Success.fromJson(json),
    );
  }
}

class Success {
  final String yearMonth;
  final List<String> keyList;
  final Map<String, Data> data;

  Success({required this.yearMonth, required this.keyList, required this.data});


  factory Success.fromJson(Map<String, dynamic> json) {
    var data = Map<String, Data>.from(json['data'].map((key, value) {
      return MapEntry(key, Data.fromJson(value));
    }));

    return Success(
      yearMonth: json['year_month'],
      keyList: List<String>.from(json['key_list']),
      data: data,
    );
  }
}

class Data {
  final Cash cash;
  final FutureData future;
  final Option option;
  final String date;
  final double nifty;
  final double niftyChangePercent;
  final double banknifty;
  final double bankniftyChangePercent;
  final DateTime nextMarketOpen;

  Data({
    required this.cash,
    required this.future,
    required this.option,
    required this.date,
    required this.nifty,
    required this.niftyChangePercent,
    required this.banknifty,
    required this.bankniftyChangePercent,
    required this.nextMarketOpen,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      cash: Cash.fromJson(json['cash']),
      future: FutureData.fromJson(json['future']),
      option: Option.fromJson(json['option']),
      date: json['date'],
      nifty: json['nifty'].toDouble(),
      niftyChangePercent: json['nifty_change_percent'].toDouble(),
      banknifty: json['banknifty'].toDouble(),
      bankniftyChangePercent: json['banknifty_change_percent'].toDouble(),
      nextMarketOpen: DateTime.parse(json['next_market_open']),
    );
  }
}

class Cash {
  final Fii fii;
  final Dii dii;

  Cash({required this.fii, required this.dii});

  factory Cash.fromJson(Map<String, dynamic> json) {
    return Cash(
      fii: Fii.fromJson(json['fii']),
      dii: Dii.fromJson(json['dii']),
    );
  }
}

class Fii {
  final double buySellDifference;
  final double buy;
  final double sell;
  final String netAction;
  final String netView;
  final String netViewStrength;

  Fii({
    required this.buySellDifference,
    required this.buy,
    required this.sell,
    required this.netAction,
    required this.netView,
    required this.netViewStrength,
  });

  factory Fii.fromJson(Map<String, dynamic> json) {
    return Fii(
      buySellDifference: json['buy_sell_difference'].toDouble(),
      buy: json['buy'].toDouble(),
      sell: json['sell'].toDouble(),
      netAction: json['net_action'],
      netView: json['net_view'],
      netViewStrength: json['net_view_strength'],
    );
  }
}

class Dii {
  final double buySellDifference;
  final double buy;
  final double sell;
  final String netAction;
  final String netView;
  final String netViewStrength;

  Dii({
    required this.buySellDifference,
    required this.buy,
    required this.sell,
    required this.netAction,
    required this.netView,
    required this.netViewStrength,
  });

  factory Dii.fromJson(Map<String, dynamic> json) {
    return Dii(
      buySellDifference: json['buy_sell_difference'].toDouble(),
      buy: json['buy'].toDouble(),
      sell: json['sell'].toDouble(),
      netAction: json['net_action'],
      netView: json['net_view'],
      netViewStrength: json['net_view_strength'],
    );
  }
}

class FutureData {
  final FiiFuture fii;
  final DiiFuture dii;
  final ProFuture pro;
  final ClientFuture client;

  FutureData({
    required this.fii,
    required this.dii,
    required this.pro,
    required this.client,
  });

  factory FutureData.fromJson(Map<String, dynamic> json) {
    return FutureData(
      fii: FiiFuture.fromJson(json['fii']),
      dii: DiiFuture.fromJson(json['dii']),
      pro: ProFuture.fromJson(json['pro']),
      client: ClientFuture.fromJson(json['client']),
    );
  }
}

class FiiFuture {
  final QuantityWise quantityWise;
  final AmountWise amountWise;

  FiiFuture({required this.quantityWise, required this.amountWise});

  factory FiiFuture.fromJson(Map<String, dynamic> json) {
    return FiiFuture(
      quantityWise: QuantityWise.fromJson(json['quantity-wise']),
      amountWise: AmountWise.fromJson(json['amount-wise']),
    );
  }
}

class QuantityWise {
  final double outstandingOi;
  final double netOi;
  final double finniftyNetOi;
  final double bankniftyNetOi;
  final double niftyNetOi;
  final double midcpniftyNetOi;
  final String finniftyNetAction;
  final String finniftyNetView;
  final String finniftyNetViewStrength;
  final String bankniftyNetAction;
  final String bankniftyNetView;
  final String bankniftyNetViewStrength;
  final String niftyNetAction;
  final String niftyNetView;
  final String niftyNetViewStrength;
  final String midcpniftyNetAction;
  final String midcpniftyNetView;
  final String midcpniftyNetViewStrength;
  final String netAction;
  final String netView;
  final String netViewStrength;

  QuantityWise({
    required this.outstandingOi,
    required this.netOi,
    required this.finniftyNetOi,
    required this.bankniftyNetOi,
    required this.niftyNetOi,
    required this.midcpniftyNetOi,
    required this.finniftyNetAction,
    required this.finniftyNetView,
    required this.finniftyNetViewStrength,
    required this.bankniftyNetAction,
    required this.bankniftyNetView,
    required this.bankniftyNetViewStrength,
    required this.niftyNetAction,
    required this.niftyNetView,
    required this.niftyNetViewStrength,
    required this.midcpniftyNetAction,
    required this.midcpniftyNetView,
    required this.midcpniftyNetViewStrength,
    required this.netAction,
    required this.netView,
    required this.netViewStrength,
  });

  factory QuantityWise.fromJson(Map<String, dynamic> json) {
    return QuantityWise(
      outstandingOi: json['outstanding_oi'].toDouble(),
      netOi: json['net_oi'].toDouble(),
      finniftyNetOi: json['finnifty_net_oi'].toDouble(),
      bankniftyNetOi: json['banknifty_net_oi'].toDouble(),
      niftyNetOi: json['nifty_net_oi'].toDouble(),
      midcpniftyNetOi: json['midcpnifty_net_oi'].toDouble(),
      finniftyNetAction: json['finnifty_net_action'],
      finniftyNetView: json['finnifty_net_view'],
      finniftyNetViewStrength: json['finnifty_net_view_strength'],
      bankniftyNetAction: json['banknifty_net_action'],
      bankniftyNetView: json['banknifty_net_view'],
      bankniftyNetViewStrength: json['banknifty_net_view_strength'],
      niftyNetAction: json['nifty_net_action'],
      niftyNetView: json['nifty_net_view'],
      niftyNetViewStrength: json['nifty_net_view_strength'],
      midcpniftyNetAction: json['midcpnifty_net_action'],
      midcpniftyNetView: json['midcpnifty_net_view'],
      midcpniftyNetViewStrength: json['midcpnifty_net_view_strength'],
      netAction: json['net_action'],
      netView: json['net_view'],
      netViewStrength: json['net_view_strength'],
    );
  }
}

class AmountWise {
  final double netOi;
  final double finniftyNetOi;
  final double bankniftyNetOi;
  final double niftyNetOi;
  final double midcpniftyNetOi;
  final String finniftyNetView;
  final String bankniftyNetView;
  final String niftyNetView;
  final String midcpniftyNetView;
  final String netView;

  AmountWise({
    required this.netOi,
    required this.finniftyNetOi,
    required this.bankniftyNetOi,
    required this.niftyNetOi,
    required this.midcpniftyNetOi,
    required this.finniftyNetView,
    required this.bankniftyNetView,
    required this.niftyNetView,
    required this.midcpniftyNetView,
    required this.netView,
  });

  factory AmountWise.fromJson(Map<String, dynamic> json) {
    return AmountWise(
      netOi: json['net_oi'].toDouble(),
      finniftyNetOi: json['finnifty_net_oi'].toDouble(),
      bankniftyNetOi: json['banknifty_net_oi'].toDouble(),
      niftyNetOi: json['nifty_net_oi'].toDouble(),
      midcpniftyNetOi: json['midcpnifty_net_oi'].toDouble(),
      finniftyNetView: json['finnifty_net_view'],
      bankniftyNetView: json['banknifty_net_view'],
      niftyNetView: json['nifty_net_view'],
      midcpniftyNetView: json['midcpnifty_net_view'],
      netView: json['net_view'],
    );
  }
}

class DiiFuture {
  final double netOi;
  final double outstandingOi;
  final String netAction;
  final String netView;
  final String netViewStrength;

  DiiFuture({
    required this.netOi,
    required this.outstandingOi,
    required this.netAction,
    required this.netView,
    required this.netViewStrength,
  });

  factory DiiFuture.fromJson(Map<String, dynamic> json) {
    return DiiFuture(
      netOi: json['quantity-wise']['net_oi'].toDouble(),
      outstandingOi: json['quantity-wise']['outstanding_oi'].toDouble(),
      netAction: json['quantity-wise']['net_action'],
      netView: json['quantity-wise']['net_view'],
      netViewStrength: json['quantity-wise']['net_view_strength'],
    );
  }
}

class ProFuture {
  final double netOi;
  final double outstandingOi;
  final String netAction;
  final String netView;
  final String netViewStrength;

  ProFuture({
    required this.netOi,
    required this.outstandingOi,
    required this.netAction,
    required this.netView,
    required this.netViewStrength,
  });

  factory ProFuture.fromJson(Map<String, dynamic> json) {
    return ProFuture(
      netOi: json['quantity-wise']['net_oi'].toDouble(),
      outstandingOi: json['quantity-wise']['outstanding_oi'].toDouble(),
      netAction: json['quantity-wise']['net_action'],
      netView: json['quantity-wise']['net_view'],
      netViewStrength: json['quantity-wise']['net_view_strength'],
    );
  }
}

class ClientFuture {
  final double netOi;
  final double outstandingOi;
  final String netAction;
  final String netView;
  final String netViewStrength;

  ClientFuture({
    required this.netOi,
    required this.outstandingOi,
    required this.netAction,
    required this.netView,
    required this.netViewStrength,
  });

  factory ClientFuture.fromJson(Map<String, dynamic> json) {
    return ClientFuture(
      netOi: json['quantity-wise']['net_oi'].toDouble(),
      outstandingOi: json['quantity-wise']['outstanding_oi'].toDouble(),
      netAction: json['quantity-wise']['net_action'],
      netView: json['quantity-wise']['net_view'],
      netViewStrength: json['quantity-wise']['net_view_strength'],
    );
  }
}

class Option {
  final FiiOption fii;
  final DiiOption dii;
  final ProOption pro;
  final ClientOption client;

  Option({
    required this.fii,
    required this.dii,
    required this.pro,
    required this.client,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      fii: FiiOption.fromJson(json['fii']),
      dii: DiiOption.fromJson(json['dii']),
      pro: ProOption.fromJson(json['pro']),
      client: ClientOption.fromJson(json['client']),
    );
  }
}

class FiiOption {
  final Call call;
  final Put put;
  final double overallNetOi;
  final double overallNetOiChange;
  final String overallNetOiChangeAction;
  final String overallNetOiChangeViewSummary;
  final String overallNetOiChangeViewSummaryStrength;
  final String overallNetOiChangeView;
  final String overallNetOiChangeViewStrength;

  FiiOption({
    required this.call,
    required this.put,
    required this.overallNetOi,
    required this.overallNetOiChange,
    required this.overallNetOiChangeAction,
    required this.overallNetOiChangeViewSummary,
    required this.overallNetOiChangeViewSummaryStrength,
    required this.overallNetOiChangeView,
    required this.overallNetOiChangeViewStrength,
  });

  factory FiiOption.fromJson(Map<String, dynamic> json) {
    return FiiOption(
      call: Call.fromJson(json['call']),
      put: Put.fromJson(json['put']),
      overallNetOi: json['overall_net_oi'].toDouble(),
      overallNetOiChange: json['overall_net_oi_change'].toDouble(),
      overallNetOiChangeAction: json['overall_net_oi_change_action'],
      overallNetOiChangeViewSummary: json['overall_net_oi_change_view_summary'],
      overallNetOiChangeViewSummaryStrength: json['overall_net_oi_change_view_summary_strength'],
      overallNetOiChangeView: json['overall_net_oi_change_view'],
      overallNetOiChangeViewStrength: json['overall_net_oi_change_view_strength'],
    );
  }
}

class Call {
  final Oi long;
  final Oi short;
  final double netOi;
  final double netOiChange;
  final String netOiChangeAction;
  final String netOiChangeViewSummary;
  final String netOiChangeViewSummaryStrength;
  final String netOiChangeView;
  final String netOiChangeViewStrength;

  Call({
    required this.long,
    required this.short,
    required this.netOi,
    required this.netOiChange,
    required this.netOiChangeAction,
    required this.netOiChangeViewSummary,
    required this.netOiChangeViewSummaryStrength,
    required this.netOiChangeView,
    required this.netOiChangeViewStrength,
  });

  factory Call.fromJson(Map<String, dynamic> json) {
    return Call(
      long: Oi.fromJson(json['long']),
      short: Oi.fromJson(json['short']),
      netOi: json['net_oi'].toDouble(),
      netOiChange: json['net_oi_change'].toDouble(),
      netOiChangeAction: json['net_oi_change_action'],
      netOiChangeViewSummary: json['net_oi_change_view_summary'],
      netOiChangeViewSummaryStrength: json['net_oi_change_view_summary_strength'],
      netOiChangeView: json['net_oi_change_view'],
      netOiChangeViewStrength: json['net_oi_change_view_strength'],
    );
  }
}

class Put {
  final Oi long;
  final Oi short;
  final double netOi;
  final double netOiChange;
  final String netOiChangeAction;
  final String netOiChangeViewSummary;
  final String netOiChangeViewSummaryStrength;
  final String netOiChangeView;
  final String netOiChangeViewStrength;

  Put({
    required this.long,
    required this.short,
    required this.netOi,
    required this.netOiChange,
    required this.netOiChangeAction,
    required this.netOiChangeViewSummary,
    required this.netOiChangeViewSummaryStrength,
    required this.netOiChangeView,
    required this.netOiChangeViewStrength,
  });

  factory Put.fromJson(Map<String, dynamic> json) {
    return Put(
      long: Oi.fromJson(json['long']),
      short: Oi.fromJson(json['short']),
      netOi: json['net_oi'].toDouble(),
      netOiChange: json['net_oi_change'].toDouble(),
      netOiChangeAction: json['net_oi_change_action'],
      netOiChangeViewSummary: json['net_oi_change_view_summary'],
      netOiChangeViewSummaryStrength: json['net_oi_change_view_summary_strength'],
      netOiChangeView: json['net_oi_change_view'],
      netOiChangeViewStrength: json['net_oi_change_view_strength'],
    );
  }
}

class Oi {
  final double oiCurrent;
  final double oiChange;

  Oi({required this.oiCurrent, required this.oiChange});

  factory Oi.fromJson(Map<String, dynamic> json) {
    return Oi(
      oiCurrent: json['oi_current'].toDouble(),
      oiChange: json['oi_change'].toDouble(),
    );
  }
}

class DiiOption {
  final Call call;
  final Put put;
  final double overallNetOi;
  final double overallNetOiChange;
  final String overallNetOiChangeAction;
  final String overallNetOiChangeViewSummary;
  final String overallNetOiChangeViewSummaryStrength;
  final String overallNetOiChangeView;
  final String overallNetOiChangeViewStrength;

  DiiOption({
    required this.call,
    required this.put,
    required this.overallNetOi,
    required this.overallNetOiChange,
    required this.overallNetOiChangeAction,
    required this.overallNetOiChangeViewSummary,
    required this.overallNetOiChangeViewSummaryStrength,
    required this.overallNetOiChangeView,
    required this.overallNetOiChangeViewStrength,
  });

  factory DiiOption.fromJson(Map<String, dynamic> json) {
    return DiiOption(
      call: Call.fromJson(json['call']),
      put: Put.fromJson(json['put']),
      overallNetOi: json['overall_net_oi'].toDouble(),
      overallNetOiChange: json['overall_net_oi_change'].toDouble(),
      overallNetOiChangeAction: json['overall_net_oi_change_action'],
      overallNetOiChangeViewSummary: json['overall_net_oi_change_view_summary'],
      overallNetOiChangeViewSummaryStrength: json['overall_net_oi_change_view_summary_strength'],
      overallNetOiChangeView: json['overall_net_oi_change_view'],
      overallNetOiChangeViewStrength: json['overall_net_oi_change_view_strength'],
    );
  }
}

class ProOption {
  final Call call;
  final Put put;
  final double overallNetOi;
  final double overallNetOiChange;
  final String overallNetOiChangeAction;
  final String overallNetOiChangeViewSummary;
  final String overallNetOiChangeViewSummaryStrength;
  final String overallNetOiChangeView;
  final String overallNetOiChangeViewStrength;

  ProOption({
    required this.call,
    required this.put,
    required this.overallNetOi,
    required this.overallNetOiChange,
    required this.overallNetOiChangeAction,
    required this.overallNetOiChangeViewSummary,
    required this.overallNetOiChangeViewSummaryStrength,
    required this.overallNetOiChangeView,
    required this.overallNetOiChangeViewStrength,
  });

  factory ProOption.fromJson(Map<String, dynamic> json) {
    return ProOption(
      call: Call.fromJson(json['call']),
      put: Put.fromJson(json['put']),
      overallNetOi: json['overall_net_oi'].toDouble(),
      overallNetOiChange: json['overall_net_oi_change'].toDouble(),
      overallNetOiChangeAction: json['overall_net_oi_change_action'],
      overallNetOiChangeViewSummary: json['overall_net_oi_change_view_summary'],
      overallNetOiChangeViewSummaryStrength: json['overall_net_oi_change_view_summary_strength'],
      overallNetOiChangeView: json['overall_net_oi_change_view'],
      overallNetOiChangeViewStrength: json['overall_net_oi_change_view_strength'],
    );
  }
}

class ClientOption {
  final Call call;
  final Put put;
  final double overallNetOi;
  final double overallNetOiChange;
  final String overallNetOiChangeAction;
  final String overallNetOiChangeViewSummary;
  final String overallNetOiChangeViewSummaryStrength;
  final String overallNetOiChangeView;
  final String overallNetOiChangeViewStrength;

  ClientOption({
    required this.call,
    required this.put,
    required this.overallNetOi,
    required this.overallNetOiChange,
    required this.overallNetOiChangeAction,
    required this.overallNetOiChangeViewSummary,
    required this.overallNetOiChangeViewSummaryStrength,
    required this.overallNetOiChangeView,
    required this.overallNetOiChangeViewStrength,
  });

  factory ClientOption.fromJson(Map<String, dynamic> json) {
    return ClientOption(
      call: Call.fromJson(json['call']),
      put: Put.fromJson(json['put']),
      overallNetOi: json['overall_net_oi'].toDouble(),
      overallNetOiChange: json['overall_net_oi_change'].toDouble(),
      overallNetOiChangeAction: json['overall_net_oi_change_action'],
      overallNetOiChangeViewSummary: json['overall_net_oi_change_view_summary'],
      overallNetOiChangeViewSummaryStrength: json['overall_net_oi_change_view_summary_strength'],
      overallNetOiChangeView: json['overall_net_oi_change_view'],
      overallNetOiChangeViewStrength: json['overall_net_oi_change_view_strength'],
    );
  }
}
