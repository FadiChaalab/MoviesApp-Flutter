import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/bloc/drawer_bloc.dart';
import 'package:movies/screens/about.dart';
import 'package:movies/screens/favorites.dart';
import 'package:movies/screens/movie_screen.dart';
import 'package:movies/screens/search_screen.dart';
import 'package:movies/screens/searched_tv_screen.dart';
import 'package:movies/screens/tvshows.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/menu_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  DrawerStates states;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Drawer(
          elevation: 15,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: ListView(
              children: <Widget>[
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/movie.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<DrawerBloc>(context)
                        .add(DrawerEvents.MoviesEvent);
                    Navigator.pop(context);
                  },
                  child: MenuItem(
                    icon: FontAwesomeIcons.video,
                    title: "Movies",
                  ),
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<DrawerBloc>(context)
                        .add(DrawerEvents.TvShowsEvent);
                    Navigator.pop(context);
                  },
                  child: MenuItem(
                    icon: FontAwesomeIcons.tv,
                    title: "Tv Shows",
                  ),
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<DrawerBloc>(context)
                        .add(DrawerEvents.FavoritesEvent);
                    Navigator.pop(context);
                  },
                  child: MenuItem(
                    icon: FontAwesomeIcons.heart,
                    title: "Favorites",
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 0.5,
                  color: Colors.white.withOpacity(0.3),
                  indent: 32,
                  endIndent: 32,
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<DrawerBloc>(context)
                        .add(DrawerEvents.AboutEvent);
                    Navigator.pop(context);
                  },
                  child: MenuItem(
                    icon: FontAwesomeIcons.info,
                    title: "About",
                  ),
                ),
                InkWell(
                  onTap: () {
                    BlocProvider.of<DrawerBloc>(context)
                        .add(DrawerEvents.SettingsEvent);
                    Navigator.pop(context);
                  },
                  child: MenuItem(
                    icon: FontAwesomeIcons.cog,
                    title: "Settings",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,        
        title: BlocBuilder<DrawerBloc, DrawerStates>(
          builder: (context, DrawerStates drawerState){
          if (findSelectedIndex(drawerState) == 0) {
                    return Text("Movies");
                  } else if (findSelectedIndex(drawerState) == 1){
                    return Text("TvShows");
                  }else if (findSelectedIndex(drawerState) == 2){
                    return Text("Favorites");
                  }else if (findSelectedIndex(drawerState) == 3){
                    return Text("About");
                  }else {
                    return Text("Settings");
                  }
        }),
        actions: <Widget>[
          BlocBuilder<DrawerBloc, DrawerStates>(
            builder: (context, DrawerStates drawerState) {
              return IconButton(
                onPressed: () {
                  if (findSelectedIndex(drawerState) == 0) {
                    showSearch(context: context, delegate: SearchScreen());
                  } else if (findSelectedIndex(drawerState) == 1)
                    showSearch(context: context, delegate: SearchTvScreen());
                },
                icon: findSelectedIndex(drawerState) == 0 || findSelectedIndex(drawerState) == 1 ?
                  Icon(
                  EvaIcons.searchOutline,
                  color: Colors.white,
                ) : Icon(
                  EvaIcons.searchOutline,
                  color: Colors.transparent,
                ),                
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<DrawerBloc, DrawerStates>(
        builder: (context, state) {
          return state as Widget;
        },
      ),
    );
  }

  int findSelectedIndex(DrawerStates drawerState) {
    if (drawerState is MovieScreen) {
      return 0;
    } else if (drawerState is TvShowsScreen) {
      return 1;
    } else if (drawerState is Favorites){
      return 2;
    }else if(drawerState is About){
      return 3;
    }else{
      return 4;
    }
  }
}
