
class FiiDiiDetails {
  final String cashDate;
  final String cashFiiGrossPurchase;
  final String cashFiiGrossSales;
  final String cashFiiNetPurchaseSales;
  final String cashDiiGrossPurchase;
  final String cashDiiGrossSales;
  final String cashDiiNetPurchaseSales;
  final String updatedDate;

  FiiDiiDetails.fromJson(Map<String, dynamic> json)
      : cashDate = json['cash_date'] as String,
        cashFiiGrossPurchase = (json['cash_fii_gross_purchase']),
        cashFiiGrossSales = (json['cash_fii_gross_sales']),
        cashFiiNetPurchaseSales = (json['cash_fii_net_purchase_sales']),
        cashDiiGrossPurchase = json['cash_dii_gross_purchase'],
        cashDiiGrossSales = json['cash_dii_gross_sales'],
        cashDiiNetPurchaseSales = json['cash_dii_net_purchase_sales'],
        updatedDate = json['updated_date'];
}
