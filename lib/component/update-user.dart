import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/users_bloc.dart';
import '../servoce/firebase_data.dart';

class UpdateUser extends StatelessWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    final fullName = TextEditingController();
    final company = TextEditingController();
    final age = TextEditingController();
    final String data ="";
      return  Column(
        mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller:fullName ,
                  ),
                  const SizedBox(height: 15,),
                  TextField(
                    controller:company ,
                  ),

                  const SizedBox(height: 15,),
                  TextField(
                    controller:age ,
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: (){

                        FirebaseServices().update({
                          "full_name":fullName.text,
                          "company":company.text,
                          "age":age.text,
                        },data).then((value){
                          Navigator.pop(context);
                          context.read<UsersBloc>().add(GetUsers());

                        });
                      }, child: const Text("Edit")),
                    ],
                  )
                ],

        );
    // };
  }
}
