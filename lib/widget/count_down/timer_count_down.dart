import 'dart:async';
import 'package:flutter/widgets.dart';
import './timer_controller.dart';

///
/// Simple countdown timer.
///
class Countdown extends StatefulWidget {
  /// Length of the timer
  final DateTime time;

  /// Build method for the timer
  final Widget Function(BuildContext, DateTime) build;

  /// Called when finished
  final Function? onFinished;

  /// Build interval
  final Duration interval;

  /// Controller
  final CountdownController? controller;

  ///
  /// Simple countdown timer
  ///
  const Countdown({
    Key? key,
    required this.time,
    required this.build,
    this.interval = const Duration(seconds: 1),
    this.onFinished,
    this.controller,
  }) : super(key: key);

  @override
  State<Countdown> createState() => _CountdownState();
}

///
/// State of timer
///
class _CountdownState extends State<Countdown> {

  // Timer
  Timer? _timer;
  
  /// Internal control to indicate if the onFinished method was executed
  bool _onFinishedExecuted = false;

  // Current seconds
  late int _currentMilliSeconds;

  @override
  void initState() {
    _currentMilliSeconds = widget.time.millisecondsSinceEpoch;

    widget.controller?.setOnStart(_startTimer);
    widget.controller?.setOnPause(_onTimerPaused);
    widget.controller?.setOnResume(_onTimerResumed);
    widget.controller?.setOnRestart(_onTimerRestart);
    widget.controller?.isCompleted = false;

    if (widget.controller == null || widget.controller!.autoStart == true) {
      _startTimer();
    }

    super.initState();
  }

  @override
  void didUpdateWidget(Countdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.time != widget.time) {
      _currentMilliSeconds = widget.time.millisecondsSinceEpoch;
    }
  }

  @override
  void dispose() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(
      context,
      DateTime.fromMillisecondsSinceEpoch(_currentMilliSeconds,isUtc: true)
      // _currentMicroSeconds / _secondsFactor,
    );
  }

  ///
  /// Then timer paused
  ///
  void _onTimerPaused() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }

  ///
  /// Then timer resumed
  ///
  void _onTimerResumed() {
    _startTimer();
  }

  ///
  /// Then timer restarted
  ///
  void _onTimerRestart() {
    widget.controller?.isCompleted = false;    
    _onFinishedExecuted = false;

    setState(() {
      _currentMilliSeconds = widget.time.millisecondsSinceEpoch;
    });

    _startTimer();
  }

  ///
  /// Start timer
  ///
  void _startTimer() {
    if (_timer?.isActive == true) {
      _timer!.cancel();

      widget.controller?.isCompleted = true;
    }

    if (_currentMilliSeconds != 0) {
      _timer = Timer.periodic(
        widget.interval,
        (Timer timer) {
          if (_currentMilliSeconds <= 1000) {
            timer.cancel();
            setState(() {
              _currentMilliSeconds = 0;
            });

            if (widget.onFinished != null) {
              widget.onFinished!();
              _onFinishedExecuted = true;
            }            
            widget.controller?.isCompleted = true;
          } else {
            _onFinishedExecuted = false;
            setState(() {
              _currentMilliSeconds =
                  _currentMilliSeconds - widget.interval.inMilliseconds;
            });
          }
        },
      );
    } else if (!_onFinishedExecuted) {
      if (widget.onFinished != null) {
        widget.onFinished!();
        _onFinishedExecuted = true;
      }      
      widget.controller?.isCompleted = true;
    }
  }
}
