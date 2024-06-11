class TradeOrder {
  final String loginID;
  final String clientID;
  final int appOrderID;
  final String orderReferenceID;
  final String generatedBy;
  final String exchangeOrderID;
  final String orderCategoryType;
  final String exchangeSegment;
  final int exchangeInstrumentID;
  final String orderSide;
  final String orderType;
  final String productType;
  final String timeInForce;
  final int orderPrice;
  final int orderQuantity;
  final String tradingSymbol;
  final int orderStopPrice;
  final String orderStatus;
  final String orderAverageTradedPrice;
  final int leavesQuantity;
  final int cumulativeQuantity;
  final int orderDisclosedQuantity;
  final String orderGeneratedDateTime;
  final String exchangeTransactTime;
  final String lastUpdateDateTime;
  final String orderUniqueIdentifier;
  final String orderLegStatus;
  // final double lastTradedPrice;
  final int lastTradedQuantity;
  final String lastExecutionTransactTime;
  final String executionID;
  final int executionReportIndex;
  final bool isSpread;
  final int messageCode;
  final int messageVersion;
  final int tokenID;
  final int applicationType;
  final int sequenceNumber;

  TradeOrder({
    required this.loginID,
    required this.clientID,
    required this.appOrderID,
    required this.orderReferenceID,
    required this.generatedBy,
    required this.exchangeOrderID,
    required this.orderCategoryType,
    required this.exchangeSegment,
    required this.exchangeInstrumentID,
    required this.orderSide,
    required this.orderType,
    required this.productType,
    required this.timeInForce,
    required this.orderPrice,
    required this.orderQuantity,
    required this.tradingSymbol,
    required this.orderStopPrice,
    required this.orderStatus,
    required this.orderAverageTradedPrice,
    required this.leavesQuantity,
    required this.cumulativeQuantity,
    required this.orderDisclosedQuantity,
    required this.orderGeneratedDateTime,
    required this.exchangeTransactTime,
    required this.lastUpdateDateTime,
    required this.orderUniqueIdentifier,
    required this.orderLegStatus,
    // required this.lastTradedPrice,
    required this.lastTradedQuantity,
    required this.lastExecutionTransactTime,
    required this.executionID,
    required this.executionReportIndex,
    required this.isSpread,
    required this.messageCode,
    required this.messageVersion,
    required this.tokenID,
    required this.applicationType,
    required this.sequenceNumber,
  });

  factory TradeOrder.fromJson(Map<String, dynamic> json) {
    return TradeOrder(
      loginID: json['LoginID'],
      clientID: json['ClientID'],
      appOrderID: json['AppOrderID'],
      orderReferenceID: json['OrderReferenceID'],
      generatedBy: json['GeneratedBy'],
      exchangeOrderID: json['ExchangeOrderID'],
      orderCategoryType: json['OrderCategoryType'],
      exchangeSegment: json['ExchangeSegment'],
      exchangeInstrumentID: json['ExchangeInstrumentID'],
      orderSide: json['OrderSide'],
      orderType: json['OrderType'],
      productType: json['ProductType'],
      timeInForce: json['TimeInForce'],
      orderPrice: json['OrderPrice'],
      orderQuantity: json['OrderQuantity'],
      tradingSymbol: json['TradingSymbol'],
      orderStopPrice: json['OrderStopPrice'],
      orderStatus: json['OrderStatus'],
      orderAverageTradedPrice: json['OrderAverageTradedPrice'],
      leavesQuantity: json['LeavesQuantity'],
      cumulativeQuantity: json['CumulativeQuantity'],
      orderDisclosedQuantity: json['OrderDisclosedQuantity'],
      orderGeneratedDateTime: json['OrderGeneratedDateTime'],
      exchangeTransactTime: json['ExchangeTransactTime'],
      lastUpdateDateTime: json['LastUpdateDateTime'],
      orderUniqueIdentifier: json['OrderUniqueIdentifier'],
      orderLegStatus: json['OrderLegStatus'],
      // lastTradedPrice: json['LastTradedPrice'],
      lastTradedQuantity: json['LastTradedQuantity'],
      lastExecutionTransactTime: json['LastExecutionTransactTime'],
      executionID: json['ExecutionID'],
      executionReportIndex: json['ExecutionReportIndex'],
      isSpread: json['IsSpread'],
      messageCode: json['MessageCode'],
      messageVersion: json['MessageVersion'],
      tokenID: json['TokenID'],
      applicationType: json['ApplicationType'],
      sequenceNumber: json['SequenceNumber'],
    );
  }
  static List<TradeOrder> fromJsonList(List<dynamic> list) {
    return list.map((item) => TradeOrder.fromJson(item)).toList();
  }
}

