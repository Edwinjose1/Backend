
import 'package:adminsideofstage/widgets/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/log_in_screen.dart';


Future main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   runApp(const Myapp());}
final navigatorKey=GlobalKey<NavigatorState>();
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasError)
          {
            return Center(child: Text("something went wrong"),);
          }
          else if(snapshot.hasData)
          {
            return const HomeScreen();
          }
          else {
            return LoginPage();
          }
        }
      ),
    );
  }
}

