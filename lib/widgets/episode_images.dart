import 'package:flutter/material.dart';
import 'package:movies/bloc/get_episode_image_bloc.dart';
import 'package:movies/model/image.dart';
import 'package:movies/model/image_response.dart';
import 'package:movies/style/theme.dart' as Style;

class EpisodeImages extends StatefulWidget {
  final int id;
  final int number;
  final int episode;
  EpisodeImages(
      {Key key,
      @required this.id,
      @required this.number,
      @required this.episode})
      : super(key: key);
  @override
  _EpisodeImagesState createState() => _EpisodeImagesState(id, number, episode);
}

class _EpisodeImagesState extends State<EpisodeImages> {
  final int id;
  final int number;
  final int episode;
  _EpisodeImagesState(this.id, this.number, this.episode);
  @override
  void initState() {
    super.initState();
    episodeImageBloc..getEpisodeImages(id, number, episode);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ImageResponse>(
      stream: episodeImageBloc.subject.stream,
      builder: (context, AsyncSnapshot<ImageResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildEpisodeImageWidget(snapshot.data);
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

  Widget _buildEpisodeImageWidget(ImageResponse data) {
    List<ImageRequest> images = data.images;
    if (images.length == 0) {
      return Container();
    } else
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20.0),
            child: Text(
              "PREVIEW",
              style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0,
              ),
            ),
          ),
          Container(
            height: 240.0,
            padding: EdgeInsets.only(left: 10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(top: 10.0, right: 8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                          tag: "image" + images[index].img,
                          child: Container(
                            width: 280.0,
                            height: 200.0,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w300/" +
                                      images[index].img,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
  }
}
