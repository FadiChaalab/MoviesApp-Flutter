import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movies/style/theme.dart' as Style;

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const MenuItem({Key key, this.icon, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Style.Colors.goldColor,
              highlightColor: Style.Colors.secondColor,
              period: Duration(seconds: 2),
              child: Icon(
                icon,
                size: 24,
              ),
            ),
            SizedBox(
              width: _width * 0.04,
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                letterSpacing: 1,
                fontFamily: 'Poppins',
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
