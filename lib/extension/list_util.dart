
extension ListUtil<E> on List<E> {

  void addNotNull(E? item) {
    if (item != null) add(item);
  }

  E? get firstElement {
    if (length != 0){
      return first;
    }
    return null;
  }

  static dynamic getValue(List? list, int? index) {
    if (index != null && list != null) {
      if (0 <= index && index < list.length) {
        return list[index];
      }
    } else {
      return null;
    }
    return null;
  }

  static bool isEmpty(List? list) {
    if (list == null) {
      return true;
    }
    return list.isEmpty;
  }

  static bool isNotEmpty(List? list) {
    if (list == null) {
      return false;
    }
    return list.isNotEmpty;
  }
} 