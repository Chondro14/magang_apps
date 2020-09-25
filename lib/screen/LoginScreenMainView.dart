import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:magang_apps/bloc/login_cubit.dart';
import 'package:magang_apps/repository/AuthenticationRepository.dart';
import 'package:magang_apps/screen/verification_screen_main_view.dart';

class LoginScreenMainView extends StatefulWidget {
  const LoginScreenMainView({Key key, this.userRepository}) : super(key: key);
  final AuthenticationRepository userRepository;

  static Route route() {
    Future.delayed(Duration(seconds: 5));
    return MaterialPageRoute<void>(
        builder: (_) => LoginScreenMainView(),
        settings:
            RouteSettings(arguments: Future.delayed(Duration(seconds: 5))));
  }

  @override
  _LoginScreenMainViewState createState() =>
      _LoginScreenMainViewState(userRepository);
}

class _LoginScreenMainViewState extends State<LoginScreenMainView> {
  final AuthenticationRepository userRepository;

  final TextEditingController phoneNumberController = TextEditingController();
  String phoneNumber;
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
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  _LoginScreenMainViewState(this.userRepository);

  @override
  void initState() {
    super.initState();
    listCodeCountry = phoneCode[0];

    print(listCode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(userRepository),
      child: BlocListener<LoginCubit, LoginState>(
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                color: Colors.white,
                child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0),
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
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 2,
                                    height: 100,
                                    child: InputPhoneNumber(
                                      phoneNumberController: phoneNumberController,)
                                ),
                              ],
                            ),
                          ],),

                        Text(listCodeCountry + phoneNumberController.text),

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
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              VerificationScreenMainView(
                                                  smsCode: null,
                                                  phoneNumber: null)));
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
                                    child: Center(child: Text('Continue',
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
                              )
                            ],
                          ),
                        ),

                      ],
                    )),
              ))),
    );
  }
}

class InputPhoneNumber extends StatelessWidget {
  final TextEditingController phoneNumberController = TextEditingController();

  InputPhoneNumber({phoneNumberController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(buildWhen: (previous, current) => previous.phonenumber !=
        current.phonenumber, builder: (context, state) {
      return TextFormField(
        key: const Key('loginForm_PhoneNumber'),
        keyboardType: TextInputType.phone,
        controller: phoneNumberController,
        onChanged: (phoneNumber) =>
            context.bloc<LoginCubit>().PhoneNumberChanged(phoneNumber),
        decoration: InputDecoration(
          hintText: '821xxxxxxxxx',
          errorText: state.phoneNumber.invalid ? 'invalid PhoneNumbe/ r' : null,
        ),
      );
    });
  }

}

class ListItemCodePhoneCountry {
  String codePhone;
  String country;

  ListItemCodePhoneCountry({@required this.codePhone, @required this.country});
}
