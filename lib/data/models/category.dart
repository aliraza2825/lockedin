class Category {
  String? category;
  List<Subcategories>? subcategories;

  Category({this.category, this.subcategories});

  Category.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  String? subcategory;
  List<String>? items;

  Subcategories({this.subcategory, this.items});

  Subcategories.fromJson(Map<String, dynamic> json) {
    subcategory = json['subcategory'];
    items= List<String>.from(json['items']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcategory'] = this.subcategory;
    data['items'] = this.items;
    return data;
  }
}
