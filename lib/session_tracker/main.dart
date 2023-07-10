import 'package:flutter/material.dart';
import 'package:globalization_ex/session_tracker/focus_wraper.dart';

void main() {
  runApp(SessionTrackerApp());
}

class SessionTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Session Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SessionTrackerScreen(),
    );
  }
}

class SessionTrackerScreen extends StatefulWidget {
  @override
  _SessionTrackerScreenState createState() => _SessionTrackerScreenState();
}

class _SessionTrackerScreenState extends State<SessionTrackerScreen> {
  void setLog(String data) {
    logList.add(data);
    setState(() {});
  }

  List<String> logList = [];

  var selectedRadio = 1;
  var selectedDropDown = 2;
  var isCheckBoxSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FocusWrapper(
              sessionDuration: (value) {
                setLog("focus wraper for the text field 1: -  $value");
              },
              childWidget: TextField(
                onChanged: (value) {
                  // Do something with the text input
                },
                decoration: const InputDecoration(
                  labelText: 'Text Field',
                ),
              ),
            ),
            FocusWrapper(
              sessionDuration: (value) {
                setLog("focus value for text  field 2: - $value");
              },
              childWidget: TextField(
                onChanged: (value) {
                  // Do something with the text input
                },
                decoration: const InputDecoration(
                  labelText: 'Text Field 2',
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text('Radio: '),
                FocusWrapper(
                  sessionDuration: (value) {
                    setLog("radion one focus value time:-  $value");
                  },
                  childWidget: Radio(
                    value: 1,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                ),
                FocusWrapper(
                  sessionDuration: (value) {
                    setLog("radion 2 value focus time:-  $value");
                  },
                  childWidget: Radio(
                    value: 2,
                    groupValue: selectedRadio,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedRadio = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            FocusWrapper(
              sessionDuration: (value) {
                setLog("focus time of drop down:-  $value");
              },
              childWidget: DropdownButton(
                value: selectedDropDown,
                onChanged: (value) {
                  setState(() {
                    if (value == null) return;
                    selectedDropDown = value;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Option 1'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('Option 2'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            FocusWrapper(
              sessionDuration: (value) {
                setLog("focus value for check box tile: --  $value");
              },
              childWidget: CheckboxListTile(
                title: const Text('Checkbox'),
                value: isCheckBoxSelected,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    isCheckBoxSelected = value;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              height: 300,
              decoration: BoxDecoration(color: Colors.grey.shade200),
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: logList.length,
                itemBuilder: (context, index) {
                  return Text(logList[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
