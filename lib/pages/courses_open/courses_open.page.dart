import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgp_cliente/pages/courses_open/bloc/courses_open_bloc.dart';
import 'package:vgp_cliente/pages/courses_open/models/course_open.model.dart';
import 'package:vgp_cliente/pages/courses_open/repositories/courses_open.repository.dart';
import 'package:vgp_cliente/pages/courses_open/widgets/cardgrid_course_open.dart';
import 'package:vgp_cliente/pages/courses_open/widgets/cardlist_course_open.dart';
import 'package:vgp_cliente/app/presentation/responsive/grid.responsive.dart';

class CoursesOpenPage extends StatelessWidget {
  final String categoryId;
  const CoursesOpenPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    print(categoryId);
    final maxWidh = kSize.width;
    print(kSize);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Cursos'),
          ),
          BlocProvider(
            create: (context) => CoursesOpenBloc(CoursesOpenRepository())
              ..add(LoadCoursesOpenEvent(categoryId)),
            child: BlocBuilder<CoursesOpenBloc, CoursesOpenState>(
                builder: (context, state) {
              if (state is CoursesOpenLoadingState) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is CoursesOpenLoadedState) {
                List<CourseOpen> listCoursesOpen = state.listCoursesOpen;
                List<Widget> items = listCoursesOpen.map((e) {
                  return CardGridCourseOpenWidget(coursesOpen: e);
                }).toList();
                return SliverPadding(
                    padding: const EdgeInsets.all(10),
                    sliver: (maxWidh < 599)
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate((context, i) {
                            return CardListCourseOpen(
                                coursesOpen: listCoursesOpen[i]);
                          }, childCount: listCoursesOpen.length))
                        : SliverGrid.count(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: gridCrossAxisCount(maxWidh),
                            childAspectRatio: gridAspectRatio(maxWidh),
                            children: items,
                          ));
              }
              if (state is CoursesOpenErrorState) {
                SliverToBoxAdapter(
                  child: Text(state.error),
                );
              }
              return const SliverToBoxAdapter();
            }),
          )
        ],
      ),
    );
  }
}
