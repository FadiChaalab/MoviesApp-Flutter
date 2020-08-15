import 'package:flutter/material.dart';
import 'package:movies/bloc/drawer_bloc.dart';
import 'package:movies/model/options.dart';
import 'package:movies/style/theme.dart' as Style;

class Settings extends StatefulWidget with DrawerStates {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedOption = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: options.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return SizedBox(height: 40.0);
          } else if (index == options.length + 1) {
            return SizedBox(height: 80.0);
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              alignment: Alignment.center,
              margin: EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                color: _selectedOption == index - 1 ? Style.Colors.goldColor : Colors.black,
                borderRadius: BorderRadius.circular(10.0),
                border: _selectedOption == index - 1
                    ? Border.all(color: Style.Colors.goldColor)
                    : null,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    spreadRadius: 2,
                    color: _selectedOption == index - 1 ? Style.Colors.mainColor : Colors.transparent,
                  ),
                ],
              ),
              child: ListTile(
                leading: Icon(options[index - 1].icon, color: _selectedOption == index - 1
                        ? Colors.white
                        : Colors.grey[600],),
                title: Text(
                  options[index - 1].title,
                  style: TextStyle(
                    color: Colors.white,
                        
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  options[index - 1].subtitle,
                  style: TextStyle(
                    color:
                        _selectedOption == index - 1 ? Colors.white : Colors.grey,
                    fontSize: 16,
                  ),
                ),
                selected: _selectedOption == index - 1,
                onTap: () {
                  setState(() {
                    _selectedOption = index - 1;
                  });
                },
              ),
            ),
          );
        },
      );
  }
}
