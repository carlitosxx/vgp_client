# EL PASO A PASO PARA AGREGAR UN FEATURE

## **1. DOMINIO: ENTIDAD**

### Directorio:

```
lib
├── app
    ├── domain
        ├── entities
            └── nombre_de_la_entidad.entity.dart
```

### Importamos la biblioteca **Equatable**, creamos la clase y los extendemos, agregamos el constructor con las propiedades de la clase, verificar si la propiedad es **requerida** o **opcional** por ultimo sobreescribimos la lista de las propiedades de la siguiente forma:

```dart
import 'package:equatable/equatable.dart';

import 'chapter.entity.dart';

class Course extends Equatable {
  const Course({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.createdAt,
    required this.updateAt,
    required this.chapter,
  });

  final String id;
  final String name;
  final String? description;
  final String? image;
  final DateTime createdAt;
  final DateTime updateAt;
  final List<Chapter> chapter;

  @override
  List<Object?> get props =>
      [id, name, description, image, createdAt, updateAt, chapter];
}

```

> OJO: SI ESTA ENTIDAD DEPENDE DE OTRA, LA TENEMOS QUE CREAR DE LA MISMA FORMA PARA LUEGO IMPORTALA, COMO EN ESTE CASO **CHAPTER**

> OJO: PARA CONSTRUIR GRAN PARTE DE ESO TENIENDO EL RESPONSE DEL API PUEDES UTILIZAR https://app.quicktype.io/ UTILIZANDO LAS OPCIONES DE **TYPES ONLY** Y **NULL SAFETY**

## **2. DOMINIO: REPOSITORIO**

### Directorio:

```
lib
├── app
    ├── domain
        ├── repositories
            └── nombre_del_repositorio.repository.dart
```

- ### Lo primero que haremos sera importar la clase **Either** esto nos ayudara a recibir un tipo de dato u otro, como por ejemplo podremos recibir una falla (HttpRequestFailure) o un exito(Course) en la peticion.

- ### Lo segundo es crear un **typedef** que haga referencia a un Future del subtipo **Either**.

- ### Lo tercero es crear la clase abstracta con el nombre del repositorio, este nombre debe tener la **Entidad** mas **Repository**.

- ### Por ultimo crearemos la funcion que va realizar, en este ejemplo es getCourse, si no tiene parametro pues no lo ponen caso cotrario si. Deben tener en cuenta el tipo que creamos anteriormente ya que ese es el tipo que retornara esta funcion

```dart
import 'package:vgp_cliente/app/core/either/either.dart';
import '../../core/errors/http_request_failure.dart';
import '../entities/course.entity.dart';

typedef GetCourseFuture = Future<Either<HttpRequestFailure, Course>>;

abstract class CourseRepository {
  GetCourseFuture getCourse(String courseId);
}
```

> OJO: El typedef creado es para tener un nombre mas corto asi de simple.

> OJO: El **Course** es una entidad y no un modelo.

> OJO: Este repositorio sera implementado en la capa de **DATOS** es por ello que solo es una interfaz, contrato o cascaron, casualmente por ello se creo como clase **abstracta** ya que esta no puede ser instanciada.

> OJO: Nuestro **HttpRequestFailure** es basicamente un ENUM o enumeracion esto quiere decir que tiene varias opciones de falla, por ejemplo: fallas en la red(network), falla en la peticion(badRequest o notFound), falla en la autorizacion de la peticion(unauthorized), falla en el servidor(server) etc. Si se encuentran algunas fallas que no han sido categorizadas lo tendremos que agregar a dicha clase

## **3. DOMINIO: CASO DE USO**

### Directorio:

```
lib
├── app
    ├── domain
        ├── usecases
            └── nombre_del_caso_de_uso.usecase.dart
```

- ### A nuestro caso de uso lo llamaremos igual que la funcion del repositorio pero con la terminacion **UC** (Use Case)
- ### Declaramos el repositorio y lo inicializamos el constructor **CourseRepository** con el mismo nombre.
- ### Esta clase se convertira en una clase **Callable** o **llamable**, es una clase que cuando se llama solo por su nombre se ejecuta un metodo, dicho metodo se debe llamar **call** (este nombre es reservado)
- ### Debe retornar un **Future Either** del mismo tipo que creamos para el repositorio (**GetCourseFuture**), por ultimo retornaremos a nuestro repositorio inicializado previamente y llamaremos su funcion como se muestra en el ejemplo:

```dart
import 'package:vgp_cliente/app/domain/repositories/course_repository.dart';

class GetCourseUC {
  GetCourseUC(this.courseRepository);
  final CourseRepository courseRepository;

  GetCourseFuture call(String courseId) async {
    return courseRepository.getCourse(courseId);
  }
}
```

