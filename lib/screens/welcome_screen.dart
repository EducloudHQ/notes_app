import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

import '../repositories/login_respository.dart';
import '../utils/shared_preferences.dart';


class WelcomeScreen extends StatefulWidget {


  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var sharedPrefs = context.watch<SharedPrefsUtils>();
    var loginRepo= context.watch<LoginRepository>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body:  Stack(
alignment: Alignment.center,
        children: [
           Container(
             padding: EdgeInsets.symmetric(vertical: 30),
             child: Column(
         mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),

                    width: size.width/1.2,
                    height: size.height/18,


                    child: ElevatedButton(

                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))

                      ),
                      onPressed: ()=> {

                      },


                      child:const Text('Sign up with email',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 17, color: Colors.black),),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.white,
                          width: size.width/6,
                          height: 2,
                        ),
                        Container(
                          child: Text('or use social sign up',style: TextStyle(fontSize: 15,color: Colors.white),),
                        ),
                        Container(
                          color: Colors.white,
                          width: size.width/6,
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                 loginRepo.googleLoading? Container(
                   child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                 ): Container(
                    margin: EdgeInsets.only(bottom: 10),

                    width: size.width/1.2,
                    height: size.height/18,

                    child: ElevatedButton(

                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))

                        ),
                        onPressed: ()=> loginRepo.googleSignIn(context),


                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('assets/google.svg',height: 24,width: 24,color: Colors.red,),
                            const Text('Continue with Google',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15, color: Colors.black),),
                          ],
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10,top: 10),

                    width: size.width/1.2,
                    height: size.height/18,

                    child: ElevatedButton(

                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))

                        ),
                        onPressed: ()=> loginRepo.googleSignIn(context),


                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('assets/apple.svg',height: 24,width: 24,),
                            const Text('Continue with apple',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15, color: Colors.black),),
                          ],
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10,top: 10),

                    width: size.width/1.2,
                    height: size.height/18,

                    child: ElevatedButton(

                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))

                        ),
                        onPressed: ()=> loginRepo.googleSignIn(context),


                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('assets/facebook.svg',height: 24,width: 24),
                            const Text('Continue with facebook',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15, color: Colors.black),),
                          ],
                        )),
                  ),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account ?',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        TextButton(

                            onPressed: (){}, child: const Text('Log In',style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),))
                      ],
                    ),
                  )
                ],
              ),
           ),


          Container(
          margin: EdgeInsets.only(bottom: size.height/2),
            child: SvgPicture.asset('assets/notes_logo.svg', height: 80,
            color: Colors.white, ),
          ),
        ],
      ),


    );



  }
}
