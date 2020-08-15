import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/db/tv_favorite_model.dart';
import 'package:movies/model/tv.dart';
import 'package:movies/screens/tv_detailed_screen.dart';
import 'package:provider/provider.dart';
import 'package:movies/style/theme.dart' as Style;

class TvFavorites extends StatefulWidget {
  @override
  _TvFavoritesState createState() => _TvFavoritesState();
}

class _TvFavoritesState extends State<TvFavorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TvFavoritesModel>(
      builder: (context, ft, _) {
        List<TvShows> tvs = ft.favorites;

        if (ft.favorites == null) {
          return _buildWidgetLoading();
        } else if (ft.favorites.length == 0) {
          return _buildWidgetNoResult();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            scrollDirection: Axis.vertical,
            itemCount: ft.favorites.length,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TvDetailScreen(tv: tvs[index]),
                  ),
                ),
                child: GridTile(
                  header: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      tvs[index].title.toString(),
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
                  child: tvs[index].poster == null
                      ? Hero(
                          tag: "tv_Icon_" + tvs[index].id.toString(),
                          child: Container(
                            width: 120.0,
                            height: 180.0,
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                              color: Style.Colors.secondColor,
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
                          tag: "tv_" + tvs[index].id.toString(),
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
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                              shape: BoxShape.rectangle,
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w200/" +
                                      tvs[index].poster,
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
                          tvs[index].rating.toString(),
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
                          initialRating: tvs[index].rating / 2,
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
          ),
        );
      },
    );
  }

  Widget _buildWidgetLoading() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white54,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  Widget _buildWidgetNoResult() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "No Favorites",
                style: TextStyle(color: Colors.white54),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          )
        ],
      ),
    );
  }
}
