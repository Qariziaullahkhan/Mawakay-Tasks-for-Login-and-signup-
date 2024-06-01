import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mawakay_task_textformfield/Home_screen.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import '../widgets/Utillity/Flutter_toast.dart';
import 'forgot_password_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isVisibility = true;
  var _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: const Text(
          "Login Screen",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a valid Email";
                  }
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
                      .hasMatch(value);
                  if (!emailValid) {
                    return "Invalid Email address. Try again";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: _isVisibility,
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisibility = !_isVisibility;
                      });
                    },
                    icon: _isVisibility
                        ? const Icon(Icons.visibility, color: Colors.black)
                        : const Icon(Icons.visibility_off, color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return "Password must be at least 8 characters long";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const ForgotPasswordScreen();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignupScreen();
                          },
                        ),
                      );
                    },
                    child: const Text("Register"),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () async {
                       var Email = emailController.text.trim();
                    var Password = passwordController.text.trim();

                    if (Email.isEmpty || Password.isEmpty) {
                      Utils.toastmessage(
                          "Please all the fields", Colors.indigo);
                      //show error toast
                      return;
                    }
                    if (Password.length < 8) {
                      Utils.toastmessage(
                          "password length is less than 8", Colors.red);
                      // show error taost
                      return;
                    }
                    ProgressDialog progressDialog = ProgressDialog(context,
                        title: const Text("Logging in up"),
                        message: const Text("please provide"));
                    progressDialog.show();

                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      UserCredential? userCredential =
                          await auth.signInWithEmailAndPassword(
                              email: Email, password: Password);
                      if (userCredential.user!= null) {
                        progressDialog.dismiss();

                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }));
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        //Utils.showo
                        Fluttertoast.showToast(
                            msg: "user not found", fontSize: 30);
                      } else {
                        if (e.code == "email-already-in-use") {
                          Fluttertoast.showToast(
                              msg: "${e.message} ", fontSize: 30);
                          // Utils.toastmessage("Wrong Password",);
                        }
                      }
                    } catch (e) {
                      progressDialog.dismiss();
                      Fluttertoast.showToast(msg: "wrong password");
                    }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}