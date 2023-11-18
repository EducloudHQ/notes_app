import 'dart:ui';

import 'package:flutter/material.dart';

class MenuModel {
  MenuModel({
    this.title = '',
    this.icon = '',

    this.color=Colors.white
  });

  String title;
  String icon;
  Color color;

  static List<MenuModel> menuModelList = <MenuModel>[
    MenuModel(
       icon: 'assets/document.svg',
      title: 'Document',
      color: Color(0xFFd62976)
    ),
      MenuModel(
  icon: 'assets/folder.svg',
  title: 'Folder',
  color: Color(0xFF962fbf)
  ),
  MenuModel(
  icon: 'assets/create_note.svg',
  title: 'Notes',
  color: Color(0xFFfa7e1e)
  ),


  ];


}
