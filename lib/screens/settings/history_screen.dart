import 'package:flutter/material.dart';
import 'package:movies/style/theme.dart' as Style;

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "History",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        color: Colors.grey,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.history,
                  size: 24,
                  color: Style.Colors.goldColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}