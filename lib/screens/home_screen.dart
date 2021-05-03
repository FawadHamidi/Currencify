import 'package:currencify/services/api_services.dart';
import 'package:currencify/widgits/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  ApiServices apiServices = ApiServices();
  List<String> currencies;
  String from;
  String to;
  double rate;
  String result = "";

  Future<List<String>> getCurrencyList() async {
    return await apiServices.getCurrencies();
  }

  convert(val) async {
    rate = await apiServices.getRate(from, to);
    setState(() {
      result = (rate * double.parse(val)).toStringAsFixed(3);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    (() async {
      List<String> list = await apiServices.getCurrencies();
      setState(() {
        currencies = list;
      });
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Currenc',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'ify',
                style: TextStyle(color: Colors.amber),
              )
            ],
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ]),
                  child: TextField(
                    controller: _controller,
                    onSubmitted: convert,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'input value to convert',
                      labelStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ]),
                      child: customDropDown(
                        currencies,
                        from,
                        (val) {
                          setState(
                            () {
                              from = val;
                            },
                          );
                        },
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.amber,
                      onPressed: () {
                        String change = from;
                        setState(() {
                          from = to;
                          to = change;
                          convert(_controller);
                        });
                      },
                      child: Icon(
                        Icons.swap_horiz,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ]),
                      child: customDropDown(
                        currencies,
                        to,
                        (val) {
                          setState(
                            () {
                              to = val;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Result",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        result,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                      ),
                      onPressed: () {
                        setState(() {
                          convert(_controller.text);
                        });
                      },
                      child: Text(
                        'Convert',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
