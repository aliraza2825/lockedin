class DIYInspiration {
  int? id;
  String? title;
  String? thumbnail;
  int? type;
  int? category;
  int? subCategory;
  int? style;

  DIYInspiration(
      {this.id,
        this.title,
        this.thumbnail,
        this.type,
        this.category,
        this.subCategory,
        this.style});

  DIYInspiration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    type = json['type'];
    category = json['category'];
    subCategory = json['sub_category'];
    style = json['style'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['type'] = this.type;
    data['category'] = this.category;
    data['sub_category'] = this.subCategory;
    data['style'] = this.style;
    return data;
  }
}