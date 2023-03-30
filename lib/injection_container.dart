import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vgp_cliente/app/data/datasource/remote/course.datasource.dart';
import 'package:vgp_cliente/app/data/datasource/remote/login.datasource.dart';
import 'package:vgp_cliente/app/data/datasource/remote/user-experience.datasource.dart';
import 'package:vgp_cliente/app/data/repositories_impl/course_repository.impl.dart';
import 'package:vgp_cliente/app/domain/repositories/course.repository.dart';
import 'package:vgp_cliente/app/data/repositories_impl/login_repository.impl.dart';
import 'package:vgp_cliente/app/domain/repositories/login.repository.dart';
import 'package:vgp_cliente/app/domain/repositories/user-experience.repository.dart';
import 'package:vgp_cliente/app/domain/usecases/get-course.usecase.dart';
import 'package:vgp_cliente/app/domain/usecases/login.usecase.dart';
import 'package:vgp_cliente/app/domain/usecases/user-experience.usecase.dart';
import 'package:vgp_cliente/app/presentation/pages/course/bloc/course_bloc.dart';
import 'package:vgp_cliente/app/presentation/pages/home/blocs/user_experience/user_experience.bloc.dart';
import 'package:vgp_cliente/app/presentation/pages/login/blocs/login/login_bloc.dart';

import 'app/data/repositories_impl/user_experience.impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
//BLOC's
  sl.registerFactory(() => CourseBloc(sl()));
  sl.registerFactory(() => UserExperienceBloc(sl()));
  sl.registerFactory(() => LoginBloc(sl()));
//Casos de Uso
  sl.registerLazySingleton(() => GetCourseUC(sl()));
  sl.registerLazySingleton(() => GetUserAndExperienceUC(sl()));
  sl.registerLazySingleton(() => GetLoginUC(sl()));
//Repositorios
  sl.registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl(sl()));
  sl.registerLazySingleton<UserExperienceRepository>(
      () => UserExperienceRepositoryImpl(sl()));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));
//Data source
  sl.registerLazySingleton<CourseDataSource>(() => CourseDataSourceImpl(sl()));
  sl.registerLazySingleton<UserExperienceDataSource>(
      () => UserExperienceDataSourceImpl(sl()));
  sl.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImpl(sl()));

//Librerias externas
  sl.registerLazySingleton(() => Dio());
}
