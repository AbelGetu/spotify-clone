import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/domain/entities/auth/song/song.dart';
import 'package:spotify/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify/presentation/home/bloc/news_songs_state.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
          builder: (context, state) {
            print(state);
            if (state is NewsSongsLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }

            if (state is NewsSongsLoaded) {
              print(state);
              return _songs(state.songs);
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 160,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(AppUrls.firestorage +
                                songs[index].artist +
                                ' - ' +
                                songs[index].title +
                                '.jpg' +
                                AppUrls.mediaAlt))),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              width: 14,
            ),
        itemCount: songs.length);
  }
}
