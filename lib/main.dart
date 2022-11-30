import 'package:flutter/material.dart';
import 'package:testing/Dashboard.dart';
import 'pick.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAA94gMAPhTVC0nOfHmw2inL9YIRkTWor0",
          appId: "com.beya.testing",
          projectId: "testing-14b33",
          messagingSenderId: "381604848990"
      )
  );
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  void validate() {
    if (formkey.currentState!.validate()) {
      print("validated");
    }
    else {
      print("Not validated");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.deepPurple,
        body:
        SafeArea(
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Log In",
                    style: TextStyle(fontSize: 30, color: Colors.white),),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.mail, color: Colors.deepPurple,),
                      hintText: "Email ID",
                      fillColor: Colors.white,
                      filled: true,

                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0))
                      ),


                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your Email");
                      }
                      // reg expression for email validation
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emailController.text = value!;
                    },

                  ),


                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                      hintText: "Password",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                            const Radius.circular(30.0)),

                      ),

                    ),
                    obscureText: true,
                    maxLength: 16 ,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      RegExp regex = new RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("Password is required for login");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid Password(Min. 10 Character)");
                      }
                    },
                    onSaved: (value) {
                      passwordController.text = value!;
                    },

                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(23.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.1,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 15.0)),onPressed: () {
                        validate();
                        signIn(emailController.text, passwordController.text);
                      },
                          child: Text('Log In')),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Forgot Password ?", style: TextStyle(color: Colors.grey),),
                  SizedBox(height: 50.0,),
                  Text("Register Here", style: TextStyle(color: Colors.white),)

                ],
              ),
            ),
          ),
        )


    );
  }

  // login function
  void signIn(String email, String password) async {
    if (formkey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) =>
        {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => uploadDocs())),
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}