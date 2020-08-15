import 'dart:ui';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/bloc/get_episode_video_bloc.dart';
import 'package:movies/model/episode.dart';
import 'package:movies/model/video.dart';
import 'package:movies/model/video_response.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:movies/widgets/episode_images.dart';
import 'package:movies/widgets/episode_info.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'video_player.dart';

class EpisodeDetailScreen extends StatefulWidget {
  final Episode episode;
  final int tvId;
  EpisodeDetailScreen({Key key, @required this.episode, @required this.tvId})
      : super(key: key);
  @override
  _EpisodeDetailScreenState createState() =>
      _EpisodeDetailScreenState(episode, tvId);
}

class _EpisodeDetailScreenState extends State<EpisodeDetailScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Episode episode;
  final int tvId;
  _EpisodeDetailScreenState(this.episode, this.tvId);

  @override
  void initState() {
    super.initState();
    episodeVideoBloc
      ..getEpisodeVideos(tvId, episode.seasonNumber, episode.episodeNumber);
  }

  @override
  void dispose() {
    super.dispose();
    episodeVideoBloc..drainStream();
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
              stream: episodeVideoBloc.subject.stream,
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
                    episode.title.length > 40
                        ? episode.title.substring(0, 37) + "..."
                        : episode.title,
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
                            image: episode.poster == null
                                ? AssetImage("assets/images/movie.jpg")
                                : NetworkImage(
                                    "https://image.tmdb.org/t/p/original/" +
                                        episode.poster,
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
                              "${episode.rating.toDouble()}",
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
                              initialRating: episode.rating / 2,
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
                        child: episode.overview.isNotEmpty
                            ? Text(
                                episode.overview,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    height: 1.5),
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
                      EpisodeImages(
                        id: tvId,
                        number: episode.seasonNumber,
                        episode: episode.episodeNumber,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      EpisodeInfo(
                        id: tvId,
                        number: episode.seasonNumber,
                        episode: episode.episodeNumber,
                      ),
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
