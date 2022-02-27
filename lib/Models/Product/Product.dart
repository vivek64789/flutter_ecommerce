class Product {
  Product({
    this.status,
    this.id,
    this.nameProduct,
    this.description,
    this.codeProduct,
    this.stock,
    this.price,
    this.picture,
    this.categoryId,
    this.v,
  });

  String status;
  String id;
  String nameProduct;
  String description;
  String codeProduct;
  int stock;
  double price;
  String picture;
  String categoryId;
  int v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        status: json["status"],
        id: json["_id"],
        nameProduct: json["nameProduct"],
        description: json["description"],
        codeProduct: json["codeProduct"],
        stock: json["stock"],
        price: json["price"].toDouble(),
        picture: json["picture"],
        categoryId: json["category_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "nameProduct": nameProduct,
        "description": description,
        "codeProduct": codeProduct,
        "stock": stock,
        "price": price,
        "picture": picture,
        "category_id": categoryId,
        "__v": v,
      };
}
