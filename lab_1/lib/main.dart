import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
  home: Lab1V3(),
));

class Lab1V3 extends StatefulWidget {
  const Lab1V3({super.key});

  @override
  _Lab1PanelState createState() => _Lab1PanelState();
}

class _Lab1PanelState extends State<Lab1V3> {
  Color BackgroundColor = Color(0xFFD1D9E5);
  Color Header = Color(0x7377868F);
  Color ColorBackM = Color(0xFF007BFF);
  Color ColorBackF = Color(0xFFFFFFFF);
  Color ColorTextM = Colors.white;
  Color ColorTextF = Color(0xFF007BFF);
  int weight = 70;
  int age = 22;
  bool SelectM = true;
  double IMC = 0;
  String formattedImc = "0";
  String raspuns = "";
  double height = 0;

  void Calculate(double height, int weight) {
    if (height > 0) {
      height /= 100;
      IMC = weight / (height * height);
      formattedImc = IMC.toStringAsFixed(2);
    }
  }

  String getIMCInterpretation(double bmi, int age, bool esteBarbat) {
    if (age >= 18) {
      if (bmi < 18.5) {
        return "Subponderal";
      } else if (bmi >= 18.5 && bmi < 25) {
        return "Greutate normală";
      } else if (bmi >= 25 && bmi < 30) {
        return "Supraponderal";
      } else if (bmi >= 30 && bmi < 35) {
        return "Obezitate clasa I";
      } else if (bmi >= 35 && bmi < 40) {
        return "Obezitate clasa II";
      } else {
        return "Obezitate clasa III";
      }
    } else {
      if (esteBarbat) {
        if (bmi < 5) {
          return "Subponderal sever";
        } else if (bmi >= 5 && bmi < 15) {
          return "Subponderal";
        } else if (bmi >= 15 && bmi < 85) {
          return "Greutate normală";
        } else if (bmi >= 85 && bmi < 95) {
          return "Supraponderal";
        } else {
          return "Obezitate";
        }
      } else {
        if (bmi < 5) {
          return "Subponderal sever";
        } else if (bmi >= 5 && bmi < 15) {
          return "Subponderal";
        } else if (bmi >= 15 && bmi < 85) {
          return "Greutate normală";
        } else if (bmi >= 85 && bmi < 95) {
          return "Supraponderal";
        } else {
          return "Obezitate";
        }
      }
    }
  }

  void UpdateColors() {
    if (SelectM) {
      ColorBackM = Color(0xFF007BFF);
      ColorTextM = Colors.white;
      ColorTextF = Color(0xFF007BFF);
      ColorBackF = Colors.white;
    } else {
      ColorBackF = Color(0xFF007BFF);
      ColorTextF = Colors.white;
      ColorTextM = Color(0xFF007BFF);
      ColorBackM = Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 100),
                        child: Text(
                          "Welcome😊",
                          style: TextStyle(
                            fontFamily: 'Arial',
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "BMI Calculator",
                          style: TextStyle(
                            fontFamily: 'Verdana',
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      SelectM = true;
                      UpdateColors();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 23),
                    backgroundColor: ColorBackM,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(
                    Icons.male,
                    color: ColorTextM,
                    size: 18,
                  ),
                  label: Text(
                    "Male  ",
                    style: TextStyle(
                      color: ColorTextM,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      SelectM = false;
                      UpdateColors();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    backgroundColor: ColorBackF,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(
                    Icons.female,
                    color: ColorTextF,
                    size: 18,
                  ),
                  label: Text(
                    "Female",
                    style: TextStyle(
                      color: ColorTextF,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 30, right: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFFFFFFF),
              ),
              child: Column(
                children: [
                  Text(
                    'Height',
                    style: TextStyle(
                      fontFamily: 'Verdana',
                      fontSize: 14,
                      color: Header,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) {
                            height = double.tryParse(value) ?? 0;
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'cm',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 30, right: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFFFFFFF),
              ),
              child: Column(
                children: [
                  Text(
                    'Weight',
                    style: TextStyle(
                      fontFamily: 'Verdana',
                      fontSize: 14,
                      color: Header,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) {
                            weight = int.tryParse(value) ?? 70;
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Arial',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'kg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  Calculate(height, weight);
                  raspuns = getIMCInterpretation(IMC, age, SelectM);
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                decoration: BoxDecoration(
                  color: Color(0xFF007BFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Calculate BMI',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Verdana',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                "BMI: $formattedImc",
                style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                "Interpretation: $raspuns",
                style: TextStyle(
                  fontFamily: 'Verdana',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


