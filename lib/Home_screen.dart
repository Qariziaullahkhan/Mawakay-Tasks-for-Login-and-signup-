import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mawakay_task_textformfield/auth/login_screen.dart';
import 'package:mawakay_task_textformfield/widgets/custom_drawers.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final authprovider = Provider.of<AuthProvider>(context);
    return  Scaffold(
             backgroundColor: Colors.grey[300],
               drawer:  const NDrwawer(),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Home Screen",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
        
        
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         const   Text("WELCOME HOME SCREEN", style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
               
                  const Gap(20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(200, 50),
                    ),
                    
                    onPressed: ()async{
       
        await FirebaseAuth.instance.signOut();

            showDialog(context: context, builder: (context){
            return AlertDialog(
                title:  Text('Confirmation'),
                        content:  Text('Are you sure to Logout ?'),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child: const Text("No")),
                               TextButton(
                              onPressed: () async {
                                Navigator.pop(context);

                                await FirebaseAuth.instance.signOut();

                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginScreen();
                                }));
                              },
                              child: const Text('Yes')),

                        ],
            );
          });
       

                    }, child: Text("Log out",style: TextStyle(color: Colors.white,fontSize: 15),))
          ],
        ),
      ),
    );
  }
}