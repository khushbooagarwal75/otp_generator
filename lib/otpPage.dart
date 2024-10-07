import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp/otp.dart';
class otpPage extends StatefulWidget {
  const otpPage({super.key});

  @override
  State<otpPage> createState() => _otpPageState();
}

class _otpPageState extends State<otpPage> {
  String _otp='';
  late Timer _timer;
  int countDownValue=0;
  late AnimationController stopWatch;

  // Secret key used to generate the OTP (normally you'd want this to be kept secret)
  final String _secret = 'JBSWY3DPEHPK3PXP';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generateOtp();
    timer();
    Timer.periodic(Duration(seconds: 30 ), (Timer timer) {
      _generateOtp();});
  }
  void timer(){
    _timer=Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        countDownValue++;
      });
    });

}
  void _generateOtp() {
    setState(() {
      countDownValue=0;
      _otp = OTP.generateTOTPCodeString(
        _secret,
        DateTime.now().millisecondsSinceEpoch,
        interval: 30,
        length: 6,
      );
    });
  }
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
          children: <Widget>[
            const Text(
              'Your OTP is:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              _otp,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'This OTP changes every 30 seconds',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 190,
            ),
            Center(
              child: Container(
                width: 500,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent,width: 7),
                  shape: BoxShape.circle
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Text(
                        "  $countDownValue  " ,
                        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}