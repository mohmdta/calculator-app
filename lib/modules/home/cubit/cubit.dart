import 'package:calculator/models/buttons_m.dart';
import 'package:calculator/modules/home/states/states.dart';
import 'package:calculator/shared/network/local/sqflite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_format/date_format.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit():super(HomeInitState());
  
  static HomeCubit get(context) => BlocProvider.of(context);
  
  String number1 = '';
  String operator = '';
  String number2 = '';
  var mydb = SqfliteHelper();

  sendToDB(double result){
     mydb.insert("INSERT INTO calculator_history(Date, Equation, Result)VALUES('${formatDate(DateTime.now(), [dd,' ', MM,' ', yyyy])}', '$number1$operator$number2', '=$result')");
     return;
  }


  onBtnPressed(String value){
    if(value == Btn.del){
      deleteNumber();
      return;
    }
    if(value == Btn.clr){
      cleanNumbers();
      return;
    }

    if(value == Btn.calculate){
      calculateNumbers();
      return;
    }

    if(value == Btn.per){
       convertToPer();
       return;
    }
    appendNumber(value);
    emit(HomeSetNumberState());
  }

  convertToPer(){
    if(number1.isNotEmpty && operator.isNotEmpty && number2.isNotEmpty){
       calculateNumbers();
    }
    if(operator.isNotEmpty) return;
    final number = double.parse(number1);
    number1 = "${(number/100)}";
    operator = '';
    number2 = '';
    emit(HomeChangeToPerNumberState());
  }
  calculateNumbers(){
    if(number1.isEmpty) return;
    if(operator.isEmpty) return;
    if(number2.isEmpty) return;
    
    double num1 = double.parse(number1);
    double num2 = double.parse(number2);
    switch (operator) {
      case Btn.multiply:
        sendToDB(num1 * num2);
        number1 = "${(num1 * num2)}";
      break;
      case Btn.divide:
        sendToDB(num1 / num2);
        number1 = "${(num1 / num2)}"; 
      break;
      case Btn.subtract:
        sendToDB(num1 - num2); 
        number1 = "${(num1 - num2)}";
      break;
      case Btn.add:
        sendToDB(num1 + num2);
        number1 = "${(num1 + num2)}"; 
      break;
      default:
    }
    if(number1.endsWith('.0')){
      number1 = number1.substring(0, number1.length-2);
    }
    operator = '';
    number2 = '';
    emit(HomeCalculateNumbersState());
  }
  deleteNumber(){
    if(number2.isNotEmpty){
      number2 = number2.substring(0, number2.length -1);
    }else if (operator.isNotEmpty){
      operator = '';
    }else if (number1.isNotEmpty){
      number1 = number1.substring(0,number1.length-1);
    }
    emit(HomeDeleteNumberState());
  }
  
  cleanNumbers(){
     number1 = '';
     operator = '';
     number2 = '';
     emit(HomeCleanNumbersState());
  }

  appendNumber(String value){
     
     if (value != Btn.dot && int.tryParse(value) == null){
       if(operator.isNotEmpty || number2.isNotEmpty){
          calculateNumbers();
       }
       operator = value;
    }else if(number1.isEmpty || operator.isEmpty){
       if(value == Btn.dot && number1.contains(Btn.dot)) return;
       if(value == Btn.dot && (number1.isEmpty || number1 == Btn.dot)) value = '0.';
       number1 += value;
    }else if(number2.isEmpty || operator.isNotEmpty){
       if(value == Btn.dot && number2.contains(Btn.dot)) return;
       if(value == Btn.dot && (number2.isEmpty || number2 == Btn.dot)) value = '0.';
       number2 += value;
    }
    if(number1.isEmpty && operator.isNotEmpty){
       number1 += '0';
    }
  } 
  
}