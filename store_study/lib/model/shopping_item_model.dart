class ShoppingItemModel {
  // 이름
  final String name;
  // 갯수
  final int quantity;
  // 구매했는지
  final bool hasBought;
  // 매운지
  final bool isSpicy;

  ShoppingItemModel({
    required this.name,
    required this.quantity,
    required this.hasBought,
    required this.isSpicy,
  });

  ShoppingItemModel copyWith({
    // 이름
    String? name,
    // 갯수
    int? quantity,
    // 구매했는지
    bool? hasBought,
    // 매운지
    bool? isSpicy,
  }) {
    return ShoppingItemModel(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      hasBought: hasBought ?? this.hasBought,
      isSpicy: isSpicy ?? this.isSpicy,
    );
  }
}
