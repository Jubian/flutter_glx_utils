
import 'dart:io';
import 'package:path_provider/path_provider.dart';
 
/// 缓存管理类
class CacheUtil {
  /// 获取缓存大小
  static Future<String> total() async {
    Directory tempDir = await getTemporaryDirectory();
    String total = _renderSize(await _reduce(tempDir));
    return total;
  }
 
  /// 清除缓存
  static Future<void> clear() async {
    Directory tempDir = await getTemporaryDirectory();
    await _delete(tempDir);
  }

   /// 递归缓存目录，计算缓存大小
  static Future<double> _reduce(final FileSystemEntity file) async {
    /// 如果是一个文件，则直接返回文件大小
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
 
    /// 如果是目录，则遍历目录并累计大小
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
 
      double total = 0;
 
      if (children.isNotEmpty)
        // ignore: curly_braces_in_flow_control_structures
        for (FileSystemEntity child in children) {
          total += await _reduce(child);
        }
 
      return total;
    }
 
    return 0;
  }

  /// 递归删除缓存目录和文件
  static Future<void> _delete(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await _delete(child);
      }
    } else {
      await file.delete();
    }
  }

  /// 缓存大小转化为字符串
  static String _renderSize(double value) {
   List<String> unitArr = ['B','K','M','G'];
     
   int index = 0;
   while (value > 1024) {
     index++;
     value = value / 1024;
   }
   String size = value.toStringAsFixed(2);
   return size + unitArr[index];
 }
}