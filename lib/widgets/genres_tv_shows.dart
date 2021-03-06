import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/bloc/get_tv_genres.dart';
import 'package:movies/model/tv.dart';
import 'package:movies/model/tv_response.dart';
import 'package:movies/screens/tv_detailed_screen.dart';
import 'package:movies/style/theme.dart' as Style;
import 'package:shimmer/shimmer.dart';

class GenreTv extends StatefulWidget {
  final int genreId;
  GenreTv({Key key, @required this.genreId}) : super(key: key);
  @override
  _GenreTvState createState() => _GenreTvState(genreId);
}

class _GenreTvState extends State<GenreTv> {
  final int genreId;
  _GenreTvState(this.genreId);
  @override
  void initState() {
    super.initState();

    tvByGenreBloc..getTvByGenre(genreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TvShowsResponse>(
      stream: tvByGenreBloc.subject.stream,
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
    return Container(
      height: 270.0,
      padding: const EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        itemCount: 12,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => Shimmer.fromColors(
          child: Container(
            padding: EdgeInsets.only(top: 10.0, right: 8.0),
            width: 100.0,
            child: Column(
              children: <Widget>[
                Container(
                  width: 120.0,
                  height: 180.0,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 5,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  height: 5,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ),
          baseColor: Colors.grey[500],
          highlightColor: Colors.white,
          period: Duration(seconds: 1),
        ),
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
    List<TvShows> tv = data.tvShows;
    if (tv.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Tv",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 270.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tv.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TvDetailScreen(tv: data.tvShows[index]),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    tv[index].poster == null
                        ? Hero(
                            tag: "tv_Icon_" + tv[index].id.toString(),
                            child: Container(
                              width: 120.0,
                              height: 180.0,
                              decoration: new BoxDecoration(
                                color: Style.Colors.secondColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 10,
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                shape: BoxShape.rectangle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    EvaIcons.filmOutline,
                                    color: Colors.white,
                                    size: 60.0,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Hero(
                            tag: "tv_" + tv[index].id.toString(),
                            child: Container(
                              width: 120.0,
                              height: 180.0,
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 10,
                                  ),
                                ],
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w200/" +
                                        tv[index].poster,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        tv[index].title,
                        maxLines: 2,
                        style: TextStyle(
                          height: 1,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                          shadows: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${tv[index].rating.toDouble()}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        RatingBar(
                          itemSize: 8.0,
                          initialRating: tv[index].rating / 2,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            EvaIcons.star,
                            color: Style.Colors.goldColor,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
