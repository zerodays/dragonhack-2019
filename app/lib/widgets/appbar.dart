import 'package:flutter/material.dart';
import 'package:dragonhack_2019/history_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final double height;

  CustomAppBar({
    Key key,
    this.height = 64.0,
  }) : preferredSize = Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: height,
        padding: EdgeInsets.only(top: 8.0),
        width: MediaQuery.of(context).size.width,
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(32.0),
                    bottomRight: Radius.circular(32.0)
                ),
                child: Container(
                  height: 56.0,
                  width: 56.0,
                  color: Colors.white,
                  child: IconButton(icon: Icon(Icons.satellite), onPressed: () => {}),
                ),
              ),
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
                      child: Text(
                        'RED TEAM',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    bottomLeft: Radius.circular(32.0)
                ),
                child: Container(
                  height: 56.0,
                  width: 56.0,
                  color: Colors.white,
                  child: IconButton(icon: Icon(Icons.satellite), onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => HistoryPage()));
                  }),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
