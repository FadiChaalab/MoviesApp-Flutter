import 'package:flutter/material.dart';
import 'package:movies/bloc/get_genres_tv.dart';
import 'package:movies/model/genre.dart';
import 'package:movies/model/genre_response.dart';
import 'package:movies/widgets/genres_tv_list.dart';
import 'package:shimmer/shimmer.dart';

class GenresTvScreen extends StatefulWidget {
  @override
  _GenresTvScreenState createState() => _GenresTvScreenState();
}

class _GenresTvScreenState extends State<GenresTvScreen> {
  @override
  void initState() {
    super.initState();
    genresTvBloc..getGenresTv();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
      stream: genresTvBloc.subject.stream,
      builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
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
      height: 307.0,
      padding: const EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        itemCount: 12,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => Shimmer.fromColors(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 15.0, top: 10.0, right: 10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 120.0,
                      height: 30.0,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                  ],
                ),
              ),
            ],
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
    ));
  }

  Widget _buildHomeWidget(GenreResponse data) {
    List<Genre> genres = data.genres;
    print(genres);
    if (genres.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Tv Shows",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return GenresTvList(
        genres: genres,
      );
  }
}
