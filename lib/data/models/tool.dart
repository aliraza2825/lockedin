
import 'package:locked_in/data/models/tool_category.dart';

class Tool {
  int? id;
  String? name;
  String? description;
  String? thumbnail;
  String? tutorialUrl;
  ToolCategory? category;

  Tool(
      {this.id,
        this.name,
        this.description,
        this.category,
        this.thumbnail,
        this.tutorialUrl,});

  Tool.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    tutorialUrl = json['tutorial_url'];
    if(json['category']!=null){
      category = ToolCategory.fromJson(json['category']);
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    data['tutorial_url'] = this.tutorialUrl;
    if(category!=null){
      data['tutorial_url'] = this.category!.toJson();
    }

    return data;
  }
}
