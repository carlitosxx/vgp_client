import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgp_cliente/pages/courses_open/bloc/courses_open_bloc.dart';
import 'package:vgp_cliente/pages/courses_open/models/course_open.model.dart';
import 'package:vgp_cliente/pages/courses_open/repositories/courses_open.repository.dart';
class CoursesOpenPage extends StatelessWidget {
  final String categoryId;
  const CoursesOpenPage({super.key,required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final kSize= MediaQuery.of(context).size;
    final ancho=kSize.width;
    print(kSize);
    return Scaffold(      
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('Cursos'),),
          BlocProvider(
            create: (context)=>CoursesOpenBloc(CoursesOpenRepository())
            ..add(LoadCoursesOpenEvent(categoryId)),
            child: BlocBuilder<CoursesOpenBloc,CoursesOpenState>(
              builder: (context,state){
                if(state is CoursesOpenLoadingState){
                  return  const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(child: CircularProgressIndicator()),
                    );    
                }
                if(state is CoursesOpenLoadedState){                  
                  List<CourseOpen> listCoursesOpen=state.listCoursesOpen;
                  //todo:Generacion de plantilla de cursos abiertos
                  List<Widget> items= List.generate(listCoursesOpen.length,(i)=>ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Banner(                      
                      location: BannerLocation.topEnd,
                      color: (listCoursesOpen[i].mode.name=='sin mentor')
                      ?Theme.of(context).colorScheme.secondary
                      :Theme.of(context).colorScheme.tertiary,
                      message: listCoursesOpen[i].mode.name,
                      child: Container(                      
                        decoration:BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius:BorderRadius.circular(15),
                        ) ,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (listCoursesOpen[i].course.image != null) Image.network(listCoursesOpen[i].course.image) 
                            else const Flexible(
                                  flex: 38,
                                  fit: FlexFit.loose,                              
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      topLeft: Radius.circular(15)),
                                    child: FadeInImage(
                                      image: NetworkImage('https://i.pinimg.com/originals/15/e1/8e/15e18e1aa97f2195e5e715268cce6dfe.jpg'), placeholder: AssetImage('assets/placeholders/864x1280.png'),)
                                  )
                              ),
                              Flexible(
                                flex:63,   
                                fit:FlexFit.tight,                             
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column( 
                                    mainAxisAlignment: MainAxisAlignment.center,                                                 
                                    children: [
                                      AutoSizeText(listCoursesOpen[i].course.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontWeight: FontWeight.bold),                            
                                      ),
                                      AutoSizeText(                                        
                                        listCoursesOpen[i].course.description,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,                                        
                                      ),                                      
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: double.infinity, 
                                              child: ElevatedButton(
                                                style: TextButton.styleFrom(                                                 
                                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15)
                                                  )
                                                ),
                                                onPressed: (){
                                                  print(listCoursesOpen[i].id);
                                                },
                                                child:Text('Comprar S/ ${listCoursesOpen[i].price}',
                                                    style: const TextStyle(fontSize: 16,color: Colors.white),
                                                  ),
                                              )
                                            ),
                                          ],
                                        ),
                                      )                       
                                    ],
                                  ),
                                ),
                              ),
                          ],
                          ),
                        ),
                     ),
                  )
                  );
                  return SliverPadding(
                      padding: const EdgeInsets.all(10),
                      sliver: 
                      SliverGrid.count(       
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,       
                        crossAxisCount:(ancho<600)?1:2,
                        childAspectRatio: 1.8,
                        children:items,
                    )
                    );
                }
                return Container();
              }
            ),
          )
        ],
      ),
    );
  }
}