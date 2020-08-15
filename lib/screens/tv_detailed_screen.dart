import 'dart:ui';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/bloc/get_tv_video_bloc.dart';
import 'package:movies/db/tv_favorite_model.dart';
import 'package:movies/model/tv.dart';
import 'package:movies/model/video.dart';
import 'package:movies/model/video_response.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/casts_tv.dart';
import 'package:movies/widgets/recommendation_tv.dart';
import 'package:movies/widgets/similair_tv.dart';
import 'package:movies/widgets/tv_info.dart';
import 'package:provider/provider.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'video_player.dart';

class TvDetailScreen extends StatefulWidget {
  final TvShows tv;
  TvDetailScreen({Key key, @required this.tv}) : super(key: key);
  @override
  _TvDetailScreenState createState() => _TvDetailScreenState(tv);
}

class _TvDetailScreenState extends State<TvDetailScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TvShows tv;
  _TvDetailScreenState(this.tv);

  @override
  void initState() {
    super.initState();
    tvVideoBloc..getTvVideos(tv.id);
  }

  @override
  void dispose() {
    super.dispose();
    tvVideoBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Style.Colors.mainColor,
      body: new Builder(
        builder: (context) {
          return new SliverFab(
            floatingPosition: FloatingPosition(right: 20),
            floatingWidget: StreamBuilder<VideoResponse>(
              stream: tvVideoBloc.subject.stream,
              builder: (context, AsyncSnapshot<VideoResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.error != null &&
                      snapshot.data.error.length > 0) {
                    return _buildErrorWidget(snapshot.data.error);
                  }
                  return _buildVideoWidget(snapshot.data);
                } else if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error);
                } else {
                  return _buildLoadingWidget();
                }
              },
            ),
            expandedHeight: 200.0,
            slivers: <Widget>[
              new SliverAppBar(
                backgroundColor: Style.Colors.mainColor,
                expandedHeight: 200.0,
                automaticallyImplyLeading: false,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(
                  title: Text(
                    tv.title.length > 40
                        ? tv.title.substring(0, 37) + "..."
                        : tv.title,
                    style: TextStyle(
                        fontSize: 12.0, fontWeight: FontWeight.normal),
                  ),
                  background: Stack(
                    children: <Widget>[
                      Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: tv.backPoster == null
                                ? AssetImage("assets/images/movie.jpg")
                                : NetworkImage(
                                    "https://image.tmdb.org/t/p/original/" +
                                        tv.backPoster,
                                  ),
                          ),
                        ),
                        child: new Container(
                          decoration: new BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.1, 0.9],
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.black.withOpacity(0.0)
                            ],
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 40,
                        right: 20,
                        child: Consumer<TvFavoritesModel>(
                          builder: (context, favorites, _) => IconButton(
                            onPressed: () {
                              if (!favorites.alreadyExists(tv)) {
                                favorites.add(tv);
                              } else {
                                favorites.remove(tv);
                              }
                            },
                            icon: Icon(
                              favorites.alreadyExists(tv)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: favorites.alreadyExists(tv)
                                  ? Colors.red
                                  : Colors.grey,
                              size: 35.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(0.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${tv.rating.toDouble()}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            RatingBar(
                              itemSize: 10.0,
                              initialRating: tv.rating / 2,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                EvaIcons.star,
                                color: Style.Colors.goldColor,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: Text(
                          "OVERVIEW",
                          style: TextStyle(
                            color: Style.Colors.titleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: tv.overview.isNotEmpty
                            ? Text(
                                tv.overview,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  height: 1.5,
                                ),
                              )
                            : Text(
                                "No Information",
                                style: TextStyle(
                                  color: Style.Colors.titleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0,
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TvInfo(
                        id: tv.id,
                      ),
                      TvCasts(
                        id: tv.id,
                      ),
                      SimilarTv(id: tv.id),
                      RecommendationTv(id: tv.id),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    ));
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

  Widget _buildVideoWidget(VideoResponse data) {
    List<Video> videos = data.videos;
    return FloatingActionButton(
      backgroundColor: Style.Colors.goldColor,
      elevation: 5,
      onPressed: () {
        videos.length == 0
            ? _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text('Sorry no videos available'),
                  duration: Duration(seconds: 3),
                ),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                    controller: YoutubePlayerController(
                      initialVideoId: videos[0].key,
                      flags: YoutubePlayerFlags(
                        mute: false,
                        autoPlay: true,
                        disableDragSeek: false,
                        loop: false,
                        isLive: false,
                        forceHD: false,
                        enableCaption: true,
                      ),
                    ),
                  ),
                ),
              );
      },
      child: Icon(Icons.play_arrow),
    );
  }
}
