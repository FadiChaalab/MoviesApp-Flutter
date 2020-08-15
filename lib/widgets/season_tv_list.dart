import 'package:flutter/material.dart';
import 'package:movies/bloc/get_tv_genres.dart';
import 'package:movies/model/season.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/season_tv.dart';

class SeasonTvList extends StatefulWidget {
  final List<Season> season;
  final int id;
  SeasonTvList({Key key, @required this.season, @required this.id})
      : super(key: key);
  @override
  _SeasonTvListState createState() => _SeasonTvListState(season, id);
}

class _SeasonTvListState extends State<SeasonTvList>
    with SingleTickerProviderStateMixin {
  final List<Season> season;
  final int id;
  _SeasonTvListState(this.season, this.id);
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: season.length);
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
      height: 340.0,
      child: DefaultTabController(
        length: season.length,
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
                tabs: season.map(
                  (Season season) {
                    return Container(
                      padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                      child: new Text(
                        season.title.toUpperCase(),
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
            children: season.map(
              (Season season) {
                return SeasonTv(
                  number: season.seasonNumber,
                  id: id,
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
