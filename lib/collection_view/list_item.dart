import 'package:flutter/material.dart';
import '/tool/string_util.dart';

enum ListCellType {
  other,
  list,
  grid
}

enum ListItemType {
  common,
  selct,
  image,
  info,
  input,
  inputNum,
  inputPhone,
  inputReadOnly,
  date,
  button,
  editNum,
  other
}

class ListItem<T> {
  // 列表头部信息
  int headerId;
  dynamic headerParam;
  // 列表尾部信息
  int footerId;
  dynamic footerParam;
  // 列表内容信息
  ListCellType cellType;
  int cellId;
  List? cellParams;

  // grid格子视图所需参数
  int crossAxisCount; // 纵轴数量
  double mainAxisSpacing; // 主轴间距
  double crossAxisSpacing; // 纵轴间距
  
  // 列表、grid的边距
  EdgeInsetsGeometry padding;

  // 其他信息
  String title;
  String content;
  String imgPathDefault;
  String imgPathSelect;
  bool branch;
  double doubleValue;
  int intValue;
  dynamic param;
  dynamic other;
  List<T>? listData;
  T? data;
  ListItemType itemType;
  void Function()? onTap;
  void Function(dynamic)? onChange;

  ListItem({
    this.headerId = 0,
    this.headerParam,
    this.footerId = 0,
    this.footerParam,
    this.cellId = 0,
    this.cellParams,
    this.crossAxisCount = 1,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.padding = EdgeInsets.zero,
    this.title = '',
    this.content = '',
    this.imgPathDefault = '',
    this.imgPathSelect = '',
    this.branch = false,
    this.doubleValue = 0.0,
    this.intValue = 0,
    this.param,
    this.other,
    this.listData,
    this.data,
    this.cellType = ListCellType.other,
    this.itemType = ListItemType.common,
    this.onTap,
    this.onChange,
  }) {
    // ignore: prefer_is_empty
    if (cellParams == null || cellParams?.length == 0) {
      headerId = 0;
    }
  }

  static ListItem? genNotNullItem(String title, String? content,{bool branch = false, dynamic param,String data = '',ListItemType itemType = ListItemType.common}) {
    if (StringUtil.isEmpty(content)) {
      return null;
    }
    return ListItem(title: title,content: content!,branch: branch,param: param,data: data,itemType: itemType);
  }
}