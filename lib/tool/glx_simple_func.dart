
import 'package:flutter/material.dart';

EdgeInsets glx_ei_a(double value) => EdgeInsets.all(value);
EdgeInsets glx_ei_s(double horizontal,double vertical) => EdgeInsets.symmetric(horizontal: horizontal,vertical: horizontal);
EdgeInsets glx_ei_sh(double h) => EdgeInsets.symmetric(horizontal: h);
EdgeInsets glx_ei_sv(double v) => EdgeInsets.symmetric(vertical: v);
EdgeInsets glx_ei_zero() => EdgeInsets.zero;
EdgeInsets glx_ei_ltrb({double left = 0.0,double top = 0.0,double right = 0.0, double bottom = 0.0}) => EdgeInsets.only(left:left, top:top, right:right, bottom:bottom);
