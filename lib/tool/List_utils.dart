


// ignore_for_file: file_names

extension ListUtilsExt on List {

  toggleTwoElement(int curIndex) {
    assert(curIndex < 2 && length == 2, 'Cannot toggle enum with more than two values');
    // 计算下一个枚举值的下标
    return this[(curIndex + 1) % 2];
  }
}

class ListUtils {
  
  static toggleTwoElement(List list, int curIndex) {
    return list.toggleTwoElement(curIndex);
  }
}