class OrderValues {
  final String loginID;
  final String clientID;
  final int appOrderID;
  final String orderReferenceID;
  final String generatedBy;
  final String exchangeOrderID;
  final String orderCategoryType;
  final String exchangeSegment;
  final int exchangeInstrumentID;
  final String orderSide;
  final String orderType;
  final String productType;
  final String timeInForce;
  final bool isAMO;
  final double orderPrice;
  final int orderQuantity;
  final double orderStopPrice;
  final String tradingSymbol;
  final String orderStatus;
  final String orderAverageTradedPrice;
  final int leavesQuantity;
  final int cumulativeQuantity;
  final int orderDisclosedQuantity;
  final String orderGeneratedDateTime;
  final String exchangeTransactTime;
  final String lastUpdateDateTime;
  final String orderExpiryDate;
  final String cancelRejectReason;
  final String orderUniqueIdentifier;
  final int algoID;
  final int algoCategory;
  final String orderLegStatus;
  final int boLegDetails;
  final bool isSpread;
  final String boEntryOrderId;
  final int messageCode;
  final int messageVersion;
  final int tokenID;
  final int applicationType;
  final int sequenceNumber;

  OrderValues({
    required this.loginID,
    required this.clientID,
    required this.appOrderID,
    required this.orderReferenceID,
    required this.generatedBy,
    required this.exchangeOrderID,
    required this.orderCategoryType,
    required this.exchangeSegment,
    required this.exchangeInstrumentID,
    required this.orderSide,
    required this.orderType,
    required this.productType,
    required this.timeInForce,
    required this.isAMO,
    required this.orderPrice,
    required this.orderQuantity,
    required this.orderStopPrice,
    required this.tradingSymbol,
    required this.orderStatus,
    required this.orderAverageTradedPrice,
    required this.leavesQuantity,
    required this.cumulativeQuantity,
    required this.orderDisclosedQuantity,
    required this.orderGeneratedDateTime,
    required this.exchangeTransactTime,
    required this.lastUpdateDateTime,
    required this.orderExpiryDate,
    required this.cancelRejectReason,
    required this.orderUniqueIdentifier,
    required this.algoID,
    required this.algoCategory,
    required this.orderLegStatus,
    required this.boLegDetails,
    required this.isSpread,
    required this.boEntryOrderId,
    required this.messageCode,
    required this.messageVersion,
    required this.tokenID,
    required this.applicationType,
    required this.sequenceNumber,
  });

