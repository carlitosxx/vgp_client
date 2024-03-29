import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgp_cliente/app/core/utils/set-level-by-experience.util.dart';
import 'package:vgp_cliente/app/presentation/pages/home/blocs/user_experience/user_experience.bloc.dart';
import 'package:vgp_cliente/app/presentation/pages/home/views/exam.view.dart';
import 'package:vgp_cliente/app/presentation/pages/home/views/flashcards.view.dart';
import 'package:vgp_cliente/app/presentation/pages/home/views/lesson_list.view.dart';
import 'package:vgp_cliente/app/presentation/pages/home/views/notes.view.dart';
import 'package:vgp_cliente/app/presentation/pages/home/views/ranking.view.dart';
import 'package:vgp_cliente/app/presentation/pages/home/widgets/myappbar.dart';
import 'package:vgp_cliente/app/presentation/pages/login/blocs/login/login_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<bool> _activated = List<bool>.filled(5, false);
  int currentTab = 0;
  // final List<Widget> screens = const [
  //   LessonListView(),
  //   FlashCardsView(),
  //   RankingView(),
  //   ExamenView(),
  //   NotesView(),
  // ];
  // Widget currentScreen = const LessonListView();
  // final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    // mark this index as activated
    _activated[currentTab] = true;

    const String homeIcon = 'assets/icons/home.svg';
    const String flascardsIcon = 'assets/icons/flashcards.svg';
    const String ranking = 'assets/icons/ranking.svg';
    const String examen = 'assets/icons/examen.svg';
    const String notes = 'assets/icons/notes.svg';
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: const MyAppBar(),
            drawer: const BuiltDraw(),
            body: IndexedStack(
              index: currentTab,
              children: [
                _activated[0]
                    ? const LessonListView()
                    : const SizedBox.shrink(),
                _activated[1]
                    ? const FlashCardsView()
                    : const SizedBox.shrink(),
                _activated[2] ? const RankingView() : const SizedBox.shrink(),
                _activated[3] ? const ExamenView() : const SizedBox.shrink(),
                _activated[4] ? const NotesView() : const SizedBox.shrink()
              ],
            ),
            // PageStorage(bucket: bucket, child: currentScreen),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).colorScheme.surface,
                    width: 2.0,
                  ),
                ),
              ),
              child: BottomAppBar(
                surfaceTintColor: Theme.of(context).colorScheme.background,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            // currentScreen = const LessonListView();
                            currentTab = 0;
                          });
                        },
                        child: SvgPicture.asset(
                          homeIcon,
                          // width: 50,
                        ),
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            // currentScreen = const FlashCardsView();
                            currentTab = 1;
                          });
                        },
                        child: SvgPicture.asset(
                          flascardsIcon,
                          // width: 45
                        ),
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            // currentScreen = const RankingView();
                            currentTab = 2;
                          });
                        },
                        child: SvgPicture.asset(
                          ranking,
                          //  width: 50
                        ),
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            // currentScreen = const ExamenView();
                            currentTab = 3;
                          });
                        },
                        child: SvgPicture.asset(
                          examen,
                          //  width: 40
                        ),
                      ),
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            // currentScreen = const NotesView();
                            currentTab = 4;
                          });
                        },
                        child: SvgPicture.asset(
                          notes,
                          //  width: 50
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BuiltDraw extends StatelessWidget {
  const BuiltDraw({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: BlocBuilder<UserExperienceBloc, UserExperienceState>(
          builder: (context, state) {
            if (state is UserExperienceLoadedState) {
              return Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: setLevelByExperience(
                          state.userExperience.experience)),
                  Text(
                      '${state.userExperience.firstName} ${state.userExperience.lastName}'),
                  Divider(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.credit_score,
                    ),
                    title: const Text('Pruebas'),
                    onTap: () async {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.credit_score,
                    ),
                    title: const Text('Comprar cursos'),
                    onTap: () async {
                      Navigator.of(context).pushNamed("/category");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Cerrar sesión'),
                    onTap: () async {
                      const storage = FlutterSecureStorage();
                      await storage.deleteAll();
                      await storage.delete(key: 'token');

                      if (context.mounted) {
                        context.read<LoginBloc>().add(SetLoginInitialEvent());
                        Navigator.of(context).pushReplacementNamed("/login");
                      }
                    },
                  ),
                ],
              );
            } else if (state is UserExperienceErrorState) {
              return Text(state.error);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
