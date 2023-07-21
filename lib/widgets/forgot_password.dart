
import 'package:adminsideofstage/widgets/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final  TextEditingController emailforgot =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.pink,
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? "Enter a valid email"
                        : null,
                controller: emailforgot,
                decoration: InputDecoration(
                  labelText: 'Enter email for reset password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            SizedBox(height: 16.0),
                        ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.pink)),
                onPressed: () {
                  
                verifyEmail();
                },
                child: Text('Reset Password'),
              ),
          ],
        ),
      ),
    );
  }
 
 Future verifyEmail() async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

  try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailforgot.text.trim());
  Utils.showSnackBar("password Reset Email Sent");
  Navigator.of(context).popUntil((route) => route.isFirst);
  }
  on FirebaseAuthException catch (e){
    print(e);
    Utils.showSnackBar(e.message);
    Navigator.pop(context);
  }
 }
}