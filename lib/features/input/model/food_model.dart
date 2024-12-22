class FoodModel {
  String? name;
  String? type; // 'Meat', 'Auxiliary', 'Bread', 'Water', vs.
  double? calories;
  double? price;

  // Constructor
  FoodModel({
    this.name,
    this.type,
    this.calories,
    this.price,
  });

  // JSON dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'calorie': calories,
      'price': price,
    };
  }

  // JSON'dan model oluşturma
  FoodModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'],
        calories = json['calorie'],
        price = json['price'];
}
