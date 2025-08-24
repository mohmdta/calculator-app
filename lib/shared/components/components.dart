import 'package:calculator/models/buttons_m.dart';
import 'package:calculator/modules/History/cubit/cubit.dart';
import 'package:calculator/modules/home/cubit/cubit.dart';
import 'package:flutter/material.dart';

import '../utils/date_util.dart';



Widget custom_button(String value, HomeCubit cubit)=> InkWell(
  onTap: () => cubit.onBtnPressed(value),
  child: Container(
    clipBehavior: Clip.hardEdge,  
    margin: EdgeInsets.all(4),
    decoration: BoxDecoration(
       color:  [Btn.del, Btn.clr].contains(value)? Colors.blueGrey: [Btn.per,Btn.divide, Btn.multiply, Btn.divide, Btn.subtract, Btn.add, Btn.calculate].contains(value)? Colors.orange: Colors.white,
       borderRadius: BorderRadius.circular(8)
    ),
    child: Center(child: Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: [Btn.del, Btn.clr, Btn.per, Btn.multiply, Btn.divide, Btn.subtract, Btn.add, Btn.calculate].contains(value)? Colors.white:Colors.black),),
  )
  )
);

Widget historyItemBuilder({
  required Map data
})=> Container(
  padding: EdgeInsets.all(8),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(formatDateString(data['date']), style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data['equation'].length,itemBuilder: (context, i){
                      return ListTile(
                        title: Text('${data['equation'][i]['Equation']}'),
                        subtitle: Text('${data['equation'][i]['Result']}'),
                        trailing: IconButton(onPressed: (){
                           HistoryCubit.get(context).deleteOneElementInHistory(data['equation'][i]['id']);
                        }, icon: Icon(Icons.close, size: 20,)),
                      );
                    })
                  ),
    ],
  ),
);