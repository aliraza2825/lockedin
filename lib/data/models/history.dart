
import 'package:medical_courier/data/models/searchParam.dart';

class History {
  int? id;
  ProjectType? type;
  Categories? category;
  SubCategories? subcategory;
  Styles? style;
  String? createdAt;
  String? updatedAt;
  String? query;
  double? price;
  String? zipCode;
  String? state;
  String? size;

  History(
      {this.id,
        this.type,
        this.category,
        this.subcategory,
        this.style,
        this.createdAt,
        this.updatedAt,
        this.query,
        this.price,
        this.zipCode,
        this.state,
        this.size});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // type = json['type'];
    if(json['type']!=null){
      type = ProjectType.fromJson(json['type']);
    }
    if(json['category']!=null){
      category = Categories.fromJson(json['category']);
    }
    if(json['subcategory']!=null){
      subcategory = SubCategories.fromJson(json['subcategory']);
    }
    // category = json['category'];
    // subcategory = json['subcategory'];
    // style = json['style'];
    if(json['style']!=null){
      style = Styles.fromJson(json['style']);
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    query = json['query'];
    price = json['price']??0;
    zipCode = json['zip_code']??'';
    state = json['state']??'';
    size = json['size']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['style'] = this.style;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['query'] = this.query;
    data['price'] = this.price;
    data['zip_code'] = this.zipCode;
    data['state'] = this.state;
    data['size'] = this.size;
    return data;
  }
}