  factory OrderValues.fromJson(Map<String, dynamic> json) {
    return OrderValues(
      loginID: json['LoginID'],
      clientID: json['ClientID'],
      appOrderID: json['AppOrderID'],
      orderReferenceID: json['OrderReferenceID'],
      generatedBy: json['GeneratedBy'],
      exchangeOrderID: json['ExchangeOrderID'],
      orderCategoryType: json['OrderCategoryType'],
      exchangeSegment: json['ExchangeSegment'],
      exchangeInstrumentID: json['ExchangeInstrumentID'],
      orderSide: json['OrderSide'],
      orderType: json['OrderType'],
      productType: json['ProductType'],
      timeInForce: json['TimeInForce'],
      isAMO: json['IsAMO'],
      orderPrice: json['OrderPrice'].toDouble(),
      orderQuantity: json['OrderQuantity'],
      orderStopPrice: json['OrderStopPrice'].toDouble(),
      tradingSymbol: json['TradingSymbol'],
      orderStatus: json['OrderStatus'],
      orderAverageTradedPrice: json['OrderAverageTradedPrice'],
      leavesQuantity: json['LeavesQuantity'],
      cumulativeQuantity: json['CumulativeQuantity'],
      orderDisclosedQuantity: json['OrderDisclosedQuantity'],
      orderGeneratedDateTime: json['OrderGeneratedDateTime'],
      exchangeTransactTime: json['ExchangeTransactTime'],
      lastUpdateDateTime: json['LastUpdateDateTime'],
      orderExpiryDate: json['OrderExpiryDate'],
      cancelRejectReason: json['CancelRejectReason'],
      orderUniqueIdentifier: json['OrderUniqueIdentifier'],
      algoID: json['AlgoID'],
      algoCategory: json['AlgoCategory'],
      orderLegStatus: json['OrderLegStatus'],
      boLegDetails: json['BoLegDetails'],
      isSpread: json['IsSpread'],
      boEntryOrderId: json['BoEntryOrderId'],
      messageCode: json['MessageCode'],
      messageVersion: json['MessageVersion'],
      tokenID: json['TokenID'],
      applicationType: json['ApplicationType'],
      sequenceNumber: json['SequenceNumber'],
    );
  }
  static List<OrderValues> fromJsonList(List<dynamic> list) {
    return list.map((item) => OrderValues.fromJson(item)).toList();
  }
}

class Positions {
  final String loginID;
  final String accountID;
  final String tradingSymbol;
  final String exchangeSegment;
  final String exchangeInstrumentId;
  final String productType;
  final String marketLot;
  final String multiplier;
  final double buyAveragePrice;
  final double sellAveragePrice;
  final int openBuyQuantity;
  final int openSellQuantity;
  final int quantity;
  final double buyAmount;
  final double sellAmount;
  final double netAmount;
  final double unrealizedMTM;
  final double realizedMTM;
  final double mtm;
  final double bep;
  final double sumOfTradedQuantityAndPriceBuy;
  final double sumOfTradedQuantityAndPriceSell;
  final double actualSellAmount;
  final double actualSellAveragePrice;
  final double actualBuyAmount;
  final double actualBuyAveragePrice;
  final double sumOfTradedQuantityAndActualPriceBuy;
  final double sumOfTradedQuantityAndActualPriceSell;
  final String statisticsLevel;
  final bool isInterOpPosition;
  //final Map<String, dynamic> childPositions;
  final int messageCode;
  final int messageVersion;
  final int tokenID;
  final int applicationType;
  final int sequenceNumber;

  Positions({
    required this.loginID,
    required this.accountID,
    required this.tradingSymbol,
    required this.exchangeSegment,
    required this.exchangeInstrumentId,
    required this.productType,
    required this.marketLot,
    required this.multiplier,
    required this.buyAveragePrice,
    required this.sellAveragePrice,
    required this.openBuyQuantity,
    required this.openSellQuantity,
    required this.quantity,
    required this.buyAmount,
    required this.sellAmount,
    required this.netAmount,
    required this.unrealizedMTM,
    required this.realizedMTM,
    required this.mtm,
    required this.bep,
    required this.sumOfTradedQuantityAndPriceBuy,
    required this.sumOfTradedQuantityAndPriceSell,
    required this.actualSellAmount,
    required this.actualSellAveragePrice,
    required this.actualBuyAmount,
    required this.actualBuyAveragePrice,
    required this.sumOfTradedQuantityAndActualPriceBuy,
    required this.sumOfTradedQuantityAndActualPriceSell,
    required this.statisticsLevel,
    required this.isInterOpPosition,
    // required this.childPositions,
    required this.messageCode,
    required this.messageVersion,
    required this.tokenID,
    required this.applicationType,
    required this.sequenceNumber,
  });

