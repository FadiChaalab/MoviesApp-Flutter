import 'package:flutter/material.dart';
import 'package:movies/style/theme.dart' as Style;

class PlqyerScreen extends StatefulWidget {
  @override
  _PlqyerScreenState createState() => _PlqyerScreenState();
}

class _PlqyerScreenState extends State<PlqyerScreen> {
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
                  "Player",
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
                  Icons.tap_and_play,
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