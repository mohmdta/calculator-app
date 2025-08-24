import 'package:calculator/modules/History/states/states.dart';
import 'package:calculator/shared/network/local/sqflite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class HistoryCubit extends Cubit<HistoryStates>{
  HistoryCubit():super(HistoryInitState());
  static HistoryCubit get(context)=> BlocProvider.of(context);
  SqfliteHelper mydb = SqfliteHelper();
  List<Map> groupedHistory = [];

  getData()async{
     List<Map> data = await mydb.readData('SELECT * FROM calculator_history');
     bool found = false;
     for(var item in data){
       for(var item2 in groupedHistory){
         if(item['Date'] == item2['date']){
            found = true;
            item2['equation'].insert(0,item);
            break;
         }else{
           found = false;
         }
       }
       if(!found){
         groupedHistory.add({
              "date":item['Date'],
              "equation":[item]
         });
       }
     }
     print(groupedHistory);
     emit(HistoryGetDataState());
  }
  deleteAllHistory()async{
    if(groupedHistory.isNotEmpty){
       await mydb.delete('DELETE FROM calculator_history');
       clear();
       playRemoveSound();
    }
    emit(HistoryDeleteAllHistoryState());
  }
  deleteOneElementInHistory(int id)async{
    await mydb.delete('DELETE FROM calculator_history WHERE id = $id');
    for(var item in groupedHistory){
      item['equation'].removeWhere((eq)=> eq['id']==id);
    }
    groupedHistory.removeWhere((item)=> item['equation'].isEmpty);
    emit(HistoryDeleteOneElementInHistoryState());
  }
  clear(){
    groupedHistory = [];
    emit(HistoryClearDataState());
  }
  playRemoveSound()async{
    final player = AudioPlayer();
    await player.setAsset('assets/audio/remove.mp3');
    await player.play();
  }
}