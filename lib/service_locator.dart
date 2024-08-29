import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_implemenation.dart';
import 'package:spotify/data/repository/song/song_repository_implementation.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/domain/repository/auth/song/song.dart';
import 'package:spotify/domain/usecases/auth/signin.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';
import 'package:spotify/domain/usecases/song/get_news_songs.dart';

final sl = GetIt.instance; // sl: service locator

Future<void> initializeDependecies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImplmentation());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImplemenation());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImplemenation());
  sl.registerSingleton<SongRepository>(SongRepositoryImplementation());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
}