  factory Positions.fromJson(Map<String, dynamic> json) {
    return Positions(
      loginID: json['LoginID'],
      accountID: json['AccountID'],
      tradingSymbol: json['TradingSymbol'],
      exchangeSegment: json['ExchangeSegment'],
      exchangeInstrumentId: json['ExchangeInstrumentId'],
      productType: json['ProductType'],
      marketLot: json['Marketlot'],
      multiplier: json['Multiplier'],
      buyAveragePrice: double.parse(json['BuyAveragePrice']),
      sellAveragePrice: double.parse(json['SellAveragePrice']),
      openBuyQuantity: int.parse(json['OpenBuyQuantity']),
      openSellQuantity: int.parse(json['OpenSellQuantity']),
      quantity: int.parse(json['Quantity']),
      buyAmount: double.parse(json['BuyAmount']),
      sellAmount: double.parse(json['SellAmount']),
      netAmount: double.parse(json['NetAmount']),
      unrealizedMTM: double.parse(json['UnrealizedMTM']),
      realizedMTM: double.parse(json['RealizedMTM']),
      mtm: double.parse(json['MTM']),
      bep: double.parse(json['BEP']),
      sumOfTradedQuantityAndPriceBuy:
          double.parse(json['SumOfTradedQuantityAndPriceBuy']),
      sumOfTradedQuantityAndPriceSell:
          double.parse(json['SumOfTradedQuantityAndPriceSell']),
      actualSellAmount: json['actualSellAmount'].toDouble(),
      actualSellAveragePrice: json['actualSellAveragePrice'].toDouble(),
      actualBuyAmount: json['actualBuyAmount'].toDouble(),
      actualBuyAveragePrice: json['actualBuyAveragePrice'].toDouble(),
      sumOfTradedQuantityAndActualPriceBuy:
          json['sumOfTradedQuantityAndActualPriceBuy'].toDouble(),
      sumOfTradedQuantityAndActualPriceSell:
          json['sumOfTradedQuantityAndActualPriceSell'].toDouble(),
      statisticsLevel: json['StatisticsLevel'],
      isInterOpPosition: json['IsInterOpPosition'],
      //childPositions: json['childPositions'],
      messageCode: json['MessageCode'],
      messageVersion: json['MessageVersion'],
      tokenID: json['TokenID'],
      applicationType: json['ApplicationType'],
      sequenceNumber: json['SequenceNumber'],
    );
  }
  static List<Positions> fromJsonList(List<dynamic> list) {
    return list.map((item) => Positions.fromJson(item)).toList();
  }
}


class OrderHistory {
  final String exchangeSegment;
  
  final String buySell;
  final String symbol;
  final String instrumentName;
  final String strikePrice;
  final DateTime expiryDate;
  final String optionType;
  final String price;
  final String averagePrice;
  final String totalQty;
  final String pendingQty;
  final String disclosedQty;
  final String validity;
  final DateTime orderEntryTime;
  
  final String orderType;
  final String triggerPrice;
  final String status;
  final String tradeId;
  final String reasonForRejection;
  final String userId;
  final String? remarks;
  final String tradingSymbol;
  final String tradedQty;
  final String traderId;
  final String memberId;
  final String clientOrdId;
  final String originalClientOrdId;
  final String modifiedByUser;

  final String orderSource;
  final String seriesCode;
  final DateTime sellOrderEntryTime;
  final DateTime buyOrderEntryTime;
  final String sellLocationID;
  final String buyLocationID;
 
  final DateTime tradeDate;
  final DateTime settlementDate;

  final DateTime issueDate;
  final DateTime maturityDate;

  final DateTime sipDate;
  final DateTime fillTime;

  final DateTime? tradeModDtTime;
  final String tradePrice;
  final DateTime tradeTime;
  final String? transType;
  final String transTypeString;
  final String validityString;
  final String clientId;
  final String exchangeInstrumentID;


