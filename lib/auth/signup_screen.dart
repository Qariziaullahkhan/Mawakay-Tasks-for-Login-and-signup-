import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:mawakay_task_textformfield/auth/login_screen.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

import '../provider/register_providers.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isVisibility = true;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context);
    print("Build");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: const Text(
          "Signup Screen",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    labelText: "Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please provide a name";
                    }
                    return null;
                  },
                ),
                const Gap(20),
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
                      return "Please provide an email";
                    }
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailValid) {
                      return "Invalid email address. Try again";
                    }
                    return null;
                  },
                ),
                const Gap(20),
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
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.black,
                            ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return "Please provide a password of at least 8 characters";
                    }
                    return null;
                  },
                ),
                const Gap(20),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: _isVisibility,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisibility = !_isVisibility;
                        });
                      },
                      icon: _isVisibility
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.black,
                            ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return "Passwords do not match";
                    }
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Login"),
                      )
                    ],
                  ),
                ),
                const Gap(20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: const Size(200, 50),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                   
                  signupProvider.isLoading = true; // Update loading state
                  await signupProvider.signup(
                    signupProvider.name,
                    signupProvider.email,
                    signupProvider.password,
                  );
                  signupProvider.isLoading = false; 




                    String name = nameController.text.trim();
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();
                    String confirmPassword = confirmPasswordController.text.trim();

                    if (password != confirmPassword) {
                      Fluttertoast.showToast(msg: "Passwords do not match");
                      return;
                    }

                    ProgressDialog progressDialog = ProgressDialog(context,
                        title: const Text("Signing up"),
                        message: const Text("Please wait..."));
                    progressDialog.show();

                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      UserCredential userCredential =
                          await auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (userCredential.user != null) {
                        FirebaseFirestore store = FirebaseFirestore.instance;
                        await store.collection("users").doc(userCredential.user!.uid).set({
                          "Name": name,
                          "Email": email,
                          "password":password,
                          "confirmPassword":confirmPassword,
                          "uid": userCredential.user!.uid,
                        });

                        Fluttertoast.showToast(msg: "Signup successful", textColor: Colors.white);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      } else {
                        progressDialog.dismiss();
                        Fluttertoast.showToast(msg: "Signup failed", textColor: Colors.red);
                      }
                    } on FirebaseAuthException catch (e) {
                      progressDialog.dismiss();
                      if (e.code == "email-already-in-use") {
                        Fluttertoast.showToast(msg: "Email is already in use", textColor: Colors.red);
                      } else if (e.code == "weak-password") {
                        Fluttertoast.showToast(msg: "Weak password", textColor: Colors.red);
                      } else {
                        Fluttertoast.showToast(msg: "Signup failed: ${e.message}", textColor: Colors.red);
                      }
                    } catch (e) {
                      progressDialog.dismiss();
                      Fluttertoast.showToast(msg: "Something went wrong", textColor: Colors.red);
                    }
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}