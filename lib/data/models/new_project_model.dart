class NewProject {
  int? type;
  int? category;
  int? subCategory;
  int? budget;
  String? zip;
  String? state;
  int? style;

  NewProject({
    this.type,
    this.category,
    this.subCategory,
    this.budget,
    this.zip,
    this.state,
    this.style,
  });

  // Method to convert from JSON to NewProject
  factory NewProject.fromJson(Map<String, dynamic> json) {
    return NewProject(
      type: json['type'] as int?,
      category: json['category'] as int?,
      subCategory: json['subCategory'] as int?,
      budget: json['budget'] as int?,
      zip: json['zip'] as String?,
      state: json['state'] as String?,
      style: json['style'] as int?,
    );
  }

  // Method to convert from NewProject to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'category': category,
      'subCategory': subCategory,
      'budget': budget,
      'zip': zip,
      'state': state,
      'style': style,
    };
  }
}
