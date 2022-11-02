import 'package:betting/provider/bet_logic.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemWidget extends StatelessWidget {
  ItemWidget({super.key, required this.betLogic, required this.index});
  BetLogic betLogic;
  int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(167, 245, 243, 241),
      margin: const EdgeInsets.only(top: 15),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Container(
            color: const Color(0xff3c5782),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Text(
                    '${betLogic.listData[index]['team'][0]} - ${betLogic.listData[index]['team'][1]}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 228, 233, 204),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  betLogic.sellectCoefficient(index, 0, 1, 2);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 2,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                  ),
                  color: betLogic.listData[index]['coefficient'][0][1] == 0
                      ? const Color(0xff95a9c9)
                      : const Color.fromARGB(255, 18, 59, 124),
                  child: Text(
                    'N1) ${betLogic.listData[index]['coefficient'][0][0]}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 228, 233, 204),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  betLogic.sellectCoefficient(index, 1, 0, 2);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 2,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                  ),
                  color: betLogic.listData[index]['coefficient'][1][1] == 0
                      ? const Color(0xff95a9c9)
                      : const Color.fromARGB(255, 18, 59, 124),
                  child: Text(
                    'D) ${betLogic.listData[index]['coefficient'][1][0]}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 228, 233, 204),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  betLogic.sellectCoefficient(index, 2, 0, 1);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 2,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                  ),
                  color: betLogic.listData[index]['coefficient'][2][1] == 0
                      ? const Color(0xff95a9c9)
                      : const Color.fromARGB(255, 18, 59, 124),
                  child: Text(
                    'N2) ${betLogic.listData[index]['coefficient'][2][0]}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 228, 233, 204),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
