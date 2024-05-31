
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:mawakay_task_textformfield/Home_screen.dart';
import 'package:mawakay_task_textformfield/auth/forgot_password_screen.dart';
import 'package:mawakay_task_textformfield/auth/signup_screen.dart';
import 'package:mawakay_task_textformfield/provider/auth_provider.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isvisiblity = true;
  var _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
        print("build");

    return Scaffold(
      appBar: AppBar(
         centerTitle: true,
        backgroundColor: Colors.red,
       automaticallyImplyLeading: false,
       
        title:const Text("Login Screen", 
        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),

      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  hintText: "Email",
                  labelText: "Email",
                  
                  prefixIcon: Icon(Icons.email),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14)
                  ),
                  
                ),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Enter a valid Email";
                  }
                    bool emailValid = 
               RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                   if(!emailValid){
                    return "invalid Email address.try again";
                   }
                  return null;
                },
                
              ),

                        const Gap(20),
          
               TextFormField(
                controller: passwordcontroller,
                obscureText: _isvisiblity,
                decoration: InputDecoration(
                  hintText: "password",
                  labelText: "password",
                  prefixIcon: Icon(Icons.lock),
               suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isvisiblity = !_isvisiblity;
                            });
                          },
                          icon: _isvisiblity
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                )),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14)
                  )
                ),
                  validator: (value) {
                  if(value!.length <8){
                    return "Please a password length does not match";
                  }
                  return null;
                },
              ),
              const Gap(20),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(onPressed: (){


                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const ForgotPasswordScreen();
                  }));
                }, 
                child: Text("Forgot Password?",style: TextStyle(color: Colors.blue,),))),
                        const Gap(20),
                        Row(
                          children: [
                            Text("Already have an account?"),
                            TextButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return const SignupScreen();
                              }));
                            }, child: Text("Register"))

                          ],
                        ),
          
              ElevatedButton(
                
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
                minimumSize: const Size(200,50),
        
        
             ),
                onPressed: ()async{
                  var Email = emailcontroller.text.trim();
                  var Password = passwordcontroller.text.trim();
                  if(Email.isEmpty || Password.isEmpty){
                    Fluttertoast.showToast(msg: "Please all the fields",textColor: Colors.indigo);
                    return ;
                  }

                  if(Password.length<8){
                    Fluttertoast.showToast(msg: "Password deos not match");
                    return ;
                  }
                

                    ProgressDialog progressDialog = ProgressDialog(context,
                        title: const Text("Logging in up"),
                        message: const Text("please provide"));
                    progressDialog.show();

                    try{
                       FirebaseAuth auth = FirebaseAuth.instance;
                      UserCredential? userCredential =
                          await auth.signInWithEmailAndPassword(
                              email: Email, password: Password);
                              if(userCredential.user!= null){
                                      progressDialog.dismiss();
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                                        return const HomeScreen();
                                      }));

                              }
                              else{
                                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                                        return const ForgotPasswordScreen();
                                      }));
                              }

                    }

                    catch(e){
                            progressDialog.dismiss();
                      Fluttertoast.showToast(msg: "wrong password");
                    }

                // if(_formkey.currentState!.validate()){
                //   await authProvider.login(emailcontroller.text.trim(), passwordcontroller.text.trim());
                // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                //   return const HomeScreen();
                // }));
                // }
         
              }, 
              child: Text("Login",style:TextStyle(fontSize: 20,color: Colors.white),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}