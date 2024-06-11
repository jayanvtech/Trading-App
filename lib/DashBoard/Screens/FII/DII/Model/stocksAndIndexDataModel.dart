class FiiData {
  final String foDate;
  final String fiiGrossPurchaseFut;
  final String fiiGrossSalesFut;
  final String fiiNetPurchaseSalesFut;
  final String fiiGrossPurchaseOp;
  final String fiiGrossSalesOp;
  final String fiiNetPurchaseSalesOp;
  final String updatedDate;

  FiiData({
    required this.foDate,
    required this.fiiGrossPurchaseFut,
    required this.fiiGrossSalesFut,
    required this.fiiNetPurchaseSalesFut,
    required this.fiiGrossPurchaseOp,
    required this.fiiGrossSalesOp,
    required this.fiiNetPurchaseSalesOp,
    required this.updatedDate,
  });

  factory FiiData.fromJson(Map<String, dynamic> json) {
    return FiiData(
      foDate: json['fo_date'],
      fiiGrossPurchaseFut: json['fii_gross_purchase_fut'],
      fiiGrossSalesFut: json['fii_gross_sales_fut'],
      fiiNetPurchaseSalesFut: json['fii_net_purchase_sales_fut'],
      fiiGrossPurchaseOp: json['fii_gross_purchase_op'],
      fiiGrossSalesOp: json['fii_gross_sales_op'],
      fiiNetPurchaseSalesOp: json['fii_net_purchase_sales_op'],
      updatedDate: json['updated_date'],
    );
  }
}
