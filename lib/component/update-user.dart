import 'package:firesore_flutter/models/user-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/users_bloc.dart';
import '../servoce/firebase_data.dart';

class UpdateUser extends StatelessWidget {
  var data;
   UpdateUser(this.data, { Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    final fullName = TextEditingController();
    final company = TextEditingController();
    final age = TextEditingController();
    fullName.text = data.fullName;
    company.text = data.company;
    age.text = data.age.toString();
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

                        var update ={
                          "full_name":fullName.text,
                          "company":company.text,
                          "age":age.text,
                        };

                        services.update(update, data.userId.toString());
                        Navigator.pop(context);
                        context.read<UsersBloc>().add(GetUsers());
                        // FirebaseServices().update({
                        //
                        // },data).then((value){
                        //
                        //
                        // });
                      }, child: const Text("Edit")),
                    ],
                  )
                ],

        );
    // };
  }
}
