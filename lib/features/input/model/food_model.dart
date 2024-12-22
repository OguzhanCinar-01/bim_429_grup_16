class FoodModel {
  String? name;
  String? type; 
  double? calories;
  double? price;

  FoodModel({
    this.name,
    this.type,
    this.calories,
    this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'calorie': calories,
      'price': price,
    };
  }

  FoodModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'],
        calories = json['calorie'],
        price = json['price'];
}
