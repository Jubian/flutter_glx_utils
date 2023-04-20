
import 'package:flutter/material.dart';

ValueChanged<T>? runfuncIf<T>(bool condition, ValueChanged<T> func) {
  if (condition) {
    return func;
  } else {
    return null;
  }
}
