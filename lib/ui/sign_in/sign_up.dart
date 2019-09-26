import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ricinvestors/Widgets/FormCard2.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                    height: ScreenUtil.getInstance().setHeight(80),
                  ),
                  //-------------------------------------------------------------------
              new Container(
                width: double.infinity,
                height: ScreenUtil.getInstance().setHeight(790),
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
                      Text("Email",
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize:
                              ScreenUtil.getInstance().setSp(26))),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "username",
                            hintStyle: TextStyle(
                                color: Colors.grey, fontSize: 12.0)),
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(30),
                      ),
                      Text("Mobile",
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize:
                              ScreenUtil.getInstance().setSp(26))),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "+91",
                            hintStyle: TextStyle(
                                color: Colors.grey, fontSize: 12.0)),
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(30),
                      ),
                      Text("PassWord",
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize:
                              ScreenUtil.getInstance().setSp(26))),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Colors.grey, fontSize: 12.0)),
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(30),
                      ),
                      Text("PassWord",
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize:
                              ScreenUtil.getInstance().setSp(26))),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Re-enter Password",
                            hintStyle: TextStyle(
                                color: Colors.grey, fontSize: 12.0)),
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
                      )
                    ],
                  ),
                ),
              ),
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
                              onTap: () {},
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
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
