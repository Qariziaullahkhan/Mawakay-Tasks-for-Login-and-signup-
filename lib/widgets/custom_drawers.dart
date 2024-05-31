import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mawakay_task_textformfield/Home_screen.dart';
import 'package:mawakay_task_textformfield/auth/login_screen.dart';

class NDrwawer extends StatefulWidget {
  const NDrwawer({super.key});

  @override
  State<NDrwawer> createState() => _NDrwawerState();
}

class _NDrwawerState extends State<NDrwawer> {
  @override
  Widget build(BuildContext context) {
       return Drawer(
backgroundColor: Colors.white,
      child: ListView(
        children: [
       DrawerHeader(
        
        padding: EdgeInsets.zero,
        child: Container(
         color: Theme.of(context).primaryColor,
 padding: const EdgeInsets.only(left: 20),
 child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
  children: [
      CircleAvatar(
        backgroundImage: AssetImage("assets/images/zia.jpg"),
        radius: 50,
      ),
                    
  ],
 ),
       )),
       ListTile(
        leading: const Icon(Icons.home),
        
        title: Text("Home"),
        onTap: () {
          Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                  return const HomeScreen();
                                }));
        },
       ),
   
         ListTile(
        leading: const Icon(Icons.logout),
        title: Text("Log Out"),
        onTap: () {
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
              
        },
       ),
          ListTile(
        leading: const Icon(Icons.settings),
        title: Text("Settings"),
        onTap: () {
          Navigator.of(context);
        },
       ),
        
        ],
      ),
    );
  }
}