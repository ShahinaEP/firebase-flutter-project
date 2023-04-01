import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/users_bloc.dart';
import '../service/firebase_data.dart';

class AddCollection extends StatelessWidget {
  var data;
  AddCollection(this.data, { Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    final fullName = TextEditingController();
    final amount = TextEditingController();
    fullName.text = data.fullName;
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller:fullName ,
          decoration: const InputDecoration(
              hintText: "Name"
          ),
        ),
        const SizedBox(height: 15,),
        

        const SizedBox(height: 15,),
        TextField(
          controller:amount ,
          decoration: const InputDecoration(
             hintText: "Amount"
          ),
        ),
        const SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: (){

              var collection ={
                "collectionId":"collection-${DateTime.now().microsecondsSinceEpoch}",
                "name":fullName.text,
                "amount":amount.text.toString(),
                "createTime":DateTime.now()
              };

              services.addSubCollection(collection, data.userId.toString());
              Navigator.pop(context);
              context.read<UsersBloc>().add(GetUsers());
              // FirebaseServices().update({
              //
              // },data).then((value){
              //
              //
              // });
            }, child: const Text("add")),
          ],
        )
      ],

    );
    // };
  }
}
