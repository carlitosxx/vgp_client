import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vgp_cliente/constants/colors.dart';
import 'package:vgp_cliente/constants/modes.dart';
import 'package:vgp_cliente/constants/typography.dart';
import 'package:vgp_cliente/pages/courses_open/helpers/change_format_date.dart';
import 'package:vgp_cliente/pages/courses_open/models/course_open.model.dart';
import 'package:vgp_cliente/pages/courses_open/widgets/schedule.widget.dart';
import 'package:vgp_cliente/widgets/card_button.dart';

class CardListCourseOpen extends StatelessWidget {
  const CardListCourseOpen({
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
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SvgPicture.asset(
                  'assets/banners/1.svg',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    (coursesOpen.mode.name != kmodeNoMentor)
                        ? Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.primary,
                                size: 16,
                              ),
                              Text(
                                ' Mentoria por ${coursesOpen.mentor.firstName} ${coursesOpen.mentor.lastName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: kH4Size,
                                    color: Color.fromARGB(255, 129, 138, 143)),
                              ),
                            ],
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
                                    color: Color.fromARGB(255, 129, 138, 143)),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    (coursesOpen.mode.name != kmodeNoMentor)
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
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
                            ),
                          )
                        : const SizedBox(),
                    CardButtonWidget(
                      iconButton: Icons.credit_card,
                      textButton: coursesOpen.price.toString(),
                      onPressButton: () {
                        Navigator.pushNamed(context, '/pay',
                            arguments: coursesOpen);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
