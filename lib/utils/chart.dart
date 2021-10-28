import 'dart:collection';

import 'package:charts_common/common.dart' as common;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DashboardChartWidget extends StatelessWidget {
  final List<String> titles;
  final List<Color> colors;
  final List<List<double>> values;
  final List<DateTime> dates;
  final bool provideSelectableItem;

//  final List<charts.Series> seriesList;
  final bool animate;

  DashboardChartWidget(
      {@required this.titles,
      @required this.colors,
      @required this.values,
      @required this.dates,
      this.provideSelectableItem = false})
      : animate = true;

  @override
  Widget build(BuildContext context) {
    KeepAliveNotification(KeepAliveHandle()).dispatch(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        if (titles != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              runAlignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.spaceBetween,
              children: titles
                  .asMap()
                  .map((index, title) => MapEntry(
                      index,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              padding: new EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                              color: colors[index],
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            title,
                            style: TextStyle(color: Colors.black38, fontSize: 17),
                          )
                        ],
                      )))
                  .values
                  .toList(),
            ),
          ),
        Expanded(
          child: new charts.LineChart(_generateData(),
              animate: animate,
              behaviors: [
                new charts.RangeAnnotation(dates
                    .asMap()
                    .map((index, date) => MapEntry(
                        index,
                        new charts.LineAnnotationSegment(index, charts.RangeAnnotationAxisType.domain,
                            dashPattern: [2, 2], color: charts.MaterialPalette.gray.shade300)))
                    .values
                    .toList()),
                // A pan and zoom behavior helps demonstrate the sliding viewport
                // behavior by allowing the data visible in the viewport to be adjusted
                // dynamically.
                new charts.PanBehavior(),
              ],
              selectionModels: [
                new charts.SelectionModelConfig(
                    type: charts.SelectionModelType.info,
                    changedListener: (num) {
                      if (num.selectedDatum.length != 0 && provideSelectableItem) {}
                    })
              ],
              primaryMeasureAxis: new charts.NumericAxisSpec(
                  tickProviderSpec: new charts.StaticNumericTickProviderSpec(
                <charts.TickSpec<num>>[],
              )),
              domainAxis: new charts.NumericAxisSpec(
                  viewport:
                      new charts.NumericExtents(((dates.length - 7) < 0) ? 0 : dates.length - 7, dates.length - 1),
                  tickProviderSpec: new charts.StaticNumericTickProviderSpec(
                      // Create the ticks to be used the domain axis.
                      dates
                          .asMap()
                          .map((index, date) => MapEntry(
                              index,
                              new charts.TickSpec(index,
                                  label:
                                      date.day.toString() + '/' + date.month.toString() + '/' + date.year.toString())))
                          .values
                          .toList()),
                  renderSpec: new charts.SmallTickRendererSpec(
                    axisLineStyle: new charts.LineStyleSpec(color: charts.MaterialPalette.white),
                    labelStyle: new charts.TextStyleSpec(
                        fontFamily: "Proxima",
                        fontSize: 15.floor(), // size in Pts.
                        color: charts.MaterialPalette.gray.shade600),
                  )),
              disjointMeasureAxes: new LinkedHashMap<String, charts.NumericAxisSpec>.from({
                'axis 0': new charts.NumericAxisSpec(),
                'axis 1': new charts.NumericAxisSpec(),
                'axis 2': new charts.NumericAxisSpec(),
              })),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  List<charts.Series<ChartData, int>> _generateData() {
    return [
          new charts.Series<ChartData, int>(
              id: 'Series',
              domainFn: (ChartData clickCount, _) => clickCount.date,
              measureFn: (ChartData clickCount, _) => clickCount.value,
              data: []),
        ] +
        colors
            .asMap()
            .map((index, item) => MapEntry(
                index,
                new charts.Series<ChartData, int>(
                  id: '$index',
                  colorFn: (_, __) => commonColorFromColor(colors[index]),
                  strokeWidthPxFn: (_, __) => 3,
                  domainFn: (ChartData clickCount, _) => clickCount.date,
                  measureFn: (ChartData clickCount, _) => clickCount.value,
                  data: _getDataByIndex(index),
                )
                  // Set the 'Desktop' series to use a disjoint axis.
                  ..setAttribute(charts.measureAxisIdKey, 'axis $index')))
            .values
            .toList();
  }

  List<ChartData> _getDataByIndex(int index) => values[index]
      .asMap()
      .map((valueIndex, item) => MapEntry(valueIndex, new ChartData(valueIndex, value: item?.toDouble())))
      .values
      .toList();
}

common.Color commonColorFromColor(Color color) {
  return new common.Color(r: color.red, b: color.blue, g: color.green);
}

class ChartData {
  final int date;
  final double value;

  ChartData(this.date, {this.value});
}
