import 'package:betting/components/items_widget.dart';
import 'package:betting/provider/bet_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BetLogic betLogic = context.watch<BetLogic>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(betLogic.glasses.toStringAsFixed(1)),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: betLogic.listData.length,
                itemBuilder: ((context, index) {
                  return ItemWidget(
                    betLogic: betLogic,
                    index: index,
                  );
                }),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                height: 170,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text('Possible win'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(betLogic.winForecast.toStringAsFixed(1)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (inputValue) {
                        betLogic.coefficientcalCulationLogic(1, context);
                      },
                      controller: betLogic.betController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: betLogic.colorInput,
                          ),
                        ),
                        labelText: 'Bet',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        betLogic.coefficientcalCulationLogic(0, context);
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 45,
                          vertical: 15,
                        ),
                        color: const Color(0xff3c5782),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
