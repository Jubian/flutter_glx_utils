
class EnumUtil {

/// 该方法使只有两个参数
static int toggleEnum(int curIndex) {
  assert(curIndex < 2, 'Cannot toggle enum with more than two values');
  // 计算下一个枚举值的下标
  return (curIndex + 1) % 2;
}






}