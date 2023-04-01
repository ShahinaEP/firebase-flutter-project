import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/users_bloc.dart';
import '../service/firebase_data.dart';

class CreateUser extends StatelessWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    final fullName = TextEditingController();
    final company = TextEditingController();
    final age = TextEditingController();
    return  FloatingActionButton(
      onPressed: (){
        showDialog(
            context: context,
            builder: (_){
              return AlertDialog(
                title:const  Center(
                  child:  Text(
                    "User Add",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),

                content:  Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    TextField(
                        controller: fullName,
                        decoration:  const InputDecoration(
                            hintText: "Name",
                            hintStyle: TextStyle(
                                color: Colors.teal
                            )
                          // label: Text("Name")
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide:
                          //   const BorderSide(width: 3, color: Colors.grey),
                          //   borderRadius:
                          //   BorderRadius.circular(50.0), //<-- SEE HERE
                          // ),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: company,
                      decoration: const InputDecoration(
                          hintText: "Company",
                          hintStyle: TextStyle(
                              color: Colors.teal
                          )
                        // enabledBorder: OutlineInputBorder(
                        //   borderSide:
                        //   const BorderSide(width: 3, color: Colors.grey),
                        //   borderRadius: BorderRadius.circular(50.0), //<-- SEE HERE
                        // ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: age,
                      decoration: const InputDecoration(
                          hintText: "Age",
                          hintStyle: TextStyle(
                              color: Colors.teal
                          )
                        // enabledBorder: OutlineInputBorder(
                        //   borderSide:
                        //   const BorderSide(width: 3, color: Colors.grey),
                        //   borderRadius: BorderRadius.circular(50.0), //<-- SEE HERE
                        // ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              var data ={
                                "userId":"user-${DateTime.now().microsecondsSinceEpoch}",
                                "full_name":fullName.text,
                                "company":company.text,
                                "age":age.text,
                              };
                              // var usermodel = UsersModel(
                              //   userId: data['userId'],
                              //   fullName: fullName.text,
                              //   company: company.text,
                              //   age: age.text.hashCode,
                              // );
                              services.addUsers(data);
                              context.read<UsersBloc>().add(GetUsers());
                              // context.read<UsersBloc>().add(AddUser(usersModel: usermodel));
                              fullName.clear();
                              company.clear();
                              age.clear();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(elevation: 10,
                                shape:  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  // side: BorderSide(color: Colors.red),
                                )),
                            child:const Padding(
                              padding:  EdgeInsets.all(8.0),
                              child:  Text("Add",style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500
                              ),),
                            )),
                      ],
                    )
                  ],
                ),
              );
            }
        );
      },
      child: Icon(Icons.add),
    );
  }
}



