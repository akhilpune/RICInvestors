import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ricinvestors/CustomIcons.dart';
import 'package:ricinvestors/Widgets/SocialIcons.dart';
import 'package:ricinvestors/Widgets/loading.dart';
import 'package:ricinvestors/landing_page.dart';
import 'package:ricinvestors/main.dart';
import 'package:ricinvestors/services/auth.dart';

import 'package:ricinvestors/ui/sign_in/forgot_password.dart';


import 'package:ricinvestors/ui/sign_in/signup_new.dart';


import 'package:ricinvestors/utils/validator.dart';


import 'email_sign_in_model.dart';

class SignInPage extends StatefulWidget {
  SignInPage({@required this.model});
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      builder: (context) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (context, model, _) =>
            SignInPage(model: model),
      ),
    );
  }



  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  EmailSignInChangeModel get model => widget.model;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();


  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }


  bool _autoValidate = false;
  bool _loadingVisible = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submit() async {
    if (_formKey.currentState.validate()) {
    try {
      _changeLoadingVisible();
      await model.submit();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => LandingPage()),
      // );
    } on PlatformException catch (e) {
      Flushbar(
        title: "Sign In Failed",
        message: e.toString(),
        duration: Duration(seconds: 5),
      )
        ..show(context);
    }
  }
}
// void _emailLogin(
//     {String email, String password, BuildContext context}) async {
//   if (_formKey.currentState.validate()) {
//     try {
//       await model.submit();
//       Navigator.of(context).pop();
//     } catch (e) {
//       print("Sign In Error: $e");
//       String exception = AuthBase.getExceptionText(e);
//       Flushbar(
//         title: "Sign In Error",
//         message: exception,
//         duration: Duration(seconds: 5),
//       )..show(context);
//     }
//   } else {
//     setState(() => _autoValidate = true);
//   }
// }




  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);








    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body:  Stack(

        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/image01.png", height: 230),
              ),
              Expanded(
                child: Container(),
              ),
              Image.asset("assets/image02.png")
            ],
          ),
          SingleChildScrollView(


              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/logo.png",
                          width: ScreenUtil.getInstance().setWidth(110),
                          height: ScreenUtil.getInstance().setHeight(110),
                        ),
                        Text(" Investing \n Redefined",
                            style: TextStyle(
                                fontFamily: "Poppins-Bold",
                                fontSize: ScreenUtil.getInstance().setSp(20),
                                letterSpacing: .6,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(180),
                    ),
                    //**************************************************************************************************************************************

                    LoadingScreen(
                      child: new Container(
                        width: double.infinity,
                        //height: ScreenUtil.getInstance().setHeight(500),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 15.0),
                                  blurRadius: 15.0),
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, -10.0),
                                  blurRadius: 10.0),
                            ]),
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Login",
                                  style: TextStyle(
                                      fontSize: ScreenUtil.getInstance().setSp(45),
                                      fontFamily: "Poppins-Bold",
                                      letterSpacing: .6)),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              Text("Username",
                                  style: TextStyle(
                                      fontFamily: "Poppins-Medium",
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(26))),
                              //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            controller: _email,
                            validator: Validator.validateEmail,
                            decoration: InputDecoration(
                                hintText: "username",
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                            onChanged: model.updateEmail,
                            enabled: model.isLoading == false,
                          ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              Text("PassWord",
                                  style: TextStyle(
                                      fontFamily: "Poppins-Medium",
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(26))),
                              //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              autofocus: false,
                              obscureText: true,
                              controller: _password,
                              validator: Validator.validatePassword,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                              onChanged: model.updatePassword,
                              enabled: model.isLoading == false,
                            ),

                            SizedBox(
                                height: ScreenUtil.getInstance().setHeight(35),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ForgotPasswordScreen()),
                                      );
                                    },
                                    child: Text("Forgot Password?",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize:
                                                ScreenUtil.getInstance().setSp(28),
                                            fontFamily: "Poppins-Medium")),
                                  )
                                ],

                              ),
                            SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30)),
                            ],
                          ),
                        ),
                      ),


                        inAsyncCall: _loadingVisible ),
                    //----------------------------------------------------------------------------------
                    SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 50.0,
                            ),
                             SizedBox(
                              width: 8.0,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),


                InkWell(
                  child: Container(
                    width: ScreenUtil.getInstance().setWidth(330),
                    height: ScreenUtil.getInstance().setHeight(100),
                    decoration: BoxDecoration(
                        gradient:
                        LinearGradient(colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF6078ea).withOpacity(.3),
                              offset: Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {

                          //_changeLoadingVisible();
                          _submit();

                        },
                        child: Center(

                            child: setUpButtonChild(),

                        ),
                      ),
                    ),
                  ),
                ),

                ],
                        ),
                      ],
                    ),

                    //******************************************************************************************************************************************************
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        horizontalLine(),
                        Text("Social Login",
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: "Poppins-Medium")),
                        horizontalLine()
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialIcon(
                          colors: [
                            Color(0xFFff4f38),
                            Color(0xFFff355d),
                          ],
                          iconData: CustomIcons.googlePlus,
                          onPressed: () {},
                        ),
                        SocialIcon(
                          colors: [
                            Color(0xFF00c6fb),
                            Color(0xFF005bea),
                          ],
                          iconData: CustomIcons.linkedin,
                          onPressed: () {},
                        ),
                        Text(
                          "   New User? ",
                          style: TextStyle(fontFamily: "Poppins-Medium"),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Text("SignUp",
                              style: TextStyle(
                                  color: Color(0xFF5d74e3),
                                  fontSize: ScreenUtil.getInstance().setSp(30),
                                  fontFamily: "Poppins-Bold")),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ),

          )
        ],
      ),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  Widget setUpButtonChild() {
    if (_loadingVisible == false) {

     return  Text("SIGNIN",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins-Bold",
              fontSize: 18,
              letterSpacing: 1.0));

    } else if (_loadingVisible == true) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black26),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }



}
