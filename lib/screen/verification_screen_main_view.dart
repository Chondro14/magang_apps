import 'package:flutter/material.dart';

class VerificationScreenMainView extends StatefulWidget {
  VerificationScreenMainView(
      {Key key, @required this.smsCode, @required this.phoneNumber})
      : assert(phoneNumber != null, smsCode != null),
        super(key: key);
  final String phoneNumber;
  final String smsCode;

  @override
  _VerificationScreenMainViewState createState() =>
      _VerificationScreenMainViewState(
          phoneNumber: phoneNumber, smsCode: smsCode);
}

class _VerificationScreenMainViewState
    extends State<VerificationScreenMainView> {
  final String phoneNumber;
  final String smsCode;
  bool enabled = false;

  _VerificationScreenMainViewState(
      {@required this.phoneNumber, @required this.smsCode});

  List<String> phoneCode = ['+62', '+81', '+66'];
  String listCodeCountry;
  final TextEditingController phoneNumberController = TextEditingController();

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
              'Enter the 4-digit verification code',
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
                      hintText: '821xxxxxxxxx',
                    ),
                  ),
                ),
                Text(
                  'Edit',
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
