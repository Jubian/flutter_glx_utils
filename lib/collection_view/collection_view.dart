
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import './list_item.dart';
import 'package:collection/collection.dart';
import '../widget_chain/widget_chain.dart';

typedef HeaderFooterWidgetBuilder = Widget? Function(BuildContext context, ListItem item);
typedef CellWidgetBuilder = Widget? Function(BuildContext context, ListItem item,dynamic param);

class CollectionView extends CustomScrollView {

  const CollectionView({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    ScrollBehavior? scrollBehavior,
    bool shrinkWrap = false,
    Key? center,
    double anchor = 0.0,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    required this.listItems,
    this.headerBuilder,
    this.footerBuilder,
    this.listBuilder,
    this.otherSlivers,
  }) : super(
    key: key,
    scrollDirection: scrollDirection,
    reverse: reverse,
    controller: controller,
    primary: primary,
    physics: physics,
    scrollBehavior: scrollBehavior,
    shrinkWrap: shrinkWrap,
    center: center,
    anchor: anchor,
    cacheExtent: cacheExtent,
    semanticChildCount: semanticChildCount,
    dragStartBehavior: dragStartBehavior,
    keyboardDismissBehavior: keyboardDismissBehavior,
    restorationId: restorationId,
    clipBehavior: clipBehavior,
  );
     
  final List<ListItem> listItems;
  final HeaderFooterWidgetBuilder? headerBuilder;
  final HeaderFooterWidgetBuilder? footerBuilder;
  final CellWidgetBuilder? listBuilder;
  final List<Widget>? otherSlivers;

  @override
  List<Widget> buildSlivers(BuildContext context) {
    List<Widget> slivers = otherSlivers ?? [];
    listItems.forEachIndexed((index, element) {
      // 添加列表头部对象
      if (element.headerId != 0 && headerBuilder != null) {
        final header = headerBuilder!(context,element);
        if (header != null) {
          slivers.add(header.intoSliverToBoxAdapter());
        }
      } 
      // 添加列表内容对象
      var cell = addCellItem(element, index);
      if (cell != null) {
          slivers.add(
            
            // cell
            // .intoContainer(
            //   height: 300,
            //   padding:element.padding,
            // )
            // .intoSliverToBoxAdapter()
            
            SliverPadding(
              padding: element.padding,
              sliver: cell,
            )
          );
      }
      // 添加列表尾部对象
      if (element.footerId != 0 && footerBuilder != null) { // 添加尾部对象
        final footer = footerBuilder!(context,element);
        if (footer != null) {
          slivers.add(footer.intoSliverToBoxAdapter());
        }
      }
    });
    return slivers;
  }

  // 添加列表内容对象
  Widget? addCellItem(ListItem item, int section) {
    if (item.cellParams == null) return null;
    if (item.cellType == ListCellType.list && listBuilder != null) {
      return SliverList(delegate: SliverChildBuilderDelegate(
        (context, index) => listBuilder!(context,item,item.cellParams![index]),
        childCount: item.cellParams!.length)
      );
    } else if (item.cellType == ListCellType.grid && listBuilder != null) {
      return MasonryGridView.count(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: item.cellParams!.length,
        mainAxisSpacing: item.mainAxisSpacing,
        crossAxisSpacing: item.crossAxisSpacing,
        crossAxisCount: item.crossAxisCount, 
        itemBuilder: (context,index) => listBuilder!(context,item,item.cellParams![index]) ?? Container()
      )
      .intoSliverToBoxAdapter();
    }
    return null;
  }
}