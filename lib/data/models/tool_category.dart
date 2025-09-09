import 'package:medical_courier/data/models/tool.dart';

class ToolCategory {
  String? category;
  List<Tool>? tool;

  ToolCategory({this.category, this.tool});

  ToolCategory.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['tools'] != null) {
      tool = <Tool>[];
      json['tools'].forEach((v) {
        tool!.add( Tool.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['category'] = category;
    if (tool != null) {
      data['tools'] = tool!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
