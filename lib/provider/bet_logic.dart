import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BetLogic extends ChangeNotifier {
  BetLogic() {
    getData();
  }
  int selectORNot = 0;
  SharedPreferences? prefs;
  TextEditingController betController = TextEditingController();
  double glasses = 1000;
  double coefficientResult = 0;
  double winForecastCoefficient = 0;
  double winForecast = 0;
  double yourWinnings = 0;
  double lostPoints = 0;
  Color colorInput = const Color.fromARGB(255, 181, 194, 216);
  double bet = 0;
  bool betPermission = false;
  List<Map<String, dynamic>> listMoutch = [];
  List<Map<String, dynamic>> listData = [
    {
      "team": ["Napoli", "Liverpool"],
      "coefficient": [
        ["4.5", 0, "N1"],
        ["1.8", 0, "D"],
        ["1.4", 0, "N2"],
      ],
    },
    {
      "team": ["Sporting", "Porto"],
      'coefficient': [
        ["1.8", 0, "N1"],
        ["3", 0, "D"],
        ["4.5", 0, "N2"],
      ],
    },
    {
      'team': ['PSG', 'Barcelona'],
      'coefficient': [
        ['2', 0, 'N1'],
        ['5.5', 0, 'D'],
        ['4', 0, 'N2'],
      ],
    },
    {
      'team': ['Juventus', 'Real Madrid'],
      'coefficient': [
        ['2.8', 0, 'N1'],
        ['8.3', 0, 'D'],
        ['1.6', 0, 'N2'],
      ],
    },
    {
      'team': ['Man Utd', 'Man City'],
      'coefficient': [
        ['1.3', 0, 'N1'],
        ['7.3', 0, 'D'],
        ['9', 0, 'N2'],
      ],
    },
    {
      'team': ['Dortmund', 'Bayern Munich'],
      'coefficient': [
        ['5.3', 0, 'N1'],
        ['2.1', 0, 'D'],
        ['1.6', 0, 'N2'],
      ],
    },
    {
      'team': ['Barcelona', 'Real Madrid'],
      'coefficient': [
        ['1.8', 0, 'N1'],
        ['13', 0, 'D'],
        ['2.3', 0, 'N2'],
      ],
    },
    {
      'team': ['Milan', 'Inter'],
      'coefficient': [
        ['1.6', 0, 'N1'],
        ['3.6', 0, 'D'],
        ['3.3', 0, 'N2'],
      ],
    },
    {
      'team': ['Man Utd', 'Bayern Munich'],
      'coefficient': [
        ['1.3', 0, 'N1'],
        ['6.9', 0, 'D'],
        ['5.3', 0, 'N2'],
      ],
    },
    {
      'team': ['Marsell', 'PSG'],
      'coefficient': [
        ['1.9', 0, 'N1'],
        ['3.1', 0, 'D'],
        ['5.6', 0, 'N2'],
      ],
    },
    {
      'team': ['Atletico M', 'Real Madrid'],
      'coefficient': [
        ['2.6', 0, 'N1'],
        ['3.6', 0, 'D'],
        ['1.3', 0, 'N2'],
      ],
    },
  ];
  void sellectCoefficient(
      int indexTabl, int howCoof, int howDeleteOne, int howDeleteTwo) {
    if (listData[indexTabl]['coefficient'][howCoof][1] == 1) {
      listData[indexTabl]['coefficient'][howCoof][1] = 0;
    } else {
      listData[indexTabl]['coefficient'][howCoof][1] = 1;
      listData[indexTabl]['coefficient'][howDeleteOne][1] = 0;
      listData[indexTabl]['coefficient'][howDeleteTwo][1] = 0;
    }

    notifyListeners();
  }

  int doubleInRange(Random source, num start, num end) {
    var rng = Random();
    int randomResult = rng.nextInt(6);
    if (randomResult == 0) {
      randomResult += 1;
    }
    return randomResult;
  }

  void coefficientcalCulationLogic(int result, BuildContext context) {
    winForecast = 0;
    int randomNumOne = doubleInRange(Random(), 1, 10);
    int randomNumTwo = doubleInRange(Random(), 1, 10);
    winForecastCoefficient = 0;

    colorInput = const Color.fromARGB(255, 181, 194, 216);
    bool numberValidation = RegExp(r'^[0-9]+$').hasMatch(betController.text);
    listData.forEach((element) {
      (element['coefficient'] as List).forEach((element) {
        if (element[1] == 1) {
          betPermission = true;
          return;
        }
      });
    });
    if (betPermission) {
      if (numberValidation && betController.text.isNotEmpty) {
        for (var element in listData) {
          for (var elementCoefficient in (element['coefficient'] as List)) {
            if (result == 1 && elementCoefficient[1] == 1) {
              if (winForecastCoefficient == 0) {
                winForecastCoefficient = double.parse(elementCoefficient[0]);
              } else {
                winForecastCoefficient = winForecastCoefficient *
                    double.parse(elementCoefficient[0]);
              }
            }
            if (result == 0) {
              if (randomNumOne > randomNumTwo) {
                if (elementCoefficient[1] == 1 &&
                    elementCoefficient[2] != 'N1') {
                  if (glasses > double.parse(betController.text)) {
                    glasses = glasses - double.parse(betController.text);
                    lostPoints = double.parse(betController.text);
                    _showMyDialogLoss(context);
                  }
                  return;
                }
                if (elementCoefficient[1] == 1 &&
                    elementCoefficient[2] == 'N1') {
                  if (coefficientResult == 0) {
                    coefficientResult = double.parse(elementCoefficient[0]);
                  } else {
                    coefficientResult =
                        coefficientResult * double.parse(elementCoefficient[0]);
                  }
                }
                listMoutch.add({
                  'score': '$randomNumOne - $randomNumOne',
                  'teams': '${element['team'][0]} - ${element['team'][1]}'
                });
              } else if (randomNumOne == randomNumTwo) {
                if (elementCoefficient[1] == 1 &&
                    elementCoefficient[2] != 'D') {
                  if (glasses > double.parse(betController.text)) {
                    glasses = glasses - double.parse(betController.text);
                    lostPoints = double.parse(betController.text);
                    _showMyDialogLoss(context);
                  }
                  return;
                }
                if (elementCoefficient[1] == 1 &&
                    elementCoefficient[2] == 'D') {
                  if (coefficientResult == 0) {
                    coefficientResult = double.parse(elementCoefficient[0]);
                  } else {
                    coefficientResult =
                        coefficientResult * double.parse(elementCoefficient[0]);
                  }
                }
                listMoutch.add({
                  'score': '$randomNumOne - $randomNumOne',
                  'teams': '${element['team'][0]} - ${element['team'][1]}'
                });
              } else if (randomNumOne < randomNumTwo) {
                if (elementCoefficient[1] == 1 &&
                    elementCoefficient[2] != 'N2') {
                  if (glasses > double.parse(betController.text)) {
                    glasses = glasses - double.parse(betController.text);
                    lostPoints = double.parse(betController.text);
                    _showMyDialogLoss(context);
                  }
                  return;
                }
                if (elementCoefficient[1] == 1 &&
                    elementCoefficient[2] == 'N2') {
                  if (coefficientResult == 0) {
                    coefficientResult = double.parse(elementCoefficient[0]);
                  } else {
                    coefficientResult =
                        coefficientResult * double.parse(elementCoefficient[0]);
                  }
                }
                listMoutch.add({
                  'score': '$randomNumOne - $randomNumOne',
                  'teams': '${element['team'][0]} - ${element['team'][1]}'
                });
              }
            }
          }
        }
        if (coefficientResult != 0 && result == 0) {
          if (result == 0) {
            yourWinnings = coefficientResult * double.parse(betController.text);
            glasses = glasses +
                (coefficientResult * double.parse(betController.text));

            listData = [
              {
                'team': ['Napoli', 'Liverpool'],
                'coefficient': [
                  ['4.5', 0, 'N1'],
                  ['1.8', 0, 'D'],
                  ['1.4', 0, 'N2'],
                ],
              },
              {
                'team': ['Sporting', 'Porto'],
                'coefficient': [
                  ['1.8', 0, 'N1'],
                  ['3', 0, 'D'],
                  ['4.5', 0, 'N2'],
                ],
              },
              {
                'team': ['PSG', 'Barcelona'],
                'coefficient': [
                  ['2', 0, 'N1'],
                  ['5.5', 0, 'D'],
                  ['4', 0, 'N2'],
                ],
              },
              {
                'team': ['Juventus', 'Real Madrid'],
                'coefficient': [
                  ['2.8', 0, 'N1'],
                  ['8.3', 0, 'D'],
                  ['1.6', 0, 'N2'],
                ],
              },
              {
                'team': ['Man Utd', 'Man City'],
                'coefficient': [
                  ['1.3', 0, 'N1'],
                  ['7.3', 0, 'D'],
                  ['9', 0, 'N2'],
                ],
              },
              {
                'team': ['Dortmund', 'Bayern Munich'],
                'coefficient': [
                  ['5.3', 0, 'N1'],
                  ['2.1', 0, 'D'],
                  ['1.6', 0, 'N2'],
                ],
              },
              {
                'team': ['Barcelona', 'Real Madrid'],
                'coefficient': [
                  ['1.8', 0, 'N1'],
                  ['13', 0, 'D'],
                  ['2.3', 0, 'N2'],
                ],
              },
              {
                'team': ['Milan', 'Inter'],
                'coefficient': [
                  ['1.6', 0, 'N1'],
                  ['3.6', 0, 'D'],
                  ['3.3', 0, 'N2'],
                ],
              },
              {
                'team': ['Man Utd', 'Bayern Munich'],
                'coefficient': [
                  ['1.3', 0, 'N1'],
                  ['6.9', 0, 'D'],
                  ['5.3', 0, 'N2'],
                ],
              },
              {
                'team': ['Marsell', 'PSG'],
                'coefficient': [
                  ['1.9', 0, 'N1'],
                  ['3.1', 0, 'D'],
                  ['5.6', 0, 'N2'],
                ],
              },
              {
                'team': ['Atletico M', 'Real Madrid'],
                'coefficient': [
                  ['2.6', 0, 'N1'],
                  ['3.6', 0, 'D'],
                  ['1.3', 0, 'N2'],
                ],
              },
            ];
          }
          coefficientResult = 0;
          _showMyDialog(context);
          saveData(glasses);
        } else if (result == 0) {
          if (glasses > double.parse(betController.text)) {
            glasses = glasses - double.parse(betController.text);
            lostPoints = double.parse(betController.text);
            _showMyDialogLoss(context);
          }
        }
        if (winForecastCoefficient != 0 && result == 1) {
          winForecast = winForecast +
              (winForecastCoefficient * double.parse(betController.text));
        }
        if (result == 0) {
          betController.clear();
        }
      } else {
        colorInput = Colors.red;
      }
    }

    notifyListeners();
  }

  void saveData(double data) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setDouble('dataKey', data);
  }

  Future<void> getData() async {
    prefs = await SharedPreferences.getInstance();
    glasses = prefs!.getDouble('dataKey') ?? 1000;
    notifyListeners();
  }

  Future<void> deleteData() async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setDouble('dataKey', 1000);
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations you are win'),
          content: Text('Your winnings ${yourWinnings.toStringAsFixed(1)}'),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogLoss(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unfortunately you lost'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('you lost $lostPoints points'),
                Text('your total ${glasses.toStringAsFixed(1)} points'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
