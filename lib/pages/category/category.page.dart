import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vgp_cliente/pages/category/bloc/category/category_bloc.dart';
import 'package:vgp_cliente/pages/category/models/category.model.dart';
import 'package:vgp_cliente/pages/category/repositories/category.repository.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    final ancho = kSize.width;
    return SafeArea(
      child: Scaffold(
          body: BlocProvider(
        create: (context) =>
            CategoryBloc(CategoryRepository())..add(LoadCategoryEvent()),
        child:
            BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
          if (state is CategoryLoadingState) {
            return const CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text('Seleccione un categoria'),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                )
              ],
            );
          }
          if (state is CategoryLoadedState) {
            List<Category> listCategory = state.listCategory['data'];
            String urlHost = state.listCategory['url_host'];
            print(urlHost);
            //todo:Generacion de la plantilla de categoria
            List<Widget> items = List.generate(
                listCategory.length,
                (i) => InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        Navigator.of(context).pushNamed("/course-open",
                            arguments: listCategory[i].id);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onBackground,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FittedBox(
                              child: AutoSizeText(
                                listCategory[i].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            LayoutBuilder(builder: (context, constraint) {
                              return SvgPicture.network(
                                urlHost + listCategory[i].image,
                                width: constraint.maxWidth * 0.60,
                              );
                            }),
                          ],
                        ),
                      ),
                    ));
            //todo: recortar la lista creada en el children el grid
            return CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text('Seleccione un categoria'),
                ),
                SliverPadding(
                    padding: const EdgeInsets.all(10),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: (ancho > 450) ? 3 : 2,
                      childAspectRatio: 1,
                      children: items,
                    ))
              ],
            );
          }
          if (state is CategoryErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        }),
      )),
    );
  }
}
