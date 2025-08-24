import 'package:calculator/models/buttons_m.dart';
import 'package:calculator/modules/home/cubit/cubit.dart';
import 'package:calculator/modules/home/states/states.dart';
import 'package:calculator/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pushNamed(context, '/history');
                    }, icon: Icon(Icons.history, size: 30,))
                  ],
                ),
                // container
                Expanded(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.all(16),
                      child: Text(
                       "${cubit.number1}${cubit.operator}${cubit.number2}".isEmpty ? "0":"${cubit.number1}${cubit.operator}${cubit.number2}",
                        style: TextStyle(
                          fontSize: (cubit.number1.length > 10) || (cubit.number2.length > 10)? 30:48,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ),
                // buttons
                Wrap(
                  children: Btn.buttonValues
                      .map(
                        (value) => SizedBox(
                          width: value == Btn.n0
                              ? (size.width / 2)
                              : (size.width / 4),
                          height: size.width / 5,
                          child: custom_button(value, cubit),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
