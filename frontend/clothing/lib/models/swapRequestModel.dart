class SwapRequestModel {
  final String requestId;
  final String fromUserId;
  final String toUserId;
  final String offeredProductId;
  final String requestedProductId;
  final String status; // pending, accepted, rejected
  final DateTime createdAt;

  SwapRequestModel({
    required this.requestId,
    required this.fromUserId,
    required this.toUserId,
    required this.offeredProductId,
    required this.requestedProductId,
    this.status = 'pending',
    required this.createdAt,
  });

  factory SwapRequestModel.fromSnapshot(Map<String, dynamic> json) {
    return SwapRequestModel(
      requestId: json['requestId'],
      fromUserId: json['fromUserId'],
      toUserId: json['toUserId'],
      offeredProductId: json['offeredProductId'],
      requestedProductId: json['requestedProductId'],
      status: json['status'] ?? 'pending',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toMap() => {
    'requestId': requestId,
    'fromUserId': fromUserId,
    'toUserId': toUserId,
    'offeredProductId': offeredProductId,
    'requestedProductId': requestedProductId,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
  };

  Map<String, dynamic> toJson() => toMap();
}
