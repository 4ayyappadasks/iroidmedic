// To parse this JSON data, do
//
//     final mealmodel = mealmodelFromJson(jsonString);

import 'dart:convert';

Mealmodel mealmodelFromJson(String str) => Mealmodel.fromJson(json.decode(str));

String mealmodelToJson(Mealmodel data) => json.encode(data.toJson());

class Mealmodel {
  bool status;
  int code;
  int blocked;
  Data data;
  String message;

  Mealmodel({
    required this.status,
    required this.code,
    required this.blocked,
    required this.data,
    required this.message,
  });

  factory Mealmodel.fromJson(Map<String, dynamic> json) => Mealmodel(
    status: json["status"],
    code: json["code"],
    blocked: json["blocked"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "blocked": blocked,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  List<Banner> banners;
  int notificationCount;
  List<Banner> mealCategories;

  Data({
    required this.banners,
    required this.notificationCount,
    required this.mealCategories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
    notificationCount: json["notification_count"],
    mealCategories: List<Banner>.from(json["meal_categories"].map((x) => Banner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
    "notification_count": notificationCount,
    "meal_categories": List<dynamic>.from(mealCategories.map((x) => x.toJson())),
  };
}

class Banner {
  int id;
  String name;
  String image;
  List<MealPlan>? mealPlans;

  Banner({
    required this.id,
    required this.name,
    required this.image,
    this.mealPlans,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    mealPlans: json["meal_plans"] == null ? [] : List<MealPlan>.from(json["meal_plans"]!.map((x) => MealPlan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "meal_plans": mealPlans == null ? [] : List<dynamic>.from(mealPlans!.map((x) => x.toJson())),
  };
}

class MealPlan {
  int id;
  String name;
  String mealTypes;
  String shortDescription;

  MealPlan({
    required this.id,
    required this.name,
    required this.mealTypes,
    required this.shortDescription,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) => MealPlan(
    id: json["id"],
    name: json["name"],
    mealTypes: json["meal_types"],
    shortDescription: json["short_description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "meal_types": mealTypes,
    "short_description": shortDescription,
  };
}
