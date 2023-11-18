

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:notes_ai/repositories/login_respository.dart';
import 'package:notes_ai/screens/home_screen.dart';
import 'package:notes_ai/screens/welcome_screen.dart';

import 'package:notes_ai/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'amplifyconfiguration.dart';
void main() {
  //timeDilation = 2.0;
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.

  bool loadedAmplify = false;
  Future<void> _initializeApp() async{
    await _configureAmplify();
  }


  Future<void> _configureAmplify() async {

    try{


      await Amplify.addPlugins([


        AmplifyAuthCognito(),
        AmplifyStorageS3(),
       AmplifyAPI(),

      ]);

      // Once Plugins are added, configure Amplify
      await Amplify.configure(amplifyconfig);

      if(Amplify.isConfigured){
        print('amplify configure');
        setState(() {
          loadedAmplify = true;
        });
      }else{
        setState(() {
          loadedAmplify = false;
        });
      }




    } catch(e) {
      setState(() {
        loadedAmplify = false;
      });
      if (kDebugMode) {
        print('an error occured during amplify configuration: $e');
      }



    }


  }


  @override
  void initState() {
    // TODO: implement initState
    _initializeApp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes AI',
    debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF131313),

          appBarTheme: const AppBarTheme(

            backgroundColor: Color(0xFFe76f51),
            iconTheme: IconThemeData(
                color: Colors.white
            )
          ),


          fontFamily: 'Montserrat',

          primaryColor: const Color(0xFF264653),
          colorScheme:ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFe76f51))




      ),
      home:  MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (BuildContext context) => SharedPrefsUtils.instance(),),
          ChangeNotifierProvider(create: (BuildContext context) => LoginRepository.instance(),),



        ],

       child: loadedAmplify ? WelcomeScreen() : const Center(
         child: CircularProgressIndicator(),
       ),
       // child:MainMenuScreen(),

      ),
    );
  }
}

