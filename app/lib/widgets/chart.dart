/// Example of timeseries chart that has a measure axis that does NOT include
/// zero. It starts at 100 and goes to 140.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../util/colors.dart';

class ElevationChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final bool dark;

  ElevationChart(this.seriesList, {this.animate, this.dark = false});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory ElevationChart.withSampleData(bool dark) {
    return new ElevationChart(
      _createSampleData(dark),
      // Disable animations for image tests.
      animate: true,
      dark: dark,
    );
  }

  @override
  Widget build(BuildContext context) {

    return new charts.TimeSeriesChart(seriesList,
        animate: animate,
        // Provide a tickProviderSpec which does NOT require that zero is
        // included.
        primaryMeasureAxis: new charts.NumericAxisSpec(
            tickProviderSpec:
                new charts.BasicNumericTickProviderSpec(zeroBound: false)));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<MyRow, DateTime>> _createSampleData(bool dark) {
    final data = [
      MyRow(DateTime(1998), 382),
      MyRow(DateTime(1999), 368),
      MyRow(DateTime(2000), 387),
      MyRow(DateTime(2001), 388),
      MyRow(DateTime(2002), 394),
      MyRow(DateTime(2003), 374),
      MyRow(DateTime(2004), 398),
      MyRow(DateTime(2005), 383),
      MyRow(DateTime(2006), 395),
      MyRow(DateTime(2007), 412),
      MyRow(DateTime(2008), 400),
      MyRow(DateTime(2009), 420),
      MyRow(DateTime(2010), 398),
      MyRow(DateTime(2011), 401),
      MyRow(DateTime(2012), 406),
      MyRow(DateTime(2013), 422),
      MyRow(DateTime(2014), 409),
      MyRow(DateTime(2015), 432),
      MyRow(DateTime(2016), 430),
      MyRow(DateTime(2017), 412),
      MyRow(DateTime(2018), 411),
    ];

    return [
      new charts.Series<MyRow, DateTime>(
        id: 'Elevation',
        colorFn: (_, __) => dark
            ? charts.Color.fromHex(code: '#1EB980')
            : charts.MaterialPalette.teal.shadeDefault,
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.headcount,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class MyRow {
  final DateTime timeStamp;
  final int headcount;

  MyRow(this.timeStamp, this.headcount);
}
