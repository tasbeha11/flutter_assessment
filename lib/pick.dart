import 'field.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

List<ProgressWidget>progressWidget=[ProgressWidget(), ProgressWidget(), ProgressWidget(), ProgressWidget()];
int counter=0;
bool check = false;

class uploadDocs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _alert(){
    return Alert(context: context,
        type: AlertType.info,
        title: 'Process Complete',
        desc: 'You have uploaded all the documents',
        buttons: [
          DialogButton(child: Text('Finish', style: TextStyle(fontSize: 10.0, color: Colors.white),), onPressed: (){Navigator.pop(context);}, width: 150,)
        ]
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff293462),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 25.0),
                child: Text(
                  'Upload Documents',
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontFamily: 'Alexandria',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Wrap(
                  children: progressWidget
              ),
              SizedBox(
                height: 35.0,
              ),
              filefield('Profile Picture', false, 0),
              filefield('Passport', true, 1),
              filefield('Certificate', true, 2),
              filefield('Driving License', true, 3),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width/1.2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      disabledBackgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)
                      )
                  ),
                  onPressed: check == false ? null :(){_alert();},
                  child: Text(
                    'Done',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressWidget extends StatefulWidget {

  Color containerColor = Colors.white;

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.containerColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        height: 8.0,
        width: 65.0,
        child: SizedBox(
        ),
      ),
    );
  }
}