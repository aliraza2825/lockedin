import 'dart:ffi';

class Quote {
  String? retailer;
  bool? supported;
  List<Products>? products;

  Quote({this.retailer, this.supported, this.products});

  Quote.fromJson(Map<String, dynamic> json) {
    retailer = json['retailer'];
    supported = json['supported'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['retailer'] = this.retailer;
    data['supported'] = this.supported;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? category;
  String? product;
  int? quantity;
  List<Result>? result;

  Products({this.category, this.product, this.quantity, this.result});

  Products.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    quantity = json['quantity'];
    product = json['product'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['quantity'] = this.quantity;
    data['product'] = this.product;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? title;
  String? description;
  String? url;
  String? price;
  String? maxPrice;
  String? image;
  String? productId;
  int? quantity;
  int? id;
  bool? isSelected;

  Result({
    this.title,
    this.description,
    this.url,
    this.price,
    this.maxPrice,
    this.image,
    this.quantity,
    this.productId,
    this.id,
    this.isSelected,
  });

  Result.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    url = json['url'];
    price = json['price'];
    maxPrice = json['max_price'];
    image = json['image'];
    quantity = json['quantity'];
    id = json['id'];
    productId = json['product_id'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['price'] = this.price;
    data['max_price'] = this.maxPrice;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['isSelected'] = this.isSelected;
    data['productId'] = this.productId;
    data['id'] = this.id;
    return data;
  }
}
