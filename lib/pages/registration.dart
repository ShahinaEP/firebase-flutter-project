import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final email = TextEditingController();
  final pass = TextEditingController();
  registration() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      );
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
      appBar: AppBar(
        title:const Text(
          "My Registration Page",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            // color: Colors.teal
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        const Text(
                          "My Registration From",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.teal),
                        ),
                        const SizedBox(
                          height: 55,
                        ),
                        TextField(
                            controller: email,
                            decoration: InputDecoration(
                              hintText: "E-mail",
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 3, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.circular(50.0), //<-- SEE HERE
                              ),
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: pass,
                          decoration: InputDecoration(
                            hintText: "Password",
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 3, color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0), //<-- SEE HERE
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              registration();
                            },
                          style: ElevatedButton.styleFrom(elevation: 10,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                                // side: BorderSide(color: Colors.red),
                              )),
                            child:const Padding(
                              padding:  EdgeInsets.all(15.0),
                              child:  Text("Registration",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400
                              ),),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
