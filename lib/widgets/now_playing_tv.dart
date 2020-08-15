import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/bloc/get_tv_discover_bloc.dart';
import 'package:movies/model/tv.dart';
import 'package:movies/model/tv_response.dart';
import 'package:movies/screens/tv_detailed_screen.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:page_indicator/page_indicator.dart';
import 'package:shimmer/shimmer.dart';

class NowPlayingTv extends StatefulWidget {
  @override
  _NowPlayingTvState createState() => _NowPlayingTvState();
}

class _NowPlayingTvState extends State<NowPlayingTv> {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    super.initState();
    discoverTvListBloc..getDiscover();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TvShowsResponse>(
      stream: discoverTvListBloc.subject.stream,
      builder: (context, AsyncSnapshot<TvShowsResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[500],
            highlightColor: Colors.white,
            period: Duration(seconds: 1),
            child: Container(
              height: 220,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occured: $error"),
        ],
      ),
    );
  }

  Widget _buildHomeWidget(TvShowsResponse data) {
    List<TvShows> tvs = data.tvShows;
    if (tvs.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Tvs",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 220.0,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          length: tvs.take(5).length,
          indicatorSpace: 8.0,
          padding: const EdgeInsets.all(5.0),
          indicatorColor: Style.Colors.titleColor,
          indicatorSelectorColor: Style.Colors.goldColor,
          shape: IndicatorShape.circle(size: 5.0),
          pageView: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: tvs.take(5).length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TvDetailScreen(tv: tvs[index]),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: "slideTv_" + tvs[index].id.toString(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 220.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://image.tmdb.org/t/p/original/" +
                                  tvs[index].backPoster,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.0, 0.9],
                          colors: [
                            Style.Colors.mainColor.withOpacity(1.0),
                            Style.Colors.mainColor.withOpacity(0.0)
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.playCircle,
                          color: Style.Colors.goldColor,
                          size: 40.0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Positioned(
                      bottom: 30.0,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        width: 250.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tvs[index].title,
                              style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
  }
}
