import 'package:flutter/material.dart';
import 'package:vgp_cliente/constants/typography.dart';
import 'package:vgp_cliente/pages/courses_open/helpers/get_day_by_number.dart';

import '../models/course_open.model.dart';

class ScheduleWidget extends StatelessWidget {
  final List<ScheduleDetail> listScheduleDetail;
  const ScheduleWidget({super.key,required this.listScheduleDetail});

  @override
  Widget build(BuildContext context) {
    listScheduleDetail.sort((a,b) => a.day.compareTo(b.day));    
    List<Widget> items=List.generate(listScheduleDetail.length,(i) => 
      Column(
        children: [
          Text(getDayByNumber(listScheduleDetail[i].day),style: const TextStyle(fontWeight: FontWeight.bold),),
          Container(
            padding: const EdgeInsets.symmetric(horizontal:2),
            decoration:BoxDecoration(              
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              borderRadius:BorderRadius.circular(5),
            ),
            child: Column(
              children: [                                                         
                Text(listScheduleDetail[i].timeIn.substring(0,5),
                style: const TextStyle(                  
                  fontSize: kH5Size)),
                Text(listScheduleDetail[i].timeOut.substring(0,5),
                style: const TextStyle(                 
                  fontSize: kH5Size))  
              ],
            ),  
          ),
        ],
      )
    );
    return Container(
      padding: const EdgeInsets.only(bottom:7.0),
      margin: const EdgeInsets.only(bottom:10),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(5),
        // color:Color.fromARGB(255, 29, 40, 46),       
      ),  
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items,),
    );
  }
}
