import 'dart:async';

import 'package:flutter/material.dart';

class FocusWrapper extends StatefulWidget {
  final Widget childWidget;
  final ValueChanged<Duration> sessionDuration;
  const FocusWrapper(
      {required this.childWidget, required this.sessionDuration, super.key});

  @override
  State<FocusWrapper> createState() => _FocusWrapperState();
}

class _FocusWrapperState extends State<FocusWrapper> {
  // ignore: prefer_final_fields
  FocusNode _childWidgetFocusNode = FocusNode();

  Duration widgetFocusTime = Duration.zero;

  Timer? _sessionTime;

  int _secondsElapsed = 0;

  @override
  void initState() {
    _childWidgetFocusNode.addListener(() {
      if (_childWidgetFocusNode.hasFocus && _sessionTime == null) {
        startTimer();
        // mean revisiting the widget and gained focus
      } else if (_childWidgetFocusNode.hasFocus && _sessionTime != null) {
        resumeTimer();
      } else if (!(_childWidgetFocusNode.hasFocus)) {
        //no focus show results as the focus is lost

        if (_sessionTime != null) {
          pauseTimer();
          // calculate session
          calculateSession();
          widget.sessionDuration(widgetFocusTime);
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _childWidgetFocusNode.dispose();

    super.dispose();
  }

  void startTimer() {
    _sessionTime = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsElapsed++;
    });
  }

  void pauseTimer() {
    _sessionTime?.cancel();
  }

  void resumeTimer() {
    startTimer();
  }

  void calculateSession() {
    widgetFocusTime = Duration(seconds: _secondsElapsed);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(focusNode: _childWidgetFocusNode, child: widget.childWidget);
  }
}
