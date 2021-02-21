import 'dart:io';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_play_music_flutter_clone/bloc/albums_bloc.dart/bloc/albums_bloc.dart';
import 'package:google_play_music_flutter_clone/ui/views/card_view.dart';
import 'package:google_play_music_flutter_clone/ui/views/loading.dart';

class AlbumsPage extends StatefulWidget {
  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Immediately trigger the event
    BlocProvider.of<AlbumsBloc>(context).add(LoadAlbums());
  }

 

  @override
  Widget build(BuildContext context) {
    return BlocListener<AlbumsBloc, AlbumsState>(
      listener: (context, state) {},
      child: BlocBuilder<AlbumsBloc, AlbumsState>(
        builder: (context, state) {
          if (state is AlbumsInitial) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Loading(),
            );
          } else if (state is NoAlbumsAvailable) {
            return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: Text(
                  state.message,
                  style: TextStyle(
                      color: Colors.deepOrange.withOpacity(0.4),
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0),
                )));
          } else if (state is AlbumsLoaded) {
            List<Song> albums = state.allAlbumsList;
            return Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0,10.0,10.0,75.0),
                child: GridView.builder(
                  itemCount: albums.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1.5,
                      mainAxisSpacing: 1.5,
                      childAspectRatio: 0.7),
                  itemBuilder: (BuildContext context, int index) {
                    return CardView(albums: albums,index: index);
                  },
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
