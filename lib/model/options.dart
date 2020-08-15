import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Option {
  final IconData icon;
  final String title;
  final String subtitle;
  final Function onTap;

  Option({this.icon, this.title, this.subtitle, this.onTap});
}

final options = [
  Option(
    icon: Icons.palette,
    title: 'Theme',
    subtitle: 'Choose your style.',
    onTap: (){}
  ),
  Option(
    icon: Icons.history,
    title: 'History',
    subtitle: 'Manage your history.',
    onTap: (){}
  ),
  Option(
    icon: Icons.account_circle,
    title: 'Account',
    subtitle: 'Manage your account.',
    onTap: (){}
  ),
  Option(
    icon: Icons.watch_later, 
    title: 'Bookmarks',
    subtitle: 'Manage your bookmarks.',
    onTap: (){}
  ),
  Option(
    icon: FontAwesomeIcons.video, 
    title: 'Player',
    subtitle: 'Change the player.',
    onTap: (){}
  ),
  Option(
    icon: Icons.backup, 
    title: 'Backup',
    subtitle: 'Restore your data.',
    onTap: (){}
  ),
  Option(
    icon: Icons.settings,
    title: 'Settings',
    subtitle: 'Manage your settings.',
    onTap: (){}
  ),
];