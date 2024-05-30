import 'package:flutter/material.dart';

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
   DrawerHeader(child: Container(

    color: Colors.blue,
     padding: const EdgeInsets.only(left: 20),
     child: Column(
      children: [
        const CircleAvatar(
          radius: 100,
        ),
      ],
     ),
     

   ),
  

   ),
   ListTile(

    leading: const Icon(Icons.home),
    title: const Text("Home"),
   ),
  ],
),
    );
  }
}