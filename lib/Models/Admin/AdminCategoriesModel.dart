import 'dart:convert';

AdminCategoriesModel categoriesProductsFromJson(String str) =>
    AdminCategoriesModel.fromJson(json.decode(str));

String categoriesProductsToJson(AdminCategoriesModel data) =>
    json.encode(data.toJson());

class AdminCategoriesModel {
  AdminCategoriesModel({
    this.resp,
    this.msj,
    this.categories,
  });

  bool resp;
  String msj;
  List<Category> categories;

  factory AdminCategoriesModel.fromJson(Map<String, dynamic> json) =>
      AdminCategoriesModel(
        resp: json["resp"],
        msj: json["msj"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "msj": msj,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.status,
    this.id,
    this.category,
    this.picture,
    this.v,
  });

  bool status;
  String id;
  String category;
  String picture;
  int v;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        status: json["status"],
        id: json["_id"],
        category: json["category"],
        picture: json["picture"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "category": category,
        "picture": picture,
        "__v": v,
      };
}
