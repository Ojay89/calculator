import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  // Transparent status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MaterialApp(
    title: "My First Calculator",
    theme: ThemeData(primaryColor: Colors.blue),
    home: My_First_Calculator(),
  ));
}

class My_First_Calculator extends StatefulWidget {
  @override
  _My_First_CalculatorState createState() => _My_First_CalculatorState();
}

class _My_First_CalculatorState extends State<My_First_Calculator> {
  var _operation = ["+", "-", "/", "*"];
  var _values = "+";
  var _displayText = "";

  TextEditingController textBox1 = TextEditingController();
  TextEditingController textBox2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              backgroundColor: Colors.black,
            )),
        body: Container(

          padding: EdgeInsets.all(30),
          child: ListView(
            padding: EdgeInsets.only(top: 75),
            children: <Widget>[

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: "My ",
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                    TextSpan(
                      text: "First",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                    TextSpan(
                        text: " Calculator",
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              //first item
              TextField(
                controller: textBox1,
                keyboardType: TextInputType.number,
                style: textStyle,
                decoration: InputDecoration(
                    labelText: "Indtast første tal",
                    hintText: "f.eks 100",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              //Second item
              DropdownButton<String>(
                value: _values,
                style: textStyle,
                items: _operation.map((String values) {
                  return DropdownMenuItem<String>(
                      value: values, child: Text(values));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _values = value;
                  });
                },
              ),

              //third item
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
              TextField(
                controller: textBox2,
                keyboardType: TextInputType.number,
                style: textStyle,
                decoration: InputDecoration(
                    labelText: "Indtast andet tal",
                    hintText: "f.eks 50",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              //fourth item

              //fifth item
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(0, 80, 10, 0)),
                  Container(
                    width: 125,
                    child: RaisedButton(
                      child: Text("Udregn"),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      onPressed: () {
                        setState(() {
                          FocusScope.of(context).requestFocus(
                            new FocusNode(),
                          );
                          double first = double.parse(textBox1.text);
                          double second = double.parse(textBox2.text);
                          switch (_values) {
                            case "+":
                              var sum = first + second;
                              _displayText =
                                  "Resultatet er " + sum.toStringAsFixed(0);
                              break;

                            case "-":
                              var diff = first - second;
                              _displayText =
                                  "Resultatet er " + diff.toStringAsFixed(0);
                              break;

                            case "*":
                              var mul = first * second;
                              _displayText =
                                  "Resultatet er " + mul.toStringAsFixed(0);
                              break;

                            case "/":
                              var div = first / second;
                              _displayText =
                                  "Resultatet er " + div.toStringAsFixed(0);
                              break;

                            default:
                              _displayText = "something went wrong";
                          }
                        });
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 30)),
                  Container(
                    width: 125,
                    child: RaisedButton(
                      child: Text("slet"),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      onPressed: () {
                        setState(() {
                          _clearAll();
                        });
                      },
                    ),
                  ),
                ],
              ),


              Text(
                _displayText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }

  void _clearAll() {
    textBox1.text = "";
    textBox2.text = "";
    _displayText = "";
  }
}
