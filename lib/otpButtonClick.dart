import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otp/otp.dart';


class otpButtonClick extends StatefulWidget {
  const otpButtonClick({super.key});

  @override
  State<otpButtonClick> createState() => _otpButtonClickState();
}

class _otpButtonClickState extends State<otpButtonClick> {
  String _otp='';
  Timer? otpValidTime;
  late bool _isDisabled= false;

  // Secret key used to generate the OTP (normally you'd want this to be kept secret)
  final String _secret = 'JBSWY3DPEHPK3PXP';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override

  void _generateOtp() {
    setState(() {
      _otp = OTP.generateTOTPCodeString(
        _secret,
        DateTime.now().millisecondsSinceEpoch,
        interval: 10,
        length: 6,
      );
      _isDisabled=true;
    });

    otpValidTime?.cancel();
    otpValidTime=Timer(Duration(seconds: 10), () {setState(() {
      _isDisabled=false;
      print("object");
    });
    });
  }
  void dispose() {
    otpValidTime?.cancel(); // Clean up the timer when the widget is disposed
    super.dispose();
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
              _otp.isNotEmpty? _otp:"Click button",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isDisabled? null:_generateOtp,
              child: Text("Generate otp"),
            )
          ],
        ),
      ),
    );
  }
}