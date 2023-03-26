import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vgp_cliente/app/data/datasource/remote/course.datasource.dart';
import 'package:vgp_cliente/app/data/repositories_impl/course_repository_impl.dart';
import 'package:vgp_cliente/app/domain/repositories/course_repository.dart';
import 'package:vgp_cliente/app/domain/usecases/get-course.usecase.dart';
import 'package:vgp_cliente/app/presentation/pages/course/bloc/course_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//BLOC's
  sl.registerFactory(() => CourseBloc(sl()));

//Casos de Uso
  sl.registerLazySingleton(() => GetCourseUC(sl()));

//Repositorios
  sl.registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl(sl()));

//Data source
  sl.registerLazySingleton<CourseDataSource>(() => CourseDataSourceImpl(sl()));

//Librerias externas
  sl.registerLazySingleton(() => Dio());
}
