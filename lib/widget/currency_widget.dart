import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String text1;
  final String text2;
  final TextStyle selectStyle;
  final TextStyle unSelectStyle;
  final double width;
  final double height;
  final double padding;
  final ValueChanged<int> onChanged;

  CustomSwitch({
    required this.text1, 
    required this.text2, 
    required this.width, 
    required this.height, 
    required this.onChanged,
    required this.selectStyle,
    required this.unSelectStyle,
    this.padding = 20,
    
  });

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  int _selectedIndex = 0;
  double _sliderOffset = 0;
  late double _textWidth1;
  late double _textWidth2;

  void _updateSliderPosition(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
      _sliderOffset = newIndex == 0 ? 0 : widget.width - _textWidth2 - widget.padding * 2;
      widget.onChanged(newIndex);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    TextStyle style = Theme.of(context).textTheme.subtitle1!;
    _textWidth1 = (TextPainter(text: TextSpan(text: widget.text1, style: style), maxLines: 1, textDirection: TextDirection.ltr)..layout()).width;
    _textWidth2 = (TextPainter(text: TextSpan(text: widget.text2, style: style), maxLines: 1, textDirection: TextDirection.ltr)..layout()).width;
    _updateSliderPosition(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0 && _selectedIndex == 0) {
          _updateSliderPosition(1);
        } else if (details.delta.dx < 0 && _selectedIndex == 1) {
          _updateSliderPosition(0);
        }
      },
      child: Container(
        width: widget.width, 
        height: widget.height, 
        decoration: BoxDecoration(color: Color(0xFFF6EDE5), 
        borderRadius: BorderRadius.circular(widget.height/2)),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              left: _sliderOffset,
              bottom: 0,
              child: Container(
                height: widget.height,
                width: _selectedIndex == 0 ? _textWidth1 + widget.padding * 2 : _textWidth2 + widget.padding * 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.height/2),
                  gradient: LinearGradient(
                    colors: [Color(0xFFFEB982), Color(0xFFF69B52)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            SizedBox(
              // height: widget.height,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _updateSliderPosition(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: widget.height,
                    padding: EdgeInsets.symmetric(horizontal: widget.padding),
                    child: Text(widget.text1, style: _selectedIndex == 0 ? widget.selectStyle : widget.unSelectStyle,textScaleFactor: 1.0,)
                  )
                ),
                GestureDetector(
                  onTap: () => _updateSliderPosition(1),
                  child: Container(
                    alignment: Alignment.center,
                    height: widget.height,
                    padding: EdgeInsets.only(right: widget.padding,left: widget.width-_textWidth1-_textWidth2-widget.padding*3),
                    child: Text(widget.text2, style: _selectedIndex == 1 ? widget.selectStyle : widget.unSelectStyle,textScaleFactor: 1.0,)
                  )
                )
              ],
            ),
            )
            
            // [
            //   GestureDetector(
            //     onTap: () => _updateSliderPosition(0),
            //     child: Text(widget.text1, style: Theme.of(context).textTheme.subtitle1!.copyWith(color: _selectedIndex == 0 ? Colors.white : Color(0xFFF49610))),
            //   ),
            //   GestureDetector(
            //     onTap: () => _updateSliderPosition(1),
            //     child: Text(widget.text2, style: Theme.of(context).textTheme.subtitle1!.copyWith(color: _selectedIndex == 1 ? Colors.white : Color(0xFFF49610))),
            //   )
            // ]
            
            // Positioned(
            //   left: widget.padding,
            //   child: GestureDetector(
            //     onTap: () => _updateSliderPosition(0),
            //     child: Text(widget.text1, style: Theme.of(context).textTheme.subtitle1!.copyWith(color: _selectedIndex == 0 ? Colors.white : Color(0xFFF49610))),
            //   ),
            // ),
            // Positioned(
            //   right: widget.padding,
            //   child: GestureDetector(
            //     onTap: () => _updateSliderPosition(1),
            //     child: Text(widget.text2, style: Theme.of(context).textTheme.subtitle1!.copyWith(color: _selectedIndex == 1 ? Colors.white : Color(0xFFF49610))),
            //   ),
            // )
          ]
        )
      )
    );

  }
}