> OJO: Esta clase sera usada en la capa de **presentacion**, especificamente en el **BLOC**

> OJO: En resumen cuando declaremos un GetCourseUC y la nombremos, automaticamente llamara la funcion del repositorio getCourse y esta a su vez cuando se utiliza la inyeccion de dependecias requerirá de su implementacion, es decir hace un vinculo desde la **capa de presentacion** (BLOC) hasta la **capa de datos** (datasource)

## **4. DATOS: MODELO**

### Directorio:

```
lib
├── app
    ├── data
        ├── models
            └── nombre_del_modelo.model.dart
```

- ### El modelo es similar a una entidad vitaminada con funciones, como por ejemplo el **mapToJson** , **fromJson** o **copyWith**.
- ### Los modelos deben extender de las entidades, y sus nombres deben terminar en **Model**.
- ### Para crearlo puedes ayudarte de https://app.quicktype.io/ agregando las opciones **Make all properties final**, **NullSafety** y **Generate CopyWith method**

> OJO: se puede usar freezed para generar codigo automaticamente de lo antes mencionado.

```dart
import 'dart:convert';
import 'package:vgp_cliente/app/domain/entities/course.entity.dart';
import 'chapter.model.dart';

CourseModel courseModelFromJson(String str) =>
    CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel extends Course {
  const CourseModel({
    required this.id,
    required this.name,
    this.description,
    this.image,
    required this.createdAt,
    required this.updateAt,
    required this.chapter,
  }) : super(
            id: id,
            name: name,
            description: description,
            image: image,
            createdAt: createdAt,
            updateAt: updateAt,
            chapter: chapter);

  final String id;
  final String name;
  final String? description;
  final String? image;
  final DateTime createdAt;
  final DateTime updateAt;
  final List<ChapterModel> chapter;

  CourseModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    DateTime? createdAt,
    DateTime? updateAt,
    List<ChapterModel>? chapter,
  }) =>
      CourseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt,
        chapter: chapter ?? this.chapter,
      );

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updateAt: DateTime.parse(json["update_at"]),
        chapter: List<ChapterModel>.from(
            json["chapter"].map((x) => ChapterModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
        "chapter": List<dynamic>.from(chapter.map((x) => x.toJson())),
      };
}

```

## **5. DATOS: FUENTE DE DATOS**

### Directorio:

```
lib
├── app
    ├── data
        ├── datasource
            ├── remote
            │   └── nombre_de_la_fuente_de_datos.datasource.dart
            └── local
```

- ### Este archivo es el encargado de conectarse a una fuente de datos, en este ejemplo se muestra un datasource **remote** esto quiere decir que es una fuente de datos externa al dispositivo (puede ser un api de terceros o de nuestro backend).

- ### Primero se crea la clase abstracta con la terminacion **DataSource** dentro de ella declaramos una función que debera ser implementada, logicamente esta funcion puede retornar 2 tipos de respuestas es por ello que seguiremos utilizando el **GetCourseFuture** (ya sabemos que este es un Future de un Either que puede resolver un **HttpRequestFailure** o un **Course**) .

- ### Luego creamos la clase a implementar con la terminacion **Impl** implementamos la clase abstracta antes mencionada y sobre escribimos la funcion **getCourse**, asi como tambien inicializamos el constructor con nuestro paquete http (en nuestro ejemplo DIO)

- ### Finalmente escribimos la logica para hacer la peticion y retornar un valor `Either.right(Course)` u otro `Either.left(failure)`

```dart
import 'package:dio/dio.dart';
import 'package:vgp_cliente/app/core/either/either.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/data/models/course/course.model.dart';
import 'package:vgp_cliente/environment/environment.dart';
import 'package:vgp_cliente/utils/dio_token_interceptor.dart';
import '../../../domain/repositories/course_repository.dart';

abstract class CourseDataSource {
  GetCourseFuture getCourse(String courseId);
}

class CourseDataSourceImpl implements CourseDataSource {
  final Dio dio;
  CourseDataSourceImpl(this.dio);

  @override
  GetCourseFuture getCourse(String courseId) async {
    try {
      String url = "${Environment.apiUrl}course/$courseId";
      dio.interceptors.add(DioTokenInterceptor());
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final course = CourseModel.fromJson(response.data);
        return Either.right(
          course,
        );
      } else {
        return Either.left(
          HttpRequestFailure.badRequest(),
        );
      }
    } on DioError catch (e) {
      late HttpRequestFailure failure;
      if (e.type == DioErrorType.response) {
        if (e.response!.statusCode == 404) {
          failure = HttpRequestFailure.notFound();
        } else if (e.response!.statusCode == 401) {
          failure = HttpRequestFailure.unauthorized();
        } else if (e.response!.statusCode == 500) {
          failure = HttpRequestFailure.server();
        }
      } else if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        failure = HttpRequestFailure.network();
      } else {
        failure = HttpRequestFailure.badRequest();
      }
      return Either.left(
        failure,
      );
    } catch (e) {
      return Either.left(
        HttpRequestFailure.local(),
      );
    }
  }
}

```

