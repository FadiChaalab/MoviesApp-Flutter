import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/drawer_bloc.dart';
import 'package:movies/db/movie_favorite_model.dart';
import 'package:movies/db/tv_favorite_model.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MovieFavoritesModel>(
            create: (context) => MovieFavoritesModel(),
          ),
          ChangeNotifierProvider<TvFavoritesModel>(
            create: (context) => TvFavoritesModel(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DrawerBloc>(
      create: (context) => DrawerBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
        ),
        home: HomeScreen(),
      ),
    );
  }
}
