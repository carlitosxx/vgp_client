import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgp_cliente/constants/colors.dart';
import 'package:vgp_cliente/constants/modes.dart';
import 'package:vgp_cliente/constants/typography.dart';
import 'package:vgp_cliente/pages/courses_open/helpers/change_format_date.dart';
import 'package:vgp_cliente/pages/courses_open/models/course_open.model.dart';
import 'package:vgp_cliente/pages/courses_open/widgets/schedule.widget.dart';
import 'package:vgp_cliente/widgets/card_button.dart';

class CardGridCourseOpenWidget extends StatelessWidget {
  const CardGridCourseOpenWidget({
    super.key,
    required this.coursesOpen,
  });
  final CourseOpen coursesOpen;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Banner(
        location: BannerLocation.topEnd,
        color: (coursesOpen.mode.name == kmodeNoMentor)
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.tertiary,
        message: coursesOpen.mode.name,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 20,
                  fit: FlexFit.loose,
                  child: LayoutBuilder(
                    builder: (context, constraint) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: SvgPicture.asset(
                          'assets/banners/1.svg',
                          fit: BoxFit.fitWidth,
                          height: constraint.maxHeight,
                        ),
                      );
                    },
                  )),
              Flexible(
                flex: 80,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      (coursesOpen.mode.name != kmodeNoMentor)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Mentoria por ${coursesOpen.mentor.firstName} ${coursesOpen.mentor.lastName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: kH4Size,
                                    color: Color.fromARGB(255, 129, 138, 143)),
                              ),
                            )
                          : const SizedBox(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            coursesOpen.course.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: kH2Color, fontSize: kH2Size),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          coursesOpen.course.description,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      (coursesOpen.hasDuration)
                          ? ScheduleWidget(
                              listScheduleDetail:
                                  coursesOpen.schedule.scheduleDetail)
                          : const SizedBox(),
                      (coursesOpen.hasDuration)
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ' ${changeFormatDate(coursesOpen.courseStart.toString().substring(0, 10))} al ${changeFormatDate(coursesOpen.courseEnd.toString().substring(0, 10))}',
                                    style: const TextStyle(
                                        fontSize: kH4Size,
                                        color:
                                            Color.fromARGB(255, 129, 138, 143)),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      (coursesOpen.mode.name != kmodeNoMentor)
                          ? Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 16,
                                ),
                                Text(
                                  ' ${coursesOpen.office.address}-${coursesOpen.office.district.name}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: kH4Size,
                                      color:
                                          Color.fromARGB(255, 129, 138, 143)),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      (coursesOpen.mode.name != kmodeNoMentor)
                          ? Row(
                              children: [
                                Icon(
                                  Icons.groups,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 16,
                                ),
                                Text(
                                  ' ${coursesOpen.slot} alumnos',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: kH4Size,
                                      color:
                                          Color.fromARGB(255, 129, 138, 143)),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      Expanded(
                          child: CardButtonWidget(
                              iconButton: Icons.credit_card,
                              onPressButton: () {
                                Navigator.pushNamed(context, '/pay',
                                    arguments: coursesOpen);
                              },
                              textButton: coursesOpen.price.toString()))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