> OJO: deberas fijarte que se agregue el **DioTokenInterceptor**, ya que las peticiones deben tener una cabecera Authorization Bearer token

## **6. DATOS: IMPLEMENTACION DEL REPOSITORIO**

### Directorio:

```
lib
├── app
    ├── data
        ├── repositories_impl
            └── nombre_de_repositorio_a_implementar.repository_impl.dart
```

- ### Creamos la clase con la terminacion **RepositoryImpl** y lo implementamos al repositorio que se creo en la capa de dominio
- ### Luego inicializamos el constructor con el **datasource** creado previamente
- ### Por ultimo sobreescribimos la funcion del repositorio

```dart
import 'package:vgp_cliente/app/data/datasource/remote/course.datasource.dart';
import 'package:vgp_cliente/app/domain/repositories/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseDataSource _courseDataSource;
  CourseRepositoryImpl(this._courseDataSource);

  @override
  GetCourseFuture getCourse(String courseId) {
    return _courseDataSource.getCourse(courseId);
  }
}
```

## **7. PRESENTACION: BLOC**

### Directorio:

```
lib
├── app
    ├── presentation
        ├── pages
            ├── nombre_de_la_pagina
                ├── bloc
                    ├── nombre_del_bloc.bloc.dart
                    ├── nombre_del_bloc.event.dart
                    └── nombre_del_bloc.state.dart
```

### Bloc State:

- ### Creamos la clase abstracta con el nombre que termine en **State** y extendido de **Equatable**
- ### Finalmente creamos las clases para cada estado

```dart
part of 'course_bloc.dart';

abstract class CourseState extends Equatable {}

class CourseLoadingState extends CourseState {
  @override
  List<Object?> get props => [];
}

class CourseLoadedState extends CourseState {
  final Course course;
  CourseLoadedState(this.course);

  @override
  List<Object?> get props => [course];
}

class CourseErrorState extends CourseState {
  final String error;
  CourseErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

```

### Bloc event:

- ### Creamos la clase abstracta con el nombre que termine en **Event** y extendido de **Equatable**
- ### Finalmente creamos las clases para cada evento

```dart
part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class LoadCourseEvent extends CourseEvent {
  const LoadCourseEvent(this.courseId);
  final String courseId;
  @override
  List<Object?> get props => [courseId];
}
```

### Bloc:

- ### Creamos la clase bloc extendiendo de la biblioteca bloc con los sub tipos evento y estado del respectivo bloc
- ### Declaramos el caso de uso para insertarlo en el constructor del bloc, asi mismo inicializamos de la clase padre con el estado de loading
- ### Y finalmente se agrega la logica segun el evento

```dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vgp_cliente/app/core/errors/http_request_failure.dart';
import 'package:vgp_cliente/app/domain/entities/course.entity.dart';
import 'package:vgp_cliente/app/domain/usecases/get-course.usecase.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetCourseUC _getCourseUC;

  CourseBloc(this._getCourseUC) : super(CourseLoadingState()) {
    on<LoadCourseEvent>((event, emit) async {
      emit(CourseLoadingState());
      final course = await _getCourseUC(event.courseId);
      course.when(
          left: (failure) =>
              emit(CourseErrorState(mapFailureToString(failure))),
          right: (course) => emit(CourseLoadedState(course)));
    });
  }
}

String mapFailureToString(HttpRequestFailure failure) {
  return failure.when(
      network: () => 'Hubo un problema de red',
      notFound: () => 'No se encontro el recurso',
      server: () => 'Hubo un problema en el servidor',
      unauthorized: () => 'No estas autorizado',
      badRequest: () => 'La solicitud no puede ser procesado',
      local: () => 'Hubo un problema local o desconocido');
}

```

## **8. CONTENEDOR DE INYECCIONES**

### Directorio:

```
lib
└── Container_inyection.dart
```

- ### Agregamos todos las dependencias a nuestro **service locator**
- ### Este contenedor esta inicializado en el archivo **main.dart**

```dart
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

```
