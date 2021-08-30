import 'dart:math'; // Used to solve math equation.
import 'package:flutter/material.dart'; // UI materials.
import 'package:http/http.dart' as http; // To implement HTTP web server.
import 'package:universal_io/io.dart'; // Socket binding, server & client communication.
import 'dart:convert' as convert; // To convert JSON to readable format.

void main() async {
  startServer(); // Function that bind the socket etc.
  runApp(MyApp()); // Main program start the UI, API etc.
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Create a blank app UI.
      debugShowCheckedModeBanner: false,
      title: 'SEA Country COVID-19 Live Statistics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
            headline4: TextStyle(color: Colors.white),
            headline6: TextStyle(color: Colors.white)),
      ),
      home: MyHomePage(
          title:
              'Southeast Asia COVID-19 Live Statistics'), // Pass the main UI.
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() =>
      _MyHomePageState(); // Initialize the widget.
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_field
  String _activeCases = '0'; // Variables to save value from API
  String _lastUpdate = '';
  String _newCases = '0';
  String _newDeaths = '0';
  String _totalCases = '0';
  String _totalDeaths = '0';
  String _country = '';
  String _totalRecovered = '0';

  void _getData(String codename) async {
    // Retrieve API data based on flags clicked
    dynamic url;
    if (codename == 'KH') {
      url = Uri.parse(
          'https://covid-19.dataflowkit.com/v1/Cambodia'); // Cambodia API
    } else if (codename == 'MY') {
      url = Uri.parse(
          'https://covid-19.dataflowkit.com/v1/Malaysia'); // Malaysia API
    } else if (codename == 'MM') {
      url = Uri.parse(
          'https://covid-19.dataflowkit.com/v1/Myanmar'); // Myanmar API
    } else if (codename == 'BN') {
      url =
          Uri.parse('https://covid-19.dataflowkit.com/v1/Brunei'); // Brunei API
    } else if (codename == 'TH') {
      url = Uri.parse(
          'https://covid-19.dataflowkit.com/v1/Thailand'); // Thailand API
    } else if (codename == 'ID') {
      url = Uri.parse(
          'https://covid-19.dataflowkit.com/v1/Indonesia'); // Indonesia API
    } else if (codename == 'TL') {
      url = Uri.parse(
          'https://covid-19.dataflowkit.com/v1/Timor-Leste'); // Timor Leste API
    } else if (codename == 'LA') {
      url = Uri.parse('https://covid-19.dataflowkit.com/v1/Laos'); // Laos API
    } else if (codename == 'PH') {
      url = Uri.parse(
          'https://covid-19.dataflowkit.com/v1/Philippines'); // Philippines API
    } else if (codename == 'VN') {
      url = Uri.parse(
          'https://covid-19.dataflowkit.com/v1/Vietnam'); // Vietnam API
    } else if (codename == 'SG') {
      url = Uri.parse(
          'https://covid-19.dataflowkit.com/v1/Singapore'); // Singapore API
    } else
      setState(() => _activeCases = 'Error'); // Send error if API link broken
    var response = await http.get(url); // Get the API URL
    if (response.statusCode == 200) {
      // 200 status code if URL valid
      var jsonResponse = convert.jsonDecode(response.body)
          as Map<String, dynamic>; // Decode the JSON to String
      setState(() {
        _activeCases =
            jsonResponse['Active Cases_text']; // Pass data from API to variable
        _country = jsonResponse['Country_text'];
        _lastUpdate = jsonResponse['Last Update'];
        _newCases = jsonResponse['New Cases_text'];
        _newDeaths = jsonResponse['New Deaths_text'];
        _totalCases = jsonResponse['Total Cases_text'];
        _totalDeaths = jsonResponse['Total Deaths_text'];
        _totalRecovered = jsonResponse['Total Recovered_text'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getData('MY');
  }

  @override
  Widget build(BuildContext context) {
    // UI Stuffs
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('header.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.blueGrey[900],
              ),
              width: 700,
              height: 300,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '$_country',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  )),
                  Expanded(
                      flex: 2,
                      child: Container(
                          padding: EdgeInsets.all(30),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '$_totalCases',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              '( $_newCases )',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Confirmed',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '$_totalDeaths',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              '( $_newDeaths )',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Deaths',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '$_totalRecovered',
                                              style: TextStyle(
                                                color: Colors.lightGreen,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Recovered',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ))),
                  Expanded(
                      child: Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Updated: ' + '$_lastUpdate',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 200,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    _getData('KH');
                  },
                  child: Image.asset('icons/flags/png/kh.png',
                      package: 'country_icons'),
                ),
                SizedBox(width: 7),
                TextButton(
                  onPressed: () {
                    _getData('MM');
                  },
                  child: Image.asset('icons/flags/png/mm.png',
                      package: 'country_icons'),
                ),
                SizedBox(width: 7),
                TextButton(
                  onPressed: () {
                    _getData('BN');
                  },
                  child: Image.asset('icons/flags/png/bn.png',
                      package: 'country_icons'),
                ),
                SizedBox(width: 7),
                TextButton(
                  onPressed: () {
                    _getData('TH');
                  },
                  child: Image.asset('icons/flags/png/th.png',
                      package: 'country_icons'),
                ),
                SizedBox(width: 7),
                TextButton(
                  onPressed: () {
                    _getData('MY');
                  },
                  child: Image.asset('icons/flags/png/my.png',
                      package: 'country_icons'),
                ),
                SizedBox(width: 7),
                TextButton(
                  onPressed: () {
                    _getData('ID');
                  },
                  child: Image.asset('icons/flags/png/id.png',
                      package: 'country_icons'),
                ),
                SizedBox(width: 7),
                TextButton(
                  onPressed: () {
                    _getData('TL');
                  },
                  child: Image.asset('icons/flags/png/tl.png',
                      package: 'country_icons'),
                ),
                SizedBox(width: 7),
                TextButton(
                  onPressed: () {
                    _getData('LA');
                  },
                  child: Image.asset('icons/flags/png/la.png',
                      package: 'country_icons'),
                ),
                SizedBox(width: 7),
                TextButton(
                  onPressed: () {
                    _getData('PH');
                  },
                  child: Image.asset('icons/flags/png/ph.png',
                      package: 'country_icons'),
                ),
                SizedBox(width: 7),
                TextButton(
                  onPressed: () {
                    _getData('VN');
                  },
                  child: Image.asset('icons/flags/png/vn.png',
                      package: 'country_icons'),
                ),
                SizedBox(width: 7),
                TextButton(
                  onPressed: () {
                    _getData('SG');
                  },
                  child: Image.asset('icons/flags/png/sg.png',
                      package: 'country_icons'),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

startServer() async {
  // Function to create a HTTP server
  int randno =
      1 + Random().nextInt(70000 - 40000); // generate random port number
  var server = await HttpServer.bind(
      'localhost', randno); // Bind web to localhost with port of random number.
  await for (var request in server) {
    request.response
      ..headers.contentType = new ContentType("text", "plain", charset: "utf-8")
      ..write('Connected'); // client response with connected.
  }
}
