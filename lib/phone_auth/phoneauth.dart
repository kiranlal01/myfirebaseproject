import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:myfirebaseproject/phone_auth/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey:"AIzaSyAJBWiD4aoC1paKOrJbTwzaMr5GUoCAmK0",
          appId:"1:1071183961647:android:3ad064b9071f6c534930da",
          messagingSenderId:"",
          projectId:"feabsefeb"
      )
  );
  runApp(PhoneAuth());
}

class PhoneAuth extends StatefulWidget{
  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final TextEditingController phoneController=TextEditingController();
  final TextEditingController otpcontroller=TextEditingController();
  String userNumber="";
  FirebaseAuth auth=FirebaseAuth.instance;

  var otpFieldvisibility=false;
  var receiveID="";

  void verifyUserPhoneNumber() {
    auth.verifyPhoneNumber(
      phoneNumber: userNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) async {
          if (value.user != null){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>phnHome()),
                    (route) => false);
          }
        });
        },
        verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
        receiveID=verificationId;
        otpFieldvisibility=true;
        setState(() {

        });
        },
        codeAutoRetrievalTimeout: (String verificationId) {  }
    );
  }

  Future<void>verifyOTPCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: receiveID,
        smsCode: otpcontroller.text
    );
    await auth.signInWithCredential(credential).then((value) async {
      if(value.user!=null){
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>phnHome()),
        // );
        Get.offAll(phnHome());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Phone Authentication',
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IntlPhoneField(
                controller: phoneController,
                initialCountryCode: 'NG',
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {
                  userNumber = val.completeNumber;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Visibility(
                visible: otpFieldvisibility,
                child: TextField(
                  controller: otpcontroller,
                  decoration: const InputDecoration(
                    hintText: 'OTP Code',
                    labelText: 'OTP',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (otpFieldvisibility) {
                  verifyOTPCode();
                } else {
                  verifyUserPhoneNumber();
                }
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Text(
                otpFieldvisibility ? 'Login' : 'Verify',
              ),
            )
          ],
        ),
      ),
    );
  }
}