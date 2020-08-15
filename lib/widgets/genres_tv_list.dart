import 'package:flutter/material.dart';
import 'package:movies/bloc/get_tv_genres.dart';
import 'package:movies/model/genre.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/genres_tv_shows.dart';

class GenresTvList extends StatefulWidget {
  final List<Genre> genres;
  GenresTvList({Key key, @required this.genres}) : super(key: key);
  @override
  _GenresTvListState createState() => _GenresTvListState(genres);
}

class _GenresTvListState extends State<GenresTvList>
    with SingleTickerProviderStateMixin {
  final List<Genre> genres;
  _GenresTvListState(this.genres);
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: genres.length);
    _tabController.addListener(
      () {
        if (_tabController.indexIsChanging) {
          tvByGenreBloc..drainStream();
        }
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307.0,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: Style.Colors.mainColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: Style.Colors.mainColor,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Style.Colors.goldColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                unselectedLabelColor: Style.Colors.titleColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: genres.map(
                  (Genre genre) {
                    return Container(
                      padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                      child: new Text(
                        genre.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: genres.map(
              (Genre genre) {
                return GenreTv(
                  genreId: genre.id,
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
