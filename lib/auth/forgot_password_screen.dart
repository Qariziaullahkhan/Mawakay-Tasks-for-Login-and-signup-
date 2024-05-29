import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mawakay_task_textformfield/auth/login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
        var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
           centerTitle: true,
        backgroundColor: Colors.red,
       
       
        title:const Text("Forgot Password", 
        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        const Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Gap(20),
                   const Text(
                  'Please enter your email address to recover your password.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const Gap(20),
                const Text(
                  'Email address',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
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

         
            const Gap(40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
              onPressed: (){
      
            if(_formkey.currentState!.validate()){
                    Navigator.of(context).pop();
      }
      
              }, child: const Text("Forgot Password",style: TextStyle(color: Colors.white,fontSize: 15),)),
          ],
        ),
      ),
    );
  }
}