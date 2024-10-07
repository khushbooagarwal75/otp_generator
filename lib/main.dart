import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
import 'package:otp_generator/otpButtonClick.dart';
import 'package:otp_generator/otpPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: otpMenu(),
    );
  }
}
class otpMenu extends StatefulWidget {
  const otpMenu({super.key});

  @override
  State<otpMenu> createState() => _otpMenuState();
}

class _otpMenuState extends State<otpMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
        title: const Text('OTP Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) {
              return otpPage();
            },));}, child: Text("Refresh otp after each 30 secs")),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) {
              return otpButtonClick();
            },));}, child: Text("Generate Otp on Button Click"))
          ],
        ),
      ),
    );
  }
}





