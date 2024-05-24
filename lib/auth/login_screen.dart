
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mawakay_task_textformfield/auth/signup_screen.dart';
import 'package:mawakay_task_textformfield/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider =Provider.of<AuthProvider>(context);
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),

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
                  return null;
                },
                
              ),
                        const Gap(20),
          
               TextFormField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                  hintText: "password",
                  labelText: "password",
                  prefixIcon: Icon(Icons.lock),
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
          
              ElevatedButton(
                
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
                minimumSize: const Size(200,50),
        
        
             ),
                onPressed: ()async{
                if(_formkey.currentState!.validate()){
 await authProvider.login(emailcontroller.text.trim(), passwordcontroller.text.trim());
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return const SignupScreen();
                }));
                }
         
              }, child: Text("Login")),
            ],
          ),
        ),
      ),
    );
  }
}