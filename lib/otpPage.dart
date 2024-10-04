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

  // Secret key used to generate the OTP (normally you'd want this to be kept secret)
  final String _secret = 'JBSWY3DPEHPK3PXP';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generateOtp();
    _timer=Timer.periodic(Duration(seconds: 30 ), (Timer timer) {_generateOtp(); });
  }
  void _generateOtp() {
    setState(() {
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
          ],
        ),
      ),
    );
  }
}