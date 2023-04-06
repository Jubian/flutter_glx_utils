import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glx_utils/glx_manager.dart';
import 'package:get/get.dart';
import '/widget_chain/widget_chain.dart';

class NetworkMonitorOverlay extends StatefulWidget {
  const NetworkMonitorOverlay({super.key,this.share,this.logo});

  final String? logo;
  final VoidCallback? share;

  @override
  State<NetworkMonitorOverlay> createState() => _NetworkMonitorOverlayState();
}

class _NetworkMonitorOverlayState extends State<NetworkMonitorOverlay> {
  bool _showMonitor = false;
  final double _monitorHeight = 400.0;
  double _monitorPosition = 100.0;
  final _monitorWidth = 300.0;
  final List<String> _logs = [];

  final _monitorKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Add Dio interceptor
    final dio = GLXManger().dio;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        clear();
        log('请求地址\n${options.path}');
        log('\n请求头\n${options.headers}');
        if (options.data != null) {
          log('\n请求体\n${options.data}');
        }
        if (options.queryParameters.isNotEmpty) {
          log('\n传参\n${options.queryParameters}');
        }
        return handler.next(options);
      },
      onResponse: ( response, ResponseInterceptorHandler handler) {
        String formattedJson = const JsonEncoder.withIndent('  ').convert(response.data);
        log('\n响应\n$formattedJson');
        return handler.next(response);
      },
      onError: (DioError error, ErrorInterceptorHandler handler) {
        log('错误\n$error');
        return handler.next(error);
      },
    ));
  }

  void clear() {
    setState(() {
      _logs.clear();
    });
  }

  void log(String message) {
    setState(() {
      _logs.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _handleDragUpdate,
      onPanEnd: _handleDragEnd,
      child: Stack(
        children: [
          if (_showMonitor) ...[
            Positioned(
              left: 0,
              top: _monitorPosition+55,
              child: SizedBox(
                width: _monitorWidth,
                height: _monitorHeight,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: [
                    IconButton(
                      icon: const Icon(Icons.share,size: 25,color: Colors.white,),
                      onPressed: widget.share,
                    )
                    .intoMaterial(type: MaterialType.transparency,)
                    .intoVisibility(visible: widget.share != null),
                    ListView(
                      padding: EdgeInsets.zero,
                      children: _logs.map((log) => Text(log,style: Get.textTheme.titleMedium?.copyWith(color: Colors.white),).intoContainer(padding: const EdgeInsets.symmetric(horizontal: 5))).toList(),
                  )
                  .intoExpanded()
                  ]
                  .intoColumn(crossAxisAlignment: CrossAxisAlignment.end)
                  
                )
              ),
            ),
          ],
          Positioned(
            left: 0,
            top: _monitorPosition,
            child: GestureDetector(
              key: _monitorKey,
              onTap: _toggleMonitor,
              child: widget.logo == null 
              ?
               Container(color: Colors.red,width: 50,height: 50)
              :
                Image.asset(
                    widget.logo!,
                    width: 50,
                    height: 50,
                  ),
            ),
          ),
        ],
      ),
    );
  }


  void _toggleMonitor() {
    setState(() {
      _logs.clear();
      _showMonitor = !_showMonitor;
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _monitorPosition += details.delta.dy;
      // Limit the monitor position within screen bounds
      _monitorPosition = _monitorPosition.clamp(
        0,
        MediaQuery.of(context).size.height - _monitorHeight-55,
      );
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    // Save the last monitor position
    final monitorBox = _monitorKey.currentContext!.findRenderObject() as RenderBox;
    _monitorPosition = monitorBox.localToGlobal(Offset.zero).dy;
  }
}
