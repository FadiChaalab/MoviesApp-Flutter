import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/bloc/get_episode_detail_bloc.dart';
import 'package:movies/model/episode_detail.dart';
import 'package:movies/model/episode_detail_response.dart';
import 'package:movies/style/theme.dart' as Style;

class EpisodeInfo extends StatefulWidget {
  final int id;
  final int number;
  final int episode;
  EpisodeInfo(
      {Key key,
      @required this.id,
      @required this.number,
      @required this.episode})
      : super(key: key);
  @override
  _EpisodeInfoState createState() => _EpisodeInfoState(id, number, episode);
}

class _EpisodeInfoState extends State<EpisodeInfo> {
  final int id;
  final int number;
  final int episode;
  _EpisodeInfoState(this.id, this.number, this.episode);
  @override
  void initState() {
    super.initState();
    episodeDetailBloc..getEpisodeDetail(id, number, episode);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EpisodeDetailResponse>(
      stream: episodeDetailBloc.subject.stream,
      builder: (context, AsyncSnapshot<EpisodeDetailResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildEpisodeDetailWidget(snapshot.data);
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
        children: [],
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

  Widget _buildEpisodeDetailWidget(EpisodeDetailResponse data) {
    EpisodeDetail detail = data.episodeDetail;
    final crew = detail.crew;
    final guests = detail.guests;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "CREW",
            style: TextStyle(
              color: Style.Colors.titleColor,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),
        crew.length != 0
            ? Container(
                height: 140.0,
                padding: EdgeInsets.only(left: 10.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: crew.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(top: 10.0, right: 8.0),
                      width: 100.0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            crew[index].img == null
                                ? Hero(
                                    tag: "crew_icon" +
                                        crew[index].credit.toString(),
                                    child: Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Style.Colors.secondColor,
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.userAlt,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Hero(
                                    tag: "crew" + crew[index].credit.toString(),
                                    child: Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w300/" +
                                                crew[index].img,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              crew[index].name,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1.4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 9.0,
                              ),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Text(
                              crew[index].job,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1.4,
                                color: Style.Colors.titleColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 7.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Text(
                    "No Information",
                    style: TextStyle(
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
          child: Text(
            "GUESTS",
            style: TextStyle(
              color: Style.Colors.titleColor,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),
        guests.length != 0
            ? Container(
                height: 140.0,
                padding: EdgeInsets.only(left: 10.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: guests.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(top: 10.0, right: 8.0),
                      width: 100.0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            guests[index].img == null
                                ? Hero(
                                    tag: "guest_icon" +
                                        guests[index].credit.toString(),
                                    child: Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Style.Colors.secondColor,
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.userAlt,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Hero(
                                    tag: "guest" +
                                        guests[index].credit.toString(),
                                    child: Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w300/" +
                                                guests[index].img,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              guests[index].name,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1.4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 9.0,
                              ),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Text(
                              guests[index].character,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1.4,
                                color: Style.Colors.titleColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 7.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Text(
                    "No Information",
                    style: TextStyle(
                      color: Style.Colors.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
