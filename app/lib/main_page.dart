import 'package:flutter/material.dart';
import 'widgets/appbar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.network(
              'https://pctechmag.com/wp-content/uploads/2016/06/google-maps-earth-satellite-imagery-2016-3.0.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.local_florist),
              onPressed: () {},
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
            ),
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 6.0,
              child: Container(
                height: 48.0,
                child: Row(
                  children: <Widget>[
                    _getPercentageDisplay(10.2, true),
                    Expanded(child: Container(),),
                    _getPercentageDisplay(89.8, false)
                  ],
                ),
              ),
            ),
            body: Center(child: Text('asdf'),),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _getPercentageDisplay(double percentage, bool blue) {
    return Expanded(
      child: Container(
        height: 46.0,
        color: Colors.transparent,
        child: Center(
          child: Text('$percentage %', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),),
        ),
      ),
    );
  }
}
