import 'package:flutter/material.dart';

class FlashCardsView extends StatefulWidget {
  const FlashCardsView({super.key});

  @override
  State<FlashCardsView> createState() => _FlashCardsViewState();
}

class _FlashCardsViewState extends State<FlashCardsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 280,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.8),
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                // shape: BoxShape.circle
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                              child: Text('${index + 1}'),
                            )),
                        const SizedBox(width: 5),
                        const Text(
                          'Titulo de la clase',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Text(
                        'Descripcion de prueba, esto es una prueba de la descripcion, sigamos escribiendo hasta completar 3 lineas weeeeepa ',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Expanded(
                          flex: 50,
                          child: LinearProgressIndicator(
                            value: 0.333333333333333,
                            color: Colors.green,
                            backgroundColor: Colors.white24,
                          ),
                          // child: Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10),
                          //     color: Theme.of(context).colorScheme.background,
                          //   ),
                          //   padding:const EdgeInsets.all(6),

                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       ColorFiltered(
                          //          colorFilter: const ColorFilter.matrix([
                          //           0.2126,0.7152,0.0722,0,0,0.2126,0.7152,
                          //           0.0722,0,0,0.2126,0.7152,0.0722,0,0,0,
                          //           0,0,1,0,
                          //         ]),
                          //         child: SvgPicture.asset(gemaRojo,width: 25,)),
                          //       ColorFiltered(
                          //         colorFilter: const ColorFilter.matrix([
                          //           0.2126,0.7152,0.0722,0,0,0.2126,0.7152,
                          //           0.0722,0,0,0.2126,0.7152,0.0722,0,0,0,
                          //           0,0,1,0,
                          //         ]),
                          //         child: SvgPicture.asset(gemaAzul,width: 25,)),
                          //       ColorFiltered(
                          //         colorFilter: const ColorFilter.matrix([
                          //           0.2126,0.7152,0.0722,0,0,0.2126,0.7152,
                          //           0.0722,0,0,0.2126,0.7152,0.0722,0,0,0,
                          //           0,0,1,0,
                          //         ]),
                          //         child: SvgPicture.asset(gemaVerde,width: 25,)),
                          //   ],),
                          // )
                        ),
                        Expanded(
                            flex: 50,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      // shape: BoxShape.circle
                                      borderRadius: BorderRadius.circular(100)),
                                  child: const Center(
                                    child: Icon(
                                      Icons.lock,
                                      size: 15,
                                    ),
                                  )),
                            )),
                      ],
                    )
                  ],
                ),
              );
            }, childCount: 100),
          ),
        ],
      ),
      // Center(child: Text('FLASHCARDS')),
    );
  }
}
