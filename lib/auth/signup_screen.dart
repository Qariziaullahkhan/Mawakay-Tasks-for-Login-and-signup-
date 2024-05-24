import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mawakay_task_textformfield/Home_screen.dart';
import 'package:mawakay_task_textformfield/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("signup Screen"),

      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                  )
                ),
                
              validator: (value) {
                if(value == null || value.isEmpty){
                  return "Please a provide Email";
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
                if(value!.length >8||value.isEmpty){
                  return "Please Password does not match";
                }
                return null;
              },
              ),
                        const Gap(20),
                        Row(
                          children: [
                            Text("Don't have an account?"),
                            TextButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, child: Text("Login"))

                          ],
                        ),
                        const Gap(20),
          
              ElevatedButton(
                
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  minimumSize: const Size(200, 50)
          
               ),
                onPressed: ()async{

                  if(_formkey.currentState!.validate()){
                     await authProvider.signip(emailcontroller.text.trim(), passwordcontroller.text.trim());
          
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return const HomeScreen();
                }));
                  }
                    
              }, child: Text("sign up")),
            ],
          ),
        ),
      ),
    );
  }
}