import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_chat_2023/api/apis.dart';
import 'package:we_chat_2023/auth/login_screen.dart';
import 'package:we_chat_2023/screens/home_screen.dart';

import '../main.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white, statusBarColor: Colors.white));
        // if(APIs.auth.currentUser != null){
        //   print("User: ${APIs.auth.currentUser}");
        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        // }else{
        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        // }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));

    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Welcome to We Chat"),
      ),
      body: Stack(
        children: [
          Positioned(
              top: mq.height * .15,
              right: mq.width * .25,
              width: mq.width * .5,
              child: Image.asset('assets/image/icon.png')),
          Positioned(
            bottom: mq.height * .15,
            width: mq.width,
            child: const Text("MADE IN INDIA WITH",
              textAlign: TextAlign.center,
              style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),),
          )
        ],
      ),
    );
  }
}
