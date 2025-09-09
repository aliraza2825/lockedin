import 'package:flutter/material.dart';

class ProjectItems{
  String? type;
  bool? already;
  ExpansionTileController? expCtrl;
  List<Item>? items;

  ProjectItems({this.type,this.already, this.expCtrl, this.items});
}


class Item{
  int? project;
  String? name;
  bool? isSelected;
  int? quantity;
  double? price;

  Item({this.project ,this.name,this.isSelected, this.quantity, this.price});
}