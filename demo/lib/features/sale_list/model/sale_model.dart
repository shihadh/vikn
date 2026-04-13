class SaleModel {
  final String orderNo;
  final String customerName;
  final String status;
  final double totalAmount;
  final String date;

  SaleModel({
    required this.orderNo,
    required this.customerName,
    required this.status,
    required this.totalAmount,
    required this.date,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      orderNo: json['OrderNo']?.toString() ?? '',
      customerName: json['CustomerName'] ?? '',
      status: json['Status'] ?? 'Pending',
      totalAmount: (json['TotalAmount'] as num?)?.toDouble() ?? 0.0,
      date: json['Date'] ?? '',
    );
  }
}
