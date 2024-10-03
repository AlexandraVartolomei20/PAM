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
  Color backgroundColor = Color(0xFFD1D9E5);
  Color headerColor = Color(0x7377868F);
  Color colorBackM = Color(0xFF007BFF);
  Color colorBackF = Color(0xFFFFFFFF);
  Color colorTextM = Colors.white;
  Color colorTextF = Color(0xFF007BFF);
  int weight = 70;
  int age = 22;
  bool selectM = true;
  double imc = 0;
  String formattedImc = "0";
  String raspuns = "";
  double height = 0;

  void calculate(double height, int weight) {
    if (height > 0) {
      height /= 100;
      imc = weight / (height * height);
      formattedImc = imc.toStringAsFixed(2);
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

  void updateColors() {
    if (selectM) {
      colorBackM = Color(0xFF007BFF);
      colorTextM = Colors.white;
      colorTextF = Color(0xFF007BFF);
      colorBackF = Colors.white;
    } else {
      colorBackF = Color(0xFF007BFF);
      colorTextF = Colors.white;
      colorTextM = Color(0xFF007BFF);
      colorBackM = Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                        child: Text(
                          "BMI Calculator",
                          style: TextStyle(
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        selectM = true;
                        updateColors();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 23),
                      backgroundColor: colorBackM,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: Icon(
                      Icons.male,
                      color: colorTextM,
                      size: 18,
                    ),
                    label: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        "Male  ",
                        style: TextStyle(
                          color: colorTextM,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        selectM = false;
                        updateColors();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                      backgroundColor: colorBackF,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: Icon(
                      Icons.female,
                      color: colorTextF,
                      size: 18,
                    ),
                    label: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        "Female",
                        style: TextStyle(
                          color: colorTextF,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Weight"),
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        child: Text(
                          "$weight",
                          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF007BFF),
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fixedSize: Size(10, 10),
                            ),
                            onPressed: () {
                              setState(() {
                                if (weight > 0) weight--;
                                else weight = 0;
                              });
                            },
                            child: Icon(Icons.remove, color: Colors.white, size: 20),
                          ),
                          Padding(padding: EdgeInsets.all(20)),
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF007BFF),
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fixedSize: Size(10, 10),
                            ),
                            onPressed: () {
                              setState(() {
                                weight++;
                              });
                            },
                            child: Icon(Icons.add, color: Colors.white, size: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Age"),
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        child: Text(
                          "$age",
                          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF007BFF),
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fixedSize: Size(10, 10),
                            ),
                            onPressed: () {
                              setState(() {
                                if (age > 0) age--;
                                else age = 0;
                              });
                            },
                            child: Icon(Icons.remove, color: Colors.white, size: 20),
                          ),
                          Padding(padding: EdgeInsets.all(20)),
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF007BFF),
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fixedSize: Size(10, 10),
                            ),
                            onPressed: () {
                              setState(() {
                                age++;
                              });
                            },
                            child: Icon(Icons.add, color: Colors.white, size: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Column(
                children: [
                  Text(
                    "Height (cm)",
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: SizedBox(
                      width: 120,
                      child: TextField(
                        onChanged: (value) {
                          height = double.tryParse(value) ?? 0;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        calculate(height, weight);
                        raspuns = getIMCInterpretation(imc, age, selectM);
                      });
                    },
                    child: Text("Calculate BMI"),
                  ),
                ],
              ),
            ),
            Container(
              child: Text(
                "BMI: $formattedImc\n$raspuns",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