  OrderHistory({

    required this.exchangeSegment,
 
    required this.buySell,
    required this.symbol,
    required this.instrumentName,
    required this.strikePrice,
    required this.expiryDate,
    required this.optionType,
    required this.price,
    required this.averagePrice,
    required this.totalQty,
    required this.pendingQty,
    required this.disclosedQty,
    required this.validity,
    required this.orderEntryTime,

    required this.orderType,
    required this.triggerPrice,
    required this.status,
    required this.tradeId,
    required this.reasonForRejection,
    required this.userId,
    this.remarks,
    required this.tradingSymbol,
    required this.tradedQty,
    required this.traderId,
    required this.memberId,
    required this.clientOrdId,
    required this.originalClientOrdId,
    required this.modifiedByUser,

    required this.orderSource,
    required this.seriesCode,
  
    required this.sellOrderEntryTime,
    required this.buyOrderEntryTime,
    required this.sellLocationID,
    required this.buyLocationID,
   
    required this.tradeDate,
    required this.settlementDate,

    required this.issueDate,
    required this.maturityDate,
   
    required this.sipDate,
   
    required this.fillTime,
   
    this.tradeModDtTime,
    required this.tradePrice,
    required this.tradeTime,
    this.transType,
    required this.transTypeString,
    required this.validityString,
    required this.clientId,
    required this.exchangeInstrumentID,
 
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      
      exchangeSegment: json['ExchangeSegment'],

      buySell: json['BuySell'],
      symbol: json['Symbol'],
      instrumentName: json['InstrumentName'],
      strikePrice: json['StrikePrice'].toString(),
      expiryDate: DateTime.parse(json['ExpiryDate']),
      optionType: json['OptionType'],
      price: json['Price'].toString(),
      averagePrice: json['AveragePrice'].toString(),
      totalQty: json['TotalQty'].toString(),
      pendingQty: json['PendingQty'].toString(),
      disclosedQty: json['DisclosedQty'].toString(),
      validity: json['Validity'],
      orderEntryTime: DateTime.parse(json['OrderEntryTime']),

      orderType: json['OrderType'],
      triggerPrice: json['TriggerPrice'].toString(),
      status: json['Status'],
      tradeId: json['TradeId'].toString(),
      reasonForRejection: json['ReasonforRej'],
      userId: json['UserId'].toString(),
      remarks: json['Remarks'],
      tradingSymbol: json['TradingSymbol'],
      tradedQty: json['TradedQty'].toString(),
      traderId: json['TraderId'].toString(),
      memberId: json['MemberId'].toString(),
      clientOrdId: json['ClientOrdId'].toString(),
      originalClientOrdId: json['OriginalClientOrdId'].toString(),
      modifiedByUser: json['ModifiedByUser'],
     
      orderSource: json['OrderSource'],
      seriesCode: json['SeriesCode'].toString(),
     
      sellOrderEntryTime: DateTime.parse(json['SellOrderEntryTime']),
      buyOrderEntryTime: DateTime.parse(json['BuyOrderEntryTime']),
      sellLocationID: json['SellLocationID'].toString(),
      buyLocationID: json['BuyLocationID'].toString(),
     
      tradeDate: DateTime.parse(json['TradeDate']),
      settlementDate: DateTime.parse(json['SettlementDate']),
     
      issueDate: DateTime.parse(json['IssueDate']),
      maturityDate: DateTime.parse(json['MaturityDate']),
     
      sipDate: DateTime.parse(json['SipDate']),
     
      fillTime: DateTime.parse(json['FillTime']),
     
      tradeModDtTime: json['TradeModDtTime'] != null ? DateTime.parse(json['TradeModDtTime']) : null,
      tradePrice: json['TradePrice'].toString(),
      tradeTime: DateTime.parse(json['TradeTime']),
      transType: json['TransType'],
      transTypeString: json['TransTypeString'],
      validityString: json['ValidityString'],
      clientId: json['ClientID'].toString(),
      exchangeInstrumentID: json['ExchangeInstrumentID'].toString(),
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
     
      'ExchangeSegment': exchangeSegment,
     
      'BuySell': buySell,
      'Symbol': symbol,
      'InstrumentName': instrumentName,
      'StrikePrice': strikePrice,
      'ExpiryDate': expiryDate.toIso8601String(),
      'OptionType': optionType,
      'Price': price,
      'AveragePrice': averagePrice,
      'TotalQty': totalQty,
      'PendingQty': pendingQty,
      'DisclosedQty': disclosedQty,
      'Validity': validity,
      'OrderEntryTime': orderEntryTime.toIso8601String(),
     
      'OrderType': orderType,
      'TriggerPrice': triggerPrice,
      'Status': status,
      'TradeId': tradeId,
      'ReasonforRej': reasonForRejection,
      'UserId': userId,
      'Remarks': remarks,
      'TradingSymbol': tradingSymbol,
      'TradedQty': tradedQty,
      'TraderId': traderId,
      'MemberId': memberId,
      'ClientOrdId': clientOrdId,
      'OriginalClientOrdId': originalClientOrdId,
      'ModifiedByUser': modifiedByUser,
    
      'OrderSource': orderSource,
      'SeriesCode': seriesCode,
      
      'SellOrderEntryTime': sellOrderEntryTime.toIso8601String(),
      'BuyOrderEntryTime': buyOrderEntryTime.toIso8601String(),
      'SellLocationID': sellLocationID,
      'BuyLocationID': buyLocationID,
    'TradeDate': tradeDate.toIso8601String(),
      'SettlementDate': settlementDate.toIso8601String(),
      
      'IssueDate': issueDate.toIso8601String(),
      'MaturityDate': maturityDate.toIso8601String(),
     
      'SipDate': sipDate.toIso8601String(),
     
      'FillTime': fillTime.toIso8601String(),
      
      'TradeModDtTime': tradeModDtTime?.toIso8601String(),
      'TradePrice': tradePrice,
      'TradeTime': tradeTime.toIso8601String(),
      'TransType': transType,
      'TransTypeString': transTypeString,
      'ValidityString': validityString,
      'ClientID': clientId,
      'ExchangeInstrumentID': exchangeInstrumentID,
     
    };
  }
  static List<OrderHistory> fromJsonList(List<dynamic> list) {
    return list.map((item) => OrderHistory.fromJson(item)).toList();
  }
}


