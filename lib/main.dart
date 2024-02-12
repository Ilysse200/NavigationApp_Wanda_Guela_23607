import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green, // Setting the primary color for the tab navigation
        scaffoldBackgroundColor: Colors.white, // Setting the background color of the app
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)), // Setting text color
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Home(),
    Calculator(), // This line is changed to use the Calculator widget
    About(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab Navigation with Drawer'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Calculator'),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue, // Setting the background color of the bottom navigation bar
        selectedItemColor: Colors.black, // Setting the selected item color
        unselectedItemColor: Colors.white, // Setting the unselected item color
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Page'),
    );
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('About Page'),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '0';
  double currentResult = 0.0;
  String operand = '';
  String currentInput = '';

  void buttonPressed(String buttonText) {
    if (buttonText == 'CLEAR') {
      setState(() {
        _output = '0';
        currentResult = 0.0;
        operand = '';
        currentInput = '';
      });
    } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
      if (currentInput.isNotEmpty) {
        // Perform the operation if there is a current input
        double currentNumber = double.parse(currentInput);
        performOperation(currentNumber);
        operand = buttonText;
        currentInput = '';
      }
    } else if (buttonText == '.') {
      if (!currentInput.contains('.')) {
        currentInput += buttonText;
      }
    } else if (buttonText == '=') {
      if (currentInput.isNotEmpty) {
        double currentNumber = double.parse(currentInput);
        performOperation(currentNumber);
        currentInput = '';
        operand = '';
      }
    } else {
      currentInput += buttonText;
    }

    setState(() {
      _output = currentInput.isNotEmpty ? currentInput : currentResult.toString();
    });

    print(_output);
  }

  void performOperation(double currentNumber) {
    if (operand == '+') {
      currentResult += currentNumber;
    } else if (operand == '-') {
      currentResult -= currentNumber;
    } else if (operand == '*') {
      currentResult *= currentNumber;
    } else if (operand == '/') {
      if (currentNumber != 0) {
        currentResult /= currentNumber;
      } else {
        // Handle division by zero
        print('Error: Division by zero');
      }
    } else {
      // If there's no operand, set the current result to the current number
      currentResult = currentNumber;
    }
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: MaterialButton(
        child: Text(buttonText),
        onPressed: () => buttonPressed(buttonText),
        color: Colors.blueGrey,
        textColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        color: Colors.white, // Reverting background color of calculator to white
        child: Column(
          children: <Widget>[
            Text(_output, style: TextStyle(color: Colors.black)), // Setting text color
            Expanded(
              child: Divider(color: Colors.black), // Setting divider color
            ),
            Column(
              children: [
                Row(
                  children: [
                    buildButton('7'),
                    buildButton('8'),
                    buildButton('9'),
                    buildButton('/'),
                  ],
                ),
                Row(
                  children: [
                    buildButton('4'),
                    buildButton('5'),
                    buildButton('6'),
                    buildButton('*'),
                  ],
                ),
                Row(
                  children: [
                    buildButton('1'),
                    buildButton('2'),
                    buildButton('3'),
                    buildButton('-'),
                  ],
                ),
                Row(
                  children: [
                    buildButton('.'),
                    buildButton('0'),
                    buildButton('00'),
                    buildButton('+'),
                  ],
                ),
                Row(
                  children: [
                    buildButton('CLEAR'),
                    buildButton('='),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
