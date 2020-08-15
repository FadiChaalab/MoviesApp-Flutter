import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/bloc/get_movie_search.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/model/movie_response.dart';
import 'package:movies/screens/movie_detailed_screen.dart';
import 'package:movies/style/theme.dart' as Style;

class SearchScreen extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) searchMoviesBloc..getSearchedMovies(query);
    searchMoviesBloc..drainStream();
    return query.isNotEmpty
        ? StreamBuilder<MovieResponse>(
            stream: searchMoviesBloc.subject.stream,
            builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return _buildResultWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            },
          )
        : Center(
            child: Text("No match!"),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty == true) searchMoviesBloc..getSearchedMovies(query);
    searchMoviesBloc..drainStream();
    return query.isNotEmpty
        ? StreamBuilder<MovieResponse>(
            stream: searchMoviesBloc.subject.stream,
            builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return _buildSuggestionsWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            },
          )
        : Center(
            child: Text("No match!"),
          );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.lightBlueAccent,
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

  Widget _buildSuggestionsWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Center(
        child: Text("No match!"),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                query = movies[index].title;
              },
              child: Text(movies[index].title),
            ),
          );
        },
      );
    }
  }

  Widget _buildResultWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Center(
        child: Text("No match!"),
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        scrollDirection: Axis.vertical,
        itemCount: movies.length,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MovieDetailScreen(movie: data.movies[index]),
              ),
            ),
            child: GridTile(
              header: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  movies[index].title,
                  maxLines: 2,
                  style: TextStyle(
                    height: 1,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              child: movies[index].poster == null
                  ? Hero(
                      tag: "movie_Icon_" + movies[index].id.toString(),
                      child: Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: new BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                          color: Style.Colors.secondColor,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                      tag: "movie_" + movies[index].id.toString(),
                      child: Container(
                        width: 120.0,
                        height: 180.0,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://image.tmdb.org/t/p/w200/" +
                                  movies[index].poster,
                            ),
                          ),
                        ),
                      ),
                    ),
              footer: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      movies[index].rating.toString(),
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
                      initialRating: movies[index].rating / 2,
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
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
