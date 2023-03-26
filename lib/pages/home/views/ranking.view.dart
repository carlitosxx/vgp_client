import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgp_cliente/app/presentation/pages/course/bloc/course_bloc.dart';
import 'package:vgp_cliente/injection_container.dart';

class RankingView extends StatefulWidget {
  const RankingView({super.key});

  @override
  State<RankingView> createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<CourseBloc>()
        ..add(const LoadCourseEvent("f554d155-0c37-4cbb-9612-2580ff7021f5")),
      child: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CourseLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is CourseLoadedState) {
            return Text(state.course.name);
          } else if (state is CourseErrorState) {
            return Text(state.error);
          }

          return Container();
        },

        // child: Scaffold(
        //   body: Center(child:Text('RANKING')),
        // ),
      ),
    );
  }
}
