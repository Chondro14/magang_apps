import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:magang_apps/bloc/login_cubit.dart';
import 'package:magang_apps/repository/AuthenticationRepository.dart';
import 'package:magang_apps/screen/BottomNavigationMainView.dart';

class LoginPage extends StatelessWidget {
  static Route route(BuildContext context) {
    return MaterialPageRoute<void>(
      builder: (_) => LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(context.repository<AuthenticationRepository>()),
      child: LoginScreenMainView(),
    );
  }
}

class LoginScreenMainView extends StatefulWidget {
  const LoginScreenMainView({Key key, this.userRepository}) : super(key: key);
  final AuthenticationRepository userRepository;

  @override
  _LoginScreenMainViewState createState() =>
      _LoginScreenMainViewState(userRepository);
}

class _LoginScreenMainViewState extends State<LoginScreenMainView> {
  final AuthenticationRepository userRepository;

  final TextEditingController phoneNumberController = TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List<String> phoneCode = ['+62', '+81', '+66'];
  List<ListItemCodePhoneCountry> listItemCode = [
    ListItemCodePhoneCountry(codePhone: '+62', country: 'Indonesia'),
    ListItemCodePhoneCountry(codePhone: '+81', country: 'Japan'),
    ListItemCodePhoneCountry(codePhone: '+66', country: 'Thailand'),
    ListItemCodePhoneCountry(codePhone: '+65', country: 'Singapore'),
    ListItemCodePhoneCountry(codePhone: '+60', country: 'Malaysia'),
    ListItemCodePhoneCountry(codePhone: '+63', country: 'Philippines')
  ];
  List<DropdownMenuItem<ListItemCodePhoneCountry>> codeItemDropDown;
  ListItemCodePhoneCountry listCode;
  String listCodeCountry;
  String phoneNumber;
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController OTPcode = TextEditingController();

  String smsCode = '';
  String verId = '';

  _LoginScreenMainViewState(this.userRepository);

  @override
  void initState() {
    super.initState();
    listCodeCountry = phoneCode[0];

    print(listCode);
  }

  Future<void> sendSmsCodeOTP(
      String smsCode, String verId, String phoneNumber) async {
    final PhoneCodeAutoRetrievalTimeout timeout = (String verId) {
      this.verId = verId;
    };
    final PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeResent]) async {
      this.verId = verId;
      Random value = Random();

      int a = value.nextInt(9);
      int b = value.nextInt(9);
      int c = value.nextInt(9);
      int d = value.nextInt(9);
      int e = value.nextInt(9);
      try {
        smsCode = a.toString() +
            b.toString() +
            c.toString() +
            d.toString() +
            e.toString();
        smsCodeDialoge(context, smsCode).then((value) async {
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(
                  verificationId: verId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomnavigationMainView()));
        });

        // Sign the user in (or link) with the credential

      } on PlatformException catch (e) {
        if (e.message.contains(
            'The sms verification code used to create the phone auth credential is invalid')) {
          print(
              'The sms verification code used to create the phone auth credential is invalid');
          // ...
        } else if (e.message.contains('The sms code has expired')) {
          print('The sms code has expired');
          // ...
        }
      }

      // Sign the user in (or link) with the credential
    };
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await _firebaseAuth.signInWithCredential(credential);
      _firebaseAuth.setLanguageCode('id');
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      if (exception.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
    };

    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: smsCodeSent,
          codeAutoRetrievalTimeout: timeout);
    } on PlatformException catch (e) {
      if (e.message.contains(
          'The sms verification code used to create the phone auth credential is invalid')) {
        print(
            'The sms verification code used to create the phone auth credential is invalid');

        // ...
      } else if (e.message.contains('The sms code has expired')) {
        print('The sms code has expired');

        // ...
      }
    }
  }

  Future<bool> smsCodeDialoge(BuildContext context, String smsCode) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.yellow[800],
          title: Text('Enter OTP'),
          content: TextField(
            controller: OTPcode,
            onChanged: (value) {
              this.smsCode = value;
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Verify'),
              onPressed: () async {
                smsCode = OTPcode.text.trim();
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verId, smsCode: smsCode);
                  await _firebaseAuth.signInWithCredential(credential);
                  User user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    Navigator.of(context).pop();
                    scaffold.currentState
                        .showSnackBar(SnackBar(content: Text('Succes OTP')));
                    Navigator.push(
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

                // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    phoneNumber = listCodeCountry + phoneNumberController.text.trim();
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, LoginState state) {
          if (state.status.isSubmissionFailure) {
            scaffold.currentState.showSnackBar(
                SnackBar(content: Text('Authentication Failure')));
          }
        },
        // ignore: missing_required_param
        child: Scaffold(
            key: scaffold,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Form(
                  key: formState,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Enter Phone Number',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 26),
                            ),
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
                                  child: BlocBuilder<LoginCubit, LoginState>(
                                      buildWhen: (previous, current) =>
                                          previous.phoneNumber !=
                                          current.phoneNumber,
                                      builder: (context, state) {
                                        return TextFormField(
                                          keyboardType: TextInputType.phone,
                                          onChanged: (value) => context
                                              .bloc<LoginCubit>()
                                              .PhoneNumberChanged(value),
                                          controller: phoneNumberController,
                                          decoration: InputDecoration(
                                            hintText: '821xxxxxxxxx',
                                            errorText: state.phoneNumber.invalid
                                                ? 'invalid PhoneNumber'
                                                : null,
                                          ),
                                        );
                                      })),
                            ],
                          ),
                        ],
                      ),
                      Text(phoneNumber),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    Random value = Random();

                                    int a = value.nextInt(9);
                                    int b = value.nextInt(9);
                                    int c = value.nextInt(9);
                                    int d = value.nextInt(9);
                                    int e = value.nextInt(9);
                                    int f = value.nextInt(9);
                                    smsCode = a.toString() +
                                        b.toString() +
                                        c.toString() +
                                        d.toString() +
                                        e.toString() +
                                        f.toString();
                                    verId = '';

                                    sendSmsCodeOTP(smsCode, verId, phoneNumber);
                                    /*Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                VerificationScreenMainView(
                                                    smsCode: smsCode,
                                                    phoneNumber: phoneNumber,verId: verId,)));*/
                                  });
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.8,
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  child: Center(
                                    child: Text(
                                      'Continue',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
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
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            )));
  }
}


class ListItemCodePhoneCountry {
  String codePhone;
  String country;

  ListItemCodePhoneCountry({@required this.codePhone, @required this.country});
}
