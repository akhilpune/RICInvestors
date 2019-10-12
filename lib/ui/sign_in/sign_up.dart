/*
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ricinvestors/Widgets/loading.dart';
import 'package:ricinvestors/services/auth.dart';
import 'package:ricinvestors/ui/property_list.dart';
import 'package:flushbar/flushbar.dart';
import 'package:ricinvestors/utils/validator.dart';

import 'email_sign_up_model.dart';


class SignUpPage extends StatefulWidget {
  SignUpPage({@required this.model});
  final EmailSignUpChangeModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<EmailSignUpChangeModel>(
      builder: (context) => EmailSignUpChangeModel(auth: auth),
      child: Consumer<EmailSignUpChangeModel>(
        builder: (context, model, _) =>
            SignUpPage(model: model),
      ),
    );
  }




  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKeySignUp = GlobalKey<FormState>();
  final TextEditingController _cname = new TextEditingController();
  final TextEditingController _cmobile = new TextEditingController();
  final TextEditingController _cemail = new TextEditingController();
  final TextEditingController _cpassword = new TextEditingController();
  EmailSignUpChangeModel get model => widget.model;



  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _autoValidate = false;
  bool _loadingVisible = false;


  @override
  void initState() {
    super.initState();
  }

  AuthBase authBase;



  Future<void> _createUser() async {
    if (_formKeySignUp.currentState.validate()) {
      try {
         //model.updateWith(email: cemail.text,password: cpassword.text,name: cname.text,mobile: cmobile.text,isLoading: true,submitted: true);
         await model.createUser();




      } on PlatformException catch (e) {
        String exception = authBase.getExceptionText(e);
        Flushbar(
          title: "Sign In Failed",
          message: exception,
          duration: Duration(seconds: 5),
        )
          ..show(context);
      }
      finally{
           Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => PropertyList(),
                  ),
           );
             }
    }
  }


  @override
  void dispose() {
    _cemail.dispose();
    _cpassword.dispose();
    _cname.dispose();
    _cmobile.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }


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
      body: Stack(
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
                key: _formKeySignUp,
                autovalidate: _autoValidate,
                child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0,bottom: 10.0),
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
                      height: ScreenUtil.getInstance().setHeight(80),
                    ),
                    //-------------------------------------------------------------------
                LoadingScreen(
                  child: new Container(
                    width: double.infinity,
                   // height: ScreenUtil.getInstance().setHeight(790),
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
                          Text("Register",
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(45),
                                  fontFamily: "Poppins-Bold",
                                  letterSpacing: .6)),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Text("Full Name",
                              style: TextStyle(
                                  fontFamily: "Poppins-Medium",
                                  fontSize:
                                  ScreenUtil.getInstance().setSp(26))),
                          //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                          TextFormField(
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            textCapitalization: TextCapitalization.words,
                            controller: _cname,
                            validator: Validator.validateName,
                            decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 12.0)),
                            onChanged: model.updateName1,
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Text("Mobile ",
                              style: TextStyle(
                                  fontFamily: "Poppins-Medium",
                                  fontSize:
                                  ScreenUtil.getInstance().setSp(26))),
                          //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                          TextFormField(
                            autofocus: false,
                            textCapitalization: TextCapitalization.words,
                            controller: _cmobile,
                            validator: Validator.validateNumber,
                            maxLength: 10,
                            decoration: InputDecoration(
                                hintText: "+91",
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 12.0)),
                           // onChanged: model.updateMobile,
                            keyboardType: TextInputType.numberWithOptions(),
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Text("Email",
                              style: TextStyle(
                                  fontFamily: "Poppins-Medium",
                                  fontSize:
                                  ScreenUtil.getInstance().setSp(26))),
                          //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            controller: _cemail,
                            validator: Validator.validateEmail,
                            decoration: InputDecoration(
                                hintText: "Email-ID",
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 12.0)),
                           // onChanged: model.updateEmail,

                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Text("PassWord",
                              style: TextStyle(
                                  fontFamily: "Poppins-Medium",
                                  fontSize:
                                  ScreenUtil.getInstance().setSp(26))),
                          //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                          TextFormField(
                            autofocus: false,
                            obscureText: true,
                            controller: _cpassword,
                            validator: Validator.validatePassword,
                            decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 12.0)),
                          //  onChanged: model.updatePassword,
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(35),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(" Back to Login",
                                    style: TextStyle(
                                        color: Color(0xFF5d74e3),
                                        fontSize:

                                        ScreenUtil.getInstance().setSp(30),
                                        fontFamily: "Poppins-Bold")),

                              ),
                            ],
                          ),
                          SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                        ],
                      ),
                    ),
                  ),


                    inAsyncCall: _loadingVisible       ),
                    //-------------------------------------------------------------------
                    SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[


                        InkWell(
                          child: Container(

                            width: ScreenUtil.getInstance().setWidth(330),
                            height: ScreenUtil.getInstance().setHeight(100),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xFF17ead9),
                                  Color(0xFF6078ea)
                                ]),
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

                                                 // widget.model.updateWith(email: cemail.text ,password: cpassword.text,name: cname.text ,mobile: cmobile.text ,isLoading: true ,submitted: true);
                                  _createUser();



                                },
                                child: Center(
                                  child: Text("REGISTER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 18,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
                      ],
                    ),
                  ],
                ),
              ),
          ),

          )
        ],
      ) ,
    );
  }




 /*
  void _emailSignUp(
      {String name,
        String mobile,
        String email,
        String password,
        BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        //need await so it has chance to go through error if found.
        String uID = await Auth.signUp(email, password);

          await Auth.addUserSettingsDB(new User(
            userId: uID,
            email: email,
            name: name,
            mobile: mobile,
          ));

        //now automatically login user too
        await StateWidget.of(context).logInUser(email, password);
        //await Navigator.pushNamed(context, '/signin');
      } catch (e) {
        _changeLoadingVisible();
        print("Sign Up Error: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "Sign Up Error",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
*/

//  Future<void> _submit1() async {
//    if (_formKey.currentState.validate()) {
//      try {
//
//
//        await model.submitCreate();
//
//      } on PlatformException catch (e) {
//        Flushbar(
//          title: "Sign Up Failed",
//          message: e.toString(),
//          duration: Duration(seconds: 5),
//        )
//          ..show(context);
//      } finally {
//
//        Navigator.push(
//          context,
//          MaterialPageRoute(
//              builder: (context) => PropertyList()),
//        );
//
//      }
//    }
//  }
//

}

*/

