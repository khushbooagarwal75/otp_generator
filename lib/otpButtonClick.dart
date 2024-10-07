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
  Timer? countdown;
  int countdownValue =0;
  late bool _isDisabled= false;

  // Secret key used to generate the OTP (normally you'd want this to be kept secret)
  final String _secret = 'JBSWY3DPEHPK3PXP';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void timer() {
    countdown = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        countdownValue++;
      });
    });
  }
  void _generateOtp() {
    timer();
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
      countdownValue=0;
      countdown?.cancel();
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
              _otp.isNotEmpty? _otp:"Click button",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isDisabled
                    ? Colors.grey
                    : Colors.greenAccent, // Button color
              ),
              onPressed: _isDisabled? null:()
              {_generateOtp();

                },
              child: Text("Generate otp"),
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
                        "  $countdownValue  " ,
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