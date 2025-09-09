class ProjectType {
  int? id;
  String? type;
  bool? withSize;
  bool? withZip;
  List<Categories>? categories;

  ProjectType(
      {this.id, this.type, this.withSize, this.withZip, this.categories});

  ProjectType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    withSize = json['with_size'];
    withZip = json['with_zip'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['with_size'] = this.withSize;
    data['with_zip'] = this.withZip;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? category;
  List<SubCategories>? subCategories;

  Categories({this.id, this.category, this.subCategories});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int? id;
  String? subCategory;
  List<Styles>? styles;

  SubCategories({this.id, this.subCategory, this.styles});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCategory = json['sub_category'];
    if (json['styles'] != null) {
      styles = <Styles>[];
      json['styles'].forEach((v) {
        styles!.add(new Styles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_category'] = this.subCategory;
    if (this.styles != null) {
      data['styles'] = this.styles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Styles {
  String? style;
  int? id;

  Styles({this.style, this.id});

  Styles.fromJson(Map<String, dynamic> json) {
    style = json['style'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['style'] = this.style;
    data['id'] = this.id;
    return data;
  }
}

