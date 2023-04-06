
import './base_request.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PageService extends BaseRequest {

  PageService({bool initialRefresh = false}) {
    refreshCtr = RefreshController(initialRefresh: initialRefresh);
  }

  int _curPage = 1;

  int _curSize = 0;

  late RefreshController refreshCtr;

  List list = [];

  int curPage(bool isLoad) {
    if (isLoad) {
      _curPage += 1;
    } else {
      _curPage = 1;
    }
    return _curPage;
  }

  List onPageSuccess(bool isLoad, List? data, int? totalSize,{bool loadNoData = true}) {
    if (!isLoad) {
      _curSize = 0;
      list.clear();
    }
    list.addAll(data ??[]);
    _curSize += data?.length ?? 0;
    if (_curSize == totalSize && loadNoData) {
      refreshCtr.loadNoData();
    }
    return list;
  }

  onPageFinish(bool isLoad) {
    showEmpty = true;
    if (!isLoad) {
      refreshCtr.refreshCompleted(resetFooterState: true);
    } else {
      refreshCtr.loadComplete();
    }
  }

  
}