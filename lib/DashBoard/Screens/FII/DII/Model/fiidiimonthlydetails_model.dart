class FiiDiiDetails {
  final String cashDate;
  final String cashFiiGrossPurchase;
  final String cashFiiGrossSales;
  final String cashFiiNetPurchaseSales;
  final String cashDiiGrossPurchase;
  final String cashDiiGrossSales;
  final String cashDiiNetPurchaseSales;
  final String updatedDate;

  FiiDiiDetails({
    required this.cashDate,
    required this.cashFiiGrossPurchase,
    required this.cashFiiGrossSales,
    required this.cashFiiNetPurchaseSales,
    required this.cashDiiGrossPurchase,
    required this.cashDiiGrossSales,
    required this.cashDiiNetPurchaseSales,
    required this.updatedDate,
  });

  factory FiiDiiDetails.fromJson(Map<String, dynamic> json) {
    return FiiDiiDetails(
      cashDate: json['cahs_date '].toString(), // Corrected key and trimmed
      cashFiiGrossPurchase: (json['cash_fii_gross_purchase'] as String).replaceAll(',', ''),
      cashFiiGrossSales: (json['cash_fii_gross_sales'] as String).replaceAll(',', ''),
      cashFiiNetPurchaseSales: (json['cash_fii_net_purchase_sales'] as String).replaceAll(',', ''),
      cashDiiGrossPurchase: (json['cash_dii_gross_purchase'] as String).replaceAll(',', ''),
      cashDiiGrossSales: (json['cash_dii_gross_sales'] as String).replaceAll(',', ''),
      cashDiiNetPurchaseSales: (json['cash_dii_net_purchase_sales'] as String).replaceAll(',', ''),
      updatedDate: json['updated_date'].toString(),
    );
  }
}
