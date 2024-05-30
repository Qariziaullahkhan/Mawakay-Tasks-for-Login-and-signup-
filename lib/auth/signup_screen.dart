import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:mawakay_task_textformfield/Home_screen.dart';
import 'package:mawakay_task_textformfield/auth/login_screen.dart';
import 'package:mawakay_task_textformfield/provider/auth_provider.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isvisiblity =true;
  var _formkey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //  final authProvider = Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title:const  Text("signup Screen",
        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),

      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                   TextFormField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    hintText: "Name",
                    labelText: "Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)
                    )
                  ),
                  
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Please a provide Name";
                  }
                  return null;
                },
                  
                ),
                const Gap(20),
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
                  if(value!.length >8||value.isEmpty){
                    return "Please provide Password at least 8 characters";
                  }
                  return null;
                },
                ),
                 const Gap(20),
                 TextFormField(
                  
                  controller: confirmpasswordcontroller,
                  obscureText: _isvisiblity,
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    labelText: "Confirm password",
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
                  if(value!.length >8||value.isEmpty){
                    return "Please provie Password does not match";
                  }
                  return null;
                },
                ),
                          const Gap(20),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Text("Don't have an account?"),
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text("Login"))
                                    
                              ],
                            ),
                          ),
                          const Gap(20),
            
                ElevatedButton(
                  
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    minimumSize: const Size(200, 50)
            
                 ),
                  onPressed: ()async{
                     String Name = namecontroller.text.trim();
                     String Email = emailcontroller.text.trim();
                     String Password = passwordcontroller.text.trim();
                     String confirmpassword = confirmpasswordcontroller.text.trim();
        
                            
        
                   
                       if(Name.isEmpty || Email.isEmpty || Password.isEmpty || confirmpassword.isEmpty){
                        Fluttertoast.showToast(msg: "Please all the fields");
                       }

                       if(Password != confirmpassword){
                        Fluttertoast.showToast(msg: "password deos not match");
                       }
                          

                         ProgressDialog progressDialog = ProgressDialog(context,
                        title: const Text("Signing up"),
                        message: const Text("Please provide"));
                                            progressDialog.show();


                        try{
                        FirebaseAuth auth = FirebaseAuth.instance;
                        UserCredential?  userCredential =
                         await auth.createUserWithEmailAndPassword(email: emailcontroller.text.trim(), password: passwordcontroller.text.trim());
                         if(userCredential.user!= null){
                FirebaseFirestore store = FirebaseFirestore.instance;
                await store.collection("users").doc(userCredential.user!.uid).set(
                  {
                   "Name":Name,
                   "Email":Email,
                   "Password": Password ,
                   "confirmpassword":confirmpassword,
                   "uid":userCredential.user!.uid,

                  }
                );
                Fluttertoast.showToast(msg: "Succesful",textColor: Colors.white);
                  //   if(_formkey.currentState!.validate()){
                  //      await authProvider.signip(
                  //       namecontroller.text.trim(),
                  //       emailcontroller.text.trim(), 
                  //      passwordcontroller.text.trim(),
                  //      namecontroller.text.trim(),
                  //      confirmpasswordcontroller.text.trim(),
                  //      );
                  // }
                   Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      } else {
                        progressDialog.dismiss();
                        Fluttertoast.showToast(msg: "Failed",textColor: Colors.red);
                      }
                      
                         }
                         on FirebaseAuthException catch (e){
                           progressDialog.dismiss();
                   
                      if (e.code == "Email is already use in") {
                     Fluttertoast.showToast(msg: "Email - already user -in",textColor: Colors.amber);
                      } else {
                        if (e.code == "weak password") {
                          Fluttertoast.showToast(msg: "weak password",textColor: Colors.red);
                        }
                         }
                         }
                        
                        catch(e){
                          progressDialog.dismiss();
                          Fluttertoast.showToast(msg: "something went wrong",textColor: Colors.red);

                        }
           
               
                      
                }, child: Text("sign up",style: TextStyle(fontSize: 20,color: Colors.white),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}