class Holdings {
  final String clientID;
  final String isin;
  final String exchangeNSEInstrumentId;
  final String exchangeBSEInstrumentId;
  final String authorizeQuantity;
  final String collateralQty;
  final String hairCut;
  final String buyAvgPrice;
  final String holdingType;
  final String isBuyAvgPriceProvided;
  final String holdingQuantity;
  final String usedQuantity;
  final String collateralValuationType;
  final String pledgeQuantity;

  Holdings({
    required this.clientID,
    required this.isin,
    required this.exchangeNSEInstrumentId,
    required this.exchangeBSEInstrumentId,
    required this.authorizeQuantity,
    required this.collateralQty,
    required this.hairCut,
    required this.buyAvgPrice,
    required this.holdingType,
    required this.isBuyAvgPriceProvided,
    required this.holdingQuantity,
    required this.usedQuantity,
    required this.collateralValuationType,
    required this.pledgeQuantity,
  });

  factory Holdings.fromJson(Map<String, dynamic> json) {
    return Holdings(
      clientID: json['ClientID'].toString(),
      isin: json['ISIN'].toString(),
      exchangeNSEInstrumentId: json['ExchangeNSEInstrumentId'].toString(),
      exchangeBSEInstrumentId: json['ExchangeBSEInstrumentId'].toString(),
      authorizeQuantity: json['AuthorizeQuantity'].toString(),
      collateralQty: json['CollateralQty'].toString(),
      hairCut: json['HairCut'].toString(),
      buyAvgPrice: json['BuyAvgPrice'].toString(),
      holdingType: json['HoldingType'].toString(),
      isBuyAvgPriceProvided: json['IsBuyAvgPriceProvided'].toString(),
      holdingQuantity: json['HoldingQuantity'].toString(),
      usedQuantity: json['UsedQuantity'].toString(),
      collateralValuationType: json['CollateralValuationType'].toString(),
      pledgeQuantity: json['PledgeQuantity'].toString(),
    );
  }
  static List<Holdings> fromJsonList(List<dynamic> list) {
    return list.map((item) => Holdings.fromJson(item)).toList();
  }
}
