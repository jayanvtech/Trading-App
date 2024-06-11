class Balance {
  final String limitHeader;
  final String cashAvailable;
  final double collateral;
  final String marginUtilized;
  final String netMarginAvailable;
  final String mtm;
  final String unrealizedMTM;
  final String realizedMTM;
  final String cashMarginAvailable;
  final String adhocMargin;
  final String notinalCash;
  final String payInAmount;
  final String payOutAmount;
  final String cncsellBenifit;
  final String directCollateral;
  final String holdingCollateral;
  final String clientBranchAdhoc;
  final String sellOptionsPremium;
  final String netOptionPremium;
  final String buyOptionsPremium;
  final String totalBranchAdhoc;
  final String adhocFOMargin;
  final String adhocCurrencyMargin;
  final String adhocCommodityMargin;
  final double pledgeCollateralBenefit;
  final String grossExposureMarginPresent;
  final String buyExposureMarginPresent;
  final String sellExposureMarginPresent;
  final String varELMarginPresent;
  final String scripBasketMarginPresent;
  final String grossExposureLimitPresent;
  final String buyExposureLimitPresent;
  final String sellExposureLimitPresent;
  final String cncLimitUsed;
  final String cncAmountUsed;
  final String marginUsed;
  final String limitUsed;
  final String totalSpanMargin;
  final String exposureMarginPresent;
  final String cncLimit;
  final String turnoverLimitPresent;
  final String mtmLossLimitPresent;
  final String buyExposureLimit;
  final String sellExposureLimit;
  final String grossExposureLimit;
  final String grossExposureDerivativesLimit;
  final String buyExposureFuturesLimit;
  final String buyExposureOptionsLimit;
  final String sellExposureOptionsLimit;
  final String sellExposureFuturesLimit;
  final String accountID;

  Balance({
    required this.limitHeader,
    required this.cashAvailable,
    required this.collateral,
    required this.marginUtilized,
    required this.netMarginAvailable,
    required this.mtm,
    required this.unrealizedMTM,
    required this.realizedMTM,
    required this.cashMarginAvailable,
    required this.adhocMargin,
    required this.notinalCash,
    required this.payInAmount,
    required this.payOutAmount,
    required this.cncsellBenifit,
    required this.directCollateral,
    required this.holdingCollateral,
    required this.clientBranchAdhoc,
    required this.sellOptionsPremium,
    required this.netOptionPremium,
    required this.buyOptionsPremium,
    required this.totalBranchAdhoc,
    required this.adhocFOMargin,
    required this.adhocCurrencyMargin,
    required this.adhocCommodityMargin,
    required this.pledgeCollateralBenefit,
    required this.grossExposureMarginPresent,
    required this.buyExposureMarginPresent,
    required this.sellExposureMarginPresent,
    required this.varELMarginPresent,
    required this.scripBasketMarginPresent,
    required this.grossExposureLimitPresent,
    required this.buyExposureLimitPresent,
    required this.sellExposureLimitPresent,
    required this.cncLimitUsed,
    required this.cncAmountUsed,
    required this.marginUsed,
    required this.limitUsed,
    required this.totalSpanMargin,
    required this.exposureMarginPresent,
    required this.cncLimit,
    required this.turnoverLimitPresent,
    required this.mtmLossLimitPresent,
    required this.buyExposureLimit,
    required this.sellExposureLimit,
    required this.grossExposureLimit,
    required this.grossExposureDerivativesLimit,
    required this.buyExposureFuturesLimit,
    required this.buyExposureOptionsLimit,
    required this.sellExposureOptionsLimit,
    required this.sellExposureFuturesLimit,
    required this.accountID,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    final limitObject = json['limitObject'];
    return Balance(
      limitHeader: json['limitHeader'].toString(),
      cashAvailable: limitObject['RMSSubLimits']['cashAvailable'].toString(),
      collateral: limitObject['RMSSubLimits']['collateral'].toDouble(),
      marginUtilized: limitObject['RMSSubLimits']['marginUtilized'].toString(),
      netMarginAvailable: limitObject['RMSSubLimits']['netMarginAvailable'].toString(),
      mtm: limitObject['RMSSubLimits']['MTM'].toString(),
      unrealizedMTM: limitObject['RMSSubLimits']['UnrealizedMTM'].toString(),
      realizedMTM: limitObject['RMSSubLimits']['RealizedMTM'].toString(),
      cashMarginAvailable: limitObject['marginAvailable']['CashMarginAvailable'].toString(),
      adhocMargin: limitObject['marginAvailable']['AdhocMargin'].toString(),
      notinalCash: limitObject['marginAvailable']['NotinalCash'].toString(),
      payInAmount: limitObject['marginAvailable']['PayInAmount'].toString(),
      payOutAmount: limitObject['marginAvailable']['PayOutAmount'].toString(),
      cncsellBenifit: limitObject['marginAvailable']['CNCSellBenifit'].toString(),
      directCollateral: limitObject['marginAvailable']['DirectCollateral'].toString(),
      holdingCollateral: limitObject['marginAvailable']['HoldingCollateral'].toString(),
      clientBranchAdhoc: limitObject['marginAvailable']['ClientBranchAdhoc'].toString(),
      sellOptionsPremium: limitObject['marginAvailable']['SellOptionsPremium'].toString(),
      netOptionPremium: limitObject['marginAvailable']['NetOptionPremium'].toString(),
      buyOptionsPremium: limitObject['marginAvailable']['BuyOptionsPremium'].toString(),
      totalBranchAdhoc: limitObject['marginAvailable']['TotalBranchAdhoc'].toString(),
      adhocFOMargin: limitObject['marginAvailable']['AdhocFOMargin'].toString(),
      adhocCurrencyMargin: limitObject['marginAvailable']['AdhocCurrencyMargin'].toString(),
      adhocCommodityMargin: limitObject['marginAvailable']['AdhocCommodityMargin'].toString(),
      pledgeCollateralBenefit: limitObject['marginAvailable']['PledgeCollateralBenefit'].toDouble(),
      grossExposureMarginPresent: limitObject['marginUtilized']['GrossExposureMarginPresent'].toString(),
      buyExposureMarginPresent: limitObject['marginUtilized']['BuyExposureMarginPresent'].toString(),
      sellExposureMarginPresent: limitObject['marginUtilized']['SellExposureMarginPresent'].toString(),
      varELMarginPresent: limitObject['marginUtilized']['VarELMarginPresent'].toString(),
      scripBasketMarginPresent: limitObject['marginUtilized']['ScripBasketMarginPresent'].toString(),
      grossExposureLimitPresent: limitObject['marginUtilized']['GrossExposureLimitPresent'].toString(),
      buyExposureLimitPresent: limitObject['marginUtilized']['BuyExposureLimitPresent'].toString(),
      sellExposureLimitPresent: limitObject['marginUtilized']['SellExposureLimitPresent'].toString(),
      cncLimitUsed: limitObject['marginUtilized']['CNCLimitUsed'].toString(),
      cncAmountUsed: limitObject['marginUtilized']['CNCAmountUsed'].toString(),
      marginUsed: limitObject['marginUtilized']['MarginUsed'].toString(),
      limitUsed: limitObject['marginUtilized']['LimitUsed'].toString(),
      totalSpanMargin: limitObject['marginUtilized']['TotalSpanMargin'].toString(),
      exposureMarginPresent: limitObject['marginUtilized']['ExposureMarginPresent'].toString(),
      cncLimit: limitObject['limitsAssigned']['CNCLimit'].toString(),
      turnoverLimitPresent: limitObject['limitsAssigned']['TurnoverLimitPresent'].toString(),
      mtmLossLimitPresent: limitObject['limitsAssigned']['MTMLossLimitPresent'].toString(),
      buyExposureLimit: limitObject['limitsAssigned']['BuyExposureLimit'].toString(),
      sellExposureLimit: limitObject['limitsAssigned']['SellExposureLimit'].toString(),
      grossExposureLimit: limitObject['limitsAssigned']['GrossExposureLimit'].toString(),
      grossExposureDerivativesLimit: limitObject['limitsAssigned']['GrossExposureDerivativesLimit'].toString(),
      buyExposureFuturesLimit: limitObject['limitsAssigned']['BuyExposureFuturesLimit'].toString(),
      buyExposureOptionsLimit: limitObject['limitsAssigned']['BuyExposureOptionsLimit'].toString(),
      sellExposureOptionsLimit: limitObject['limitsAssigned']['SellExposureOptionsLimit'].toString(),
      sellExposureFuturesLimit: limitObject['limitsAssigned']['SellExposureFuturesLimit'].toString(),
      accountID: limitObject['AccountID'].toString(),
    );
  }
   static List<Balance> filterBalances(List<dynamic> jsonList) {
    var result = jsonList
        .where((json) => json['limitHeader'] == 'ALL|ALL|ALL')
        .map((json) => Balance.fromJson(json))
        .toList();
     
    return result;
        
  }

  static List<Balance>? fromJsonList(Balance response) {}
}
