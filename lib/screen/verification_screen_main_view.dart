import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:magang_apps/bloc/login_cubit.dart';
import 'package:magang_apps/screen/BottomNavigationMainView.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class VerificationScreenMainView extends StatefulWidget {
  VerificationScreenMainView(
      {Key key,
      @required this.smsCode,
      @required this.phoneNumber,
      @required this.verId})
      : super(key: key);
  final String phoneNumber;
  final String smsCode;
  final String verId;

  @override
  _VerificationScreenMainViewState createState() =>
      _VerificationScreenMainViewState(
          phoneNumber: phoneNumber, smsCode: smsCode, verificationId: verId);
}

class _VerificationScreenMainViewState
    extends State<VerificationScreenMainView> {
  final String phoneNumber;
  final String smsCode;
  bool enabled = false;
  String verificationId;

  _VerificationScreenMainViewState(
      {@required this.phoneNumber, @required this.smsCode, @required this.verificationId});

  List<String> phoneCode = ['+62', '+81', '+66'];
  String listCodeCountry;
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController phoneNumberController1 = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  Future<bool> verifyphone(BuildContext context, String phonenumber,
      String smsCode) async {
    final PhoneCodeAutoRetrievalTimeout timeout = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeResent]) async {
      this.verificationId = verId;
      Random value = Random();

      int a = value.nextInt(9);
      int b = value.nextInt(9);
      int c = value.nextInt(9);
      int d = value.nextInt(9);
      int e = value.nextInt(9);
      try {
        smsCodeDialoge(context, smsCode).then((value) async {
          PhoneAuthCredential phoneAuthCredential =
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await auth.signInWithCredential(phoneAuthCredential);
        });

        // ...
      } on PlatformException catch (e) {
        if (e.message.contains(
            'The sms verification code used to create the phone auth credential is invalid')) {
          scaffold.currentState.showSnackBar(SnackBar(
              content: Text(
                  'The sms verification code used to create the phone auth credential is invalid')));
          // ...
        } else if (e.message.contains('The sms code has expired')) {
          scaffold.currentState.showSnackBar(
              SnackBar(content: Text('The sms code has expired')));
          // ...
        }
      }

      // Sign the user in (or link) with the credential
    };
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
      auth.setLanguageCode('id');
      User user;

      if (user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(
                builder: (context) => BottomnavigationMainView()));
        scaffold.currentState
            .showSnackBar(SnackBar(content: Text('Succes OTP')));
      }
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      if (exception.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');

        scaffold.currentState.showSnackBar(
            SnackBar(content: Text('The provided phone number is not valid.')));
      }
    };
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: smsCodeSent,
          codeAutoRetrievalTimeout: timeout);
    } on PlatformException catch (e) {
      if (e.message.contains(
          'The sms verification code used to create the phone auth credential is invalid')) {
        scaffold.currentState.showSnackBar(SnackBar(
            content: Text(
                'The sms verification code used to create the phone auth credential is invalid')));
        // ...
      } else if (e.message.contains('The sms code has expired')) {
        scaffold.currentState
            .showSnackBar(SnackBar(content: Text('The sms code has expired')));
        // ...
      }
    }
  }


  Future<bool> smsCodeDialoge(BuildContext context, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      User user = FirebaseAuth.instance.currentUser;


      if (user != null) {
        Navigator.of(context).pop();
        scaffold.currentState
            .showSnackBar(SnackBar(content: Text('Succes OTP')));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomnavigationMainView()));
      }
    } on PlatformException catch (e) {
      if (e.message.contains(
          'The sms verification code used to create the phone auth credential is invalid')) {
        scaffold.currentState.showSnackBar(SnackBar(
            content: Text(
                'The sms verification code used to create the phone auth credential is invalid')));
        // ...
      } else if (e.message.contains('The sms code has expired')) {
        scaffold.currentState.showSnackBar(
            SnackBar(content: Text('The sms code has expired')));
        // ...
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            }),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Text('OTP Verification',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w800)),
            Text(
              'Enter the 6-digit verification code',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, -20),
                  child: SizedBox(
                    width: 60,
                    height: 50,
                    child: DropdownButton(
                      hint: Text(listCodeCountry),
                      items: phoneCode.map((value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          listCodeCountry = value;
                        });
                      },
                      value: listCodeCountry,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 100,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      hintText: '$phoneNumber',
                    ),
                  ),
                ),
                Text(
                  'Edit',
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.5,
              height: 40,
              child: PinInputTextFormField(
                  controller: phoneNumberController1,
                  pinLength: 6,
                  keyboardType: TextInputType.number,
                  decoration: UnderlineDecoration(
                    colorBuilder:
                    PinListenColorBuilder(Colors.cyan, Colors.green),
                  ),
                  onSubmit: (pin) {
                    debugPrint('submit pin:$pin');
                  },
                  onChanged: (pin) {
                    debugPrint('onChanged execute. pin:$pin');
                  },
                  enableInteractiveSelection: false
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      'By continuing,I confirm that i have read & agree to the'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        'Terms & Condition',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(' and '),
                      Text('Privacy Policy',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800))
                    ],
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (previous, current) =>
                    previous.status != current.status,
                    builder: (context, state) {
                      return state.status.isSubmissionInProgress
                          ? const CircularProgressIndicator()
                          :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() async {
                              smsCodeDialoge(context, smsCode);
                            });
                          },
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 1.8,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 20,
                            child: Center(child: Text('Submit',
                              style: TextStyle(color: Colors.white),),),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(255, 153, 0, 1),
                                      Color.fromARGB(255, 207, 105, 1)
                                    ],

                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight),

                                borderRadius: BorderRadius.all(
                                    Radius.circular(20.0))),
                          ),
                        ),
                      );
                    },

                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
