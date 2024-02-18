import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Pressure Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  TextEditingController systolicController = TextEditingController();
  TextEditingController diastolicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blood Pressure Monitor',
          style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/info6.jpg'), // Set your input page background image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 const Icon(Icons.health_and_safety_outlined,size: 200,
                    color: Color.fromARGB(255, 246, 2, 2),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: systolicController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.blue), // Set text color to blue
                    decoration: InputDecoration(
                      labelText: 'Enter Systolic Pressure(mmHg)',
                      icon: Icon(Icons.arrow_upward),
                    ),
                  ),
                  TextField(
                    controller: diastolicController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.blue), // Set text color to blue
                    decoration: InputDecoration(
                      labelText: 'Enter Diastolic Pressure(mmHg)',
                      icon: Icon(Icons.arrow_downward),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      int? systolic = int.tryParse(systolicController.text);
                      int? diastolic = int.tryParse(diastolicController.text);

                      if (systolic != null && diastolic != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InformationScreen(
                              systolic: systolic,
                              diastolic: diastolic,
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Invalid Data'),
                            content: Text(
                                'Please enter valid systolic and diastolic values.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text('Validate ', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageScreen(),
                        ),
                      );
                    },
                    child: Text('Show Info', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InformationScreen extends StatelessWidget {
  final int systolic;
  final int diastolic;

  InformationScreen({required this.systolic, required this.diastolic});

  String getCategory() {
    if  (systolic <= 90 && diastolic <= 60) {
      return 'Low';
    }else if (systolic >= 90 && diastolic <= 80) {
      return 'Normal';
    } else if (systolic >= 120 && systolic <= 129 && diastolic > 80) {
      return 'Elevated';
    } else if ((systolic >= 130 && systolic <= 139) ||
        (diastolic >= 80 && diastolic <= 89)) {
      return 'Hypertension Stage 1';
    } else if (systolic <= 140 || diastolic == 90) {
      return 'Hypertension Stage 2';
    } else {
      return 'Hypertensive Crisis';
    }
  }

  @override
  Widget build(BuildContext context) {
    String category = getCategory();
    Color categoryColor;

    // Set color based on category
    switch (category) {
      case 'Low':
         categoryColor = Colors.blue;
        break;
      case 'Normal':
        categoryColor = Colors.green;
        break;
      case 'Elevated':
        categoryColor = Colors.yellow;
        break;
      case 'Hypertension Stage 1':
        categoryColor = Colors.orange;
        break;
      case 'Hypertension Stage 2':
        categoryColor = Colors.purple;
        break;
      case 'Hypertensive Crisis':
        categoryColor = Colors.red;
        break;
      default:
        categoryColor = Colors.black;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Pressure Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.health_and_safety_outlined,
              size: 300,
              color: Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              'Systolic: $systolic',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              'Diastolic: $diastolic',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Category: $category',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: categoryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/info4.png',
              width: 500,
              height: 500,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to home', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
