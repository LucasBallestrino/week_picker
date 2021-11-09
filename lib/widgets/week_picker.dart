library week_picker;

import 'package:flutter/material.dart';
import 'package:week_picker/models/models.dart';
import 'package:week_picker/widgets/custom_card.dart';

class WeekPicker extends StatefulWidget {
  final List<TileModel> body;
  final List<WeekPickerCustom>? widgets;
  final String title;
  final int dayRange;
  final TextStyle? style;
  final List<String> months;
  final DateTime? startDate;
  final int? weekStartDate;

  WeekPicker({
    this.weekStartDate,
    this.startDate,
    this.body = const [],
    this.title = "",
    this.dayRange = 7,
    this.style,
    this.widgets,
    this.months = const [
      'jan',
      'feb',
      'mar',
      'april',
      'may',
      'jun',
      'july',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ],
  });

  @override
  _WeekPickerState createState() => new _WeekPickerState();
}

class _WeekPickerState extends State<WeekPicker> {
  DateTime? firstday;
  DateTime? lastDay;
  @override
  void initState() {
    //getting the first day as today
    firstday = _getFirstWeekDay(widget.startDate?? DateTime.now(), widget.weekStartDate ?? 1);
    lastDay = firstday!.add(Duration(days: widget.dayRange));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.body.length > 0){
      widget.body.sort((a, b) => a.date.compareTo(b.date));
    }
    if(widget.widgets != null){
      if(widget.widgets!.length > 0){
        widget.widgets!.sort((a, b) => a.date.compareTo(b.date));
      }
    }
    //Building all the widget
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Header
        Text(
          widget.title,
          style: _getStyle(),
        ),
        // Week indicator
        Row(
          children: [
            TextButton(
              onPressed: _handleBack,
              child: Icon(Icons.arrow_back),
            ),
            Expanded(
              child: Center(
                child: Container(
                  child: Text(
                    _getDay(firstday) + " - " + _getDay(lastDay),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: _handleForward,
              child: Icon(Icons.arrow_forward),
            ),
          ],
        ),
        //Body

        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.widgets != null
                ? widget.widgets!.length
                : widget.body.length,
            itemBuilder: (context, index) {
              if (widget.widgets != null) {
                return _getWidget(true, widget.widgets![index]);
              } else {
                return _getWidget(false, widget.body[index]);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _getWidget(bool custom, dynamic element) {
    Widget widget;
    if (custom) {
      widget = element.child;
    } else {
      widget = BodyWeekPickerCard(
        titleAsString: element.title,
        descAsString: element.desc,
      );
    }

    if (element.date.compareTo(firstday!) >= 0 &&
        element.date.compareTo(lastDay!) <= 0) {
      return widget;
    } else {
      return Container();
    }
  }

  // Forward arrow callback
  void _handleForward() {
    setState(() {
      firstday = firstday!.add(Duration(days: 7));
      lastDay = lastDay!.add(Duration(days: 7));
    });
  }

  // Back arrow callback
  void _handleBack() {
    setState(() {
      firstday = firstday!.add(Duration(days: -7));
      lastDay = lastDay!.add(Duration(days: -7));
    });
  }

  // Gets day number + month name  (xx mmm)
  String _getDay(DateTime? time) {
    return time!.day.toString() + " " + widget.months[time.month - 1];
  }

  /// The [weekday] may be 0 for Sunday, 1 for Monday, etc. up to 7 for Sunday.
  DateTime _getFirstWeekDay(DateTime date, int weekday) =>
    DateTime(date.year, date.month, date.day - (date.weekday - weekday) % 7);

  //Style for the title
  TextStyle _getStyle() {
    if (widget.style == null) {
      return TextStyle(color: Colors.black, fontSize: 25);
    } else {
      return widget.style as TextStyle;
    }
  }
}
