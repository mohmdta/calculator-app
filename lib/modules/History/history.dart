import 'package:calculator/modules/History/cubit/cubit.dart';
import 'package:calculator/modules/History/states/states.dart';
import 'package:calculator/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryCubit>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = HistoryCubit.get(context);
          return Scaffold(
            appBar: AppBar(
               title: Text('History'),
               actions: [
                IconButton(onPressed: (){
                  cubit.deleteAllHistory();
                }, icon: Icon(Icons.delete))
               ],
               leading: IconButton(onPressed: (){         
                   Navigator.pop(context);
                   cubit.clear();
               }, icon: Icon(Icons.arrow_back_ios_new_rounded)),
            ),
            body: ListView.builder( 
            itemCount: cubit.groupedHistory.length,itemBuilder: (context, i)=> historyItemBuilder(data: cubit.groupedHistory[i])),
          );
        },
      );
    
  }
}
