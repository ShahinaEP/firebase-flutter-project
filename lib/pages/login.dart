import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final pass = TextEditingController();

  login()async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      );
      if(credential.user != null){
        print("Login");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35,),
              TextField(
                controller: email,
                decoration:const InputDecoration(
                  hintText: "E-mail"
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: pass,
                decoration: const InputDecoration(
                  hintText: "Password"
                ),
              ),
              const SizedBox(height: 15,),

              TextButton(onPressed: (){login();}, child:const Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
