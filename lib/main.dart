import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

void main() => runApp(MultiPicker());

class MultiPicker extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiplePickerSample(),
    );
  }
}

class MultiplePickerSample extends StatefulWidget {
  @override
  _MultiplePickerSampleState createState() => _MultiplePickerSampleState();
}

class _MultiplePickerSampleState extends State<MultiplePickerSample> {
  final DateRangePickerController _controller = DateRangePickerController();
  String _headerString = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                height: 30,
                width: 105,
                margin: const EdgeInsets.only(left: 50, top: 10),
                color: Color(0xFFfa697c),
                child: IconButton(
                  icon: Icon(Icons.arrow_left),
                  color: Colors.white,
                  iconSize: 20,
                  highlightColor: Colors.lightGreen,
                  onPressed: () {
                    setState(() {
                      _controller.backward!();
                    });
                  },
                )),
            Container(
              color: Color(0xFFfa697c),
              height: 30,
              width: 345,
              margin: const EdgeInsets.only(top: 10),
              child: Text('$_headerString',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: Colors.white, height: 1.5)),
            ),
            Container(
                height: 30,
                width: 105,
                margin: const EdgeInsets.only(right: 31, top: 10),
                color: Color(0xFFfa697c),
                child: IconButton(
                  icon: Icon(Icons.arrow_right),
                  color: Colors.white,
                  highlightColor: Colors.lightGreen,
                  onPressed: () {
                    setState(() {
                      _controller.forward!();
                    });
                  },
                )),
            Container()
          ],
        ),
        Container(
          height: 200,
          child: Card(
            margin: const EdgeInsets.fromLTRB(50, 0, 35, 0),
            child: SfDateRangePicker(
              controller: _controller,
              view: DateRangePickerView.month,
              headerHeight: 0,
              enableMultiView: true,
              onViewChanged: viewChanged,
              monthViewSettings: DateRangePickerMonthViewSettings(
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                backgroundColor: Color(0xFFfcc169),
              )),
            ),
          ),
        )
      ],
    ));
  }

  void viewChanged(DateRangePickerViewChangedArgs args) {
    final DateTime startDate = args.visibleDateRange.startDate!;
    final DateTime endDate = args.visibleDateRange.endDate!;
    final int count = endDate.difference(startDate).inDays;

    _headerString = DateFormat('MMMM yyyy')
            .format(startDate.add(Duration(days: (count * 0.25).toInt())))
            .toString() +
        ' - ' +
        DateFormat('MMMM yyyy')
            .format(startDate.add(Duration(days: (count * 0.75).toInt())))
            .toString();
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {});
    });
  }
}
