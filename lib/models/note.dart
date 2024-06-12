class Note {
  String id;
  String productName;
  double price;
  int amount;

  Note({
    required this.id,
    required this.productName,
    required this.price,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'price': price,
      'amount': amount,
    };
  }

  factory Note.fromJson(String id, Map<String, dynamic> json) {
    return Note(
      id: id,
      productName: json['productName'],
      price: json['price'],
      amount: json['amount'],
    );
  }
}
