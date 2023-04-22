import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EmptyListView extends StatelessWidget {
  final int itemCount;
  final Widget emptyView;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final EdgeInsetsGeometry? padding;
  /// 滑动组件
  final RefreshController? refreCtr;
  final Widget? header;
  final Widget? footer;
  final bool enablePullDown;
  final bool enablePullUp;
  final void Function()? onRefresh;
  final void Function()? onLoading;


  const EmptyListView({
    required this.itemCount, 
    required this.emptyView, 
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.refreCtr,
    this.header,
    this.footer,
    this.enablePullDown = true,
    this.enablePullUp = false,
    this.onRefresh,
    this.onLoading
  });
  
  ListView _buildListView() {
    return ListView.separated(
      padding: padding,
      itemCount: itemCount == 0  ? 1 : itemCount,
      itemBuilder: (BuildContext context, int index) {
        if (itemCount == 0) {
          return emptyView;
        } else {
          return itemBuilder(context,index);
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        if (separatorBuilder != null) {
          return separatorBuilder!(context,index);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (refreCtr != null) {
      return SmartRefresher(
        controller: refreCtr!,
        header: header,
        footer: footer,
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp && (itemCount > 0),
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: _buildListView(),
      );
    } else {
      return _buildListView();
    }
  }
}