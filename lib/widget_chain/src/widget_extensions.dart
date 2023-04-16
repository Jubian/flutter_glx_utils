import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// extension to make it is possible to use function calling instead of Widget Constructor
///
/// For example:
///   Container(
///     color: Colors.white,
///     Offstage(
///       offstage: false,
///       child: Text('hello'),
///     ),
///   );
/// now it is also can looks like this:
///   Text('hello')
///     .intoOffstage(offstage: false)
///     .intoContainer(color: Colors.white);
///
///

const EdgeInsets _defaultInsetPadding = EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);

extension WidgetChantExtWidget on Widget {
  List<Widget> addNeighbor(Widget widget) {
    return <Widget>[this, widget];
  }

  List<Widget> addAllNeighbor(List<Widget> widget) {
    List<Widget> list = [];
    list.add(this);
    list.addAll(widget);
    return list;
  }

  List<Widget> asList() {
    return [this];
  }

  Align intoAlign({
    Key? key,
    Alignment alignment = Alignment.center,
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      key: key,
      alignment: alignment,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }

  ClipRRect intoClipRRect({
    Key? key,
    BorderRadius borderRadius = BorderRadius.zero,
    CustomClipper<RRect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    return ClipRRect(
      key: key,
      borderRadius: borderRadius,
      clipper: clipper,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  ClipOval intoClipOval({
    Key? key,
    BorderRadius borderRadius = BorderRadius.zero,
    CustomClipper<Rect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    return ClipOval(
      key: key,
      clipper: clipper,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  ClipPath intoClipPath({
    Key? key,
    BorderRadius borderRadius = BorderRadius.zero,
    CustomClipper<Path>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    return ClipPath(
      key: key,
      clipper: clipper,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  Offstage intoOffstage({
    Key? key,
    bool offstage = true,
  }) {
    return Offstage(
      key: key,
      offstage: offstage,
      child: this,
    );
  }

  Padding intoPadding({
    Key? key,
    required EdgeInsetsGeometry padding,
  }) {
    return Padding(
      key: key,
      padding: padding,
      child: this,
    );
  }

  Positioned intoPositioned({
    Key? key,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) {
    return Positioned(
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      width: width,
      height: height,
      child: this,
    );
  }

  Center intoCenter({
    Key? key,
    double? widthFactor,
    double? heightFactor,
  }) {
    return Center(
      key: key,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }

  Expanded intoExpanded({
    Key? key,
    int flex = 1,
  }) {
    return Expanded(
      key: key,
      flex: flex,
      child: this,
    );
  }

  Flexible intoFlexible({
    Key? key,
    int flex = 1,
    FlexFit fit = FlexFit.loose,
  }) {
    return Flexible(
      key: key,
      flex: flex,
      fit: fit,
      child: this,
    );
  }

  SizedBox intoSizedBox({
    Key? key,
    double? width,
    double? height,
  }) {
    return SizedBox(
      key: key,
      width: width,
      height: height,
      child: this,
    );
  }

  LimitedBox intoLimitedBox({
    Key? key,
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
  }) {
    return LimitedBox(
      key: key,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      child: this,
    );
  }

  OverflowBox intoOverflowBox({
    Key? key,
    Alignment alignment = Alignment.center,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) {
    return OverflowBox(
      key: key,
      alignment: alignment,
      minWidth: minWidth,
      minHeight: minHeight,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      child: this,
    );
  }

  SizedOverflowBox intoSizedOverflowBox({
    Key? key,
    required Size size,
    Alignment alignment = Alignment.center,
  }) {
    return SizedOverflowBox(
      key: key,
      size: size,
      alignment: alignment,
      child: this,
    );
  }

  FittedBox intoFittedBox({
    Key? key,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return FittedBox(
      key: key,
      fit: fit,
      alignment: alignment,
      child: this,
    );
  }

  DecoratedBox intoDecoratedBox({
    Key? key,
    required Decoration decoration,
    DecorationPosition position = DecorationPosition.background,
  }) {
    return DecoratedBox(
      key: key,
      decoration: decoration,
      position: position,
      child: this,
    );
  }

  RotatedBox intoRotatedBox({
    Key? key,
    required int quarterTurns,
  }) {
    return RotatedBox(
      key: key,
      quarterTurns: quarterTurns,
      child: this,
    );
  }

  ConstrainedBox intoConstrainedBox({
    Key? key,
    required BoxConstraints constraints,
  }) {
    return ConstrainedBox(
      key: key,
      constraints: constraints,
      child: this,
    );
  }

  UnconstrainedBox intoUnconstrainedBox({
    Key? key,
    TextDirection? textDirection,
    Alignment alignment = Alignment.center,
    Axis? constrainedAxis,
  }) {
    return UnconstrainedBox(
      key: key,
      textDirection: textDirection,
      alignment: alignment,
      constrainedAxis: constrainedAxis,
      child: this,
    );
  }

  AnimatedAlign intoAnimatedAlign({
    Key? key,
    Alignment alignment = Alignment.center,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) {
    return AnimatedAlign(
      key: key,
      alignment: alignment,
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      child: this,
    );
  }

  AnimatedPadding intoAnimatedPadding({
    Key? key,
    required EdgeInsetsGeometry padding,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) {
    return AnimatedPadding(
      key: key,
      padding: padding,
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      child: this,
    );
  }

  AnimatedContainer intoAnimatedContainer({
    Key? key,
    Alignment? alignment,
    EdgeInsetsGeometry? padding,
    Color? color,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) {
    return AnimatedContainer(
      key: key,
      alignment: alignment,
      padding: padding,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      child: this,
    );
  }

  SingleChildScrollView intoSingleChildScrollView({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    EdgeInsetsGeometry? padding,
    bool? primary,
    ScrollPhysics? physics,
    ScrollController? controller,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
  }) {
    return SingleChildScrollView(
      key: key,
      scrollDirection: scrollDirection,
      reverse: reverse,
      padding: padding,
      primary: primary,
      physics: physics,
      controller: controller,
      dragStartBehavior: dragStartBehavior,
      child: this,
    );
  }

  GestureDetector onTap(GestureTapCallback? onTap, {Key? key}) {
    return intoGestureDetector(onTap: onTap, key: key,behavior: HitTestBehavior.opaque);
  }

  GestureDetector onDoubleTap(GestureTapCallback onDoubleTap, {Key? key}) {
    return intoGestureDetector(onDoubleTap: onDoubleTap, key: key);
  }

  GestureDetector onLongPress(GestureLongPressCallback onLongPress,
      {Key? key}) {
    return intoGestureDetector(onLongPress: onLongPress, key: key);
  }

  GestureDetector intoGestureDetector({
    Key? key,
    GestureTapDownCallback? onTapDown,
    GestureTapUpCallback? onTapUp,
    GestureTapCallback? onTap,
    GestureTapCancelCallback? onTapCancel,
    GestureTapDownCallback? onSecondaryTapDown,
    GestureTapUpCallback? onSecondaryTapUp,
    GestureTapCancelCallback? onSecondaryTapCancel,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    GestureLongPressStartCallback? onLongPressStart,
    GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate,
    GestureLongPressUpCallback? onLongPressUp,
    GestureLongPressEndCallback? onLongPressEnd,
    GestureDragDownCallback? onVerticalDragDown,
    GestureDragStartCallback? onVerticalDragStart,
    GestureDragUpdateCallback? onVerticalDragUpdate,
    GestureDragEndCallback? onVerticalDragEnd,
    GestureDragCancelCallback? onVerticalDragCancel,
    GestureDragDownCallback? onHorizontalDragDown,
    GestureDragStartCallback? onHorizontalDragStart,
    GestureDragUpdateCallback? onHorizontalDragUpdate,
    GestureDragEndCallback? onHorizontalDragEnd,
    GestureDragCancelCallback? onHorizontalDragCancel,
    GestureForcePressStartCallback? onForcePressStart,
    GestureForcePressPeakCallback? onForcePressPeak,
    GestureForcePressUpdateCallback? onForcePressUpdate,
    GestureForcePressEndCallback? onForcePressEnd,
    GestureDragDownCallback? onPanDown,
    GestureDragStartCallback? onPanStart,
    GestureDragUpdateCallback? onPanUpdate,
    GestureDragEndCallback? onPanEnd,
    GestureDragCancelCallback? onPanCancel,
    GestureScaleStartCallback? onScaleStart,
    GestureScaleUpdateCallback? onScaleUpdate,
    GestureScaleEndCallback? onScaleEnd,
    HitTestBehavior? behavior,
    bool excludeFromSemantics = false,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
  }) {
    return GestureDetector(
      key: key,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTap: onTap,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onLongPressStart: onLongPressStart,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressUp: onLongPressUp,
      onLongPressEnd: onLongPressEnd,
      onVerticalDragDown: onVerticalDragDown,
      onVerticalDragStart: onVerticalDragStart,
      onVerticalDragUpdate: onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd,
      onVerticalDragCancel: onVerticalDragCancel,
      onHorizontalDragDown: onHorizontalDragDown,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onHorizontalDragCancel: onHorizontalDragCancel,
      onForcePressStart: onForcePressStart,
      onForcePressPeak: onForcePressPeak,
      onForcePressUpdate: onForcePressUpdate,
      onForcePressEnd: onForcePressEnd,
      onPanDown: onPanDown,
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      onPanCancel: onPanCancel,
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onScaleEnd: onScaleEnd,
      behavior: behavior,
      excludeFromSemantics: excludeFromSemantics,
      dragStartBehavior: dragStartBehavior,
      child: this,
    );
  }

  Container intoContainer({
    Key? key,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    Color? color,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
    Clip clipBehavior = Clip.none,
  }) {
    return Container(
      key: key,
      alignment: alignment,
      padding: padding,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  MediaQuery removePadding({
    Key? key,
    required BuildContext context,
    bool removeLeft = false,
    bool removeTop = false,
    bool removeRight = false,
    bool removeBottom = false,
  }){
    return MediaQuery.removePadding(
      key: key,
      context: context, 
      removeLeft: removeLeft,
      removeTop: removeTop,
      removeRight: removeRight,
      removeBottom: removeBottom,
      child:this
    );
  
  }

  SliverToBoxAdapter intoSliverToBoxAdapter({
    Key? key,
  }) {
    return SliverToBoxAdapter(
      key: key,
      child: this,
    );
  }

  Opacity intoOpacity({
    Key? key,
    required double opacity,
    bool alwaysIncludeSemantics = false,
  }) {
    return Opacity(
      key: key,
      opacity: opacity,
      alwaysIncludeSemantics: alwaysIncludeSemantics,
      child: this,
    );
  }

  GestureDetector onTapHideKeyboard(BuildContext context, {Key? key}) {
    return intoGestureDetector(onTap: () {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }, key: key);
  }

  GestureDetector onTapCloseKeyboard(BuildContext context, {Key? key}) {
    return intoGestureDetector(onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    }, key: key);
  }

  AspectRatio intoAspectRatio({
    Key? key,
    required double aspectRatio
  }) {
    return AspectRatio(
      key: key,
      aspectRatio: aspectRatio,
      child: this,
    );
  }

  Dialog intoDialog({
    Key? key,
    Color? backgroundColor,
    double? elevation,
    Duration insetAnimationDuration = const Duration(milliseconds: 100),
    Curve insetAnimationCurve = Curves.decelerate,
    EdgeInsets? insetPadding = _defaultInsetPadding,
    Clip clipBehavior = Clip.none,
    ShapeBorder? shape,
    AlignmentGeometry? alignment,
  }) {
    return Dialog(
      key: key,
      backgroundColor: backgroundColor,
      elevation: elevation,
      insetAnimationCurve: insetAnimationCurve,
      insetAnimationDuration: insetAnimationDuration,
      insetPadding: insetPadding,
      clipBehavior: clipBehavior,
      shape: shape,
      alignment: alignment,
      child: this,
    );
  }

  DefaultTabController intoDefaultTabController({
    Key? key,
    required int length,
    int initialIndex = 0,
    Duration? animationDuration
  }) {
    return DefaultTabController(
      key: key,
      length: length,
      initialIndex: initialIndex,
      animationDuration: animationDuration,
      child: this
    );
  }

  PreferredSize intoPreferredSize({
    Key? key,
    required Size preferredSize,
  }) {
    return PreferredSize(
      key: key,
      preferredSize: preferredSize,
      child: this
    );
  }

  Material intoMaterial({
    Key? key,
    MaterialType type = MaterialType.canvas,
    double elevation = 0.0,
    Color? color,
    Color? shadowColor,
    TextStyle? textStyle,
    BorderRadiusGeometry? borderRadius,
    ShapeBorder? shape,
    bool borderOnForeground = true,
    Clip clipBehavior = Clip.none,
    Duration animationDuration = kThemeChangeDuration,
  }) {
      return Material(
        key: key,
        type: type,
        elevation: elevation,
        color: color,
        shadowColor: shadowColor,
        textStyle: textStyle,
        borderRadius: borderRadius,
        shape: shape,
        borderOnForeground: borderOnForeground,
        clipBehavior: clipBehavior,
        animationDuration: animationDuration,
        child: this,
      );
    }

  Drawer intoDrawer({
    Key? key,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Widget? child,
    String? semanticLabel,
  }) {
    return Drawer(
      key: key,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      semanticLabel: semanticLabel,
      child: this,
    );
  }

  Visibility intoVisibility({
    Key? key,
    Widget replacement = const SizedBox.shrink(),
    bool visible = true,
    bool maintainState = false,
    bool maintainAnimation = false,
    bool maintainSize = false,
    bool maintainSemantics = false,
    bool maintainInteractivity = false,
  }) {
    return Visibility(
      key: key,
      replacement: replacement,
      visible: visible,
      maintainState: maintainState,
      maintainAnimation: maintainAnimation,
      maintainSize: maintainSize,
      maintainSemantics: maintainSemantics,
      maintainInteractivity: maintainInteractivity,
      child: this
    );
  }

  SafeArea intoSafeArea({
    Key? key,
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
    EdgeInsets minimum = EdgeInsets.zero,
    bool maintainBottomViewPadding = false,
  }) {
    return SafeArea(
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      minimum: minimum,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child: this,
    );
  }

  SmartRefresher intoSmartRefresher({
    Key? key,
    required RefreshController controller,
    Widget? header,
    Widget? footer,
    bool enablePullDown = true,
    bool enablePullUp = false,
    bool enableTwoLevel = false,
    void Function()? onRefresh,
    void Function()? onLoading,
    void Function(bool)? onTwoLevel,
    DragStartBehavior? dragStartBehavior,
    bool? primary,
    double? cacheExtent,
    int? semanticChildCount,
    bool? reverse,
    ScrollPhysics? physics,
    Axis? scrollDirection,
    ScrollController? scrollController,
  }) {
    return SmartRefresher(
      key: key,
      controller: controller,
      header: header,
      footer: footer,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      enableTwoLevel: enableTwoLevel,
      onRefresh: onRefresh,
      onLoading: onLoading,
      onTwoLevel: onTwoLevel,
      dragStartBehavior: dragStartBehavior,
      primary: primary,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      reverse: reverse,
      physics: physics,
      scrollDirection: scrollDirection,
      scrollController: scrollController,
      child: this,
    );
  }

  Hero intoHero({
    Key? key,
    required Object tag,
    Tween<Rect?> Function(Rect?, Rect?)? createRectTween,
    Widget Function(BuildContext, Animation<double>, HeroFlightDirection, BuildContext, BuildContext)? flightShuttleBuilder,
    Widget Function(BuildContext, Size, Widget)? placeholderBuilder,
    bool transitionOnUserGestures = false,
  }) {
    return Hero(
      key: key,
      tag: tag,
      createRectTween: createRectTween,
      flightShuttleBuilder: flightShuttleBuilder,
      placeholderBuilder: placeholderBuilder,
      transitionOnUserGestures: false, 
      child: this
    );
  }

  WillPopScope intoWillPopScope({
    Key? key,
    required Future<bool> Function()? onWillPop
  }) {
    return WillPopScope(
      key: key, 
      onWillPop: onWillPop,
      child: this
    );
  }

   ElevatedButton intoElevatedButton({
    Key? key,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    MaterialStatesController? statesController,
  }) {
    return ElevatedButton(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      statesController: statesController,
      child: this,
    );
  }
}
