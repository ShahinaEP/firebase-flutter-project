import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user-model.dart';
import '../servoce/firebase_data.dart';
import '../bloc/users_bloc.dart';


class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    context.read<UsersBloc>().add(GetUsers());

    final fullName = TextEditingController();
    final company = TextEditingController();
    final age = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        centerTitle: true,
      ),
      body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
        if (state is UsersLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UsersLoaded) {
          return ListView.builder(
              itemCount: state.usersModel.length,
              itemBuilder:(context, index){
                var data = state.usersModel[index];
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title:Text(data.fullName.toString()),
                        subtitle:Text(data.company.toString()) ,
                        trailing: SizedBox(
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Icon(Icons.mode_edit_outline_outlined),
                              // Icon(Icons.delete),
                              InkWell(
                                child:  Container(
                                  decoration:const BoxDecoration(
                                    color: Colors.teal,
                                      borderRadius: BorderRadius.all(Radius.circular(2))
                                  ),
                                  child:const Padding(
                                    padding:  EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Text('Edit', style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17
                                    ),),
                                  ),
                                ),),
                              const SizedBox(width: 10,),
                              InkWell(
                                child:  Container(
                                  decoration:const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(Radius.circular(2))
                                  ),
                                  child:const Padding(
                                    padding:  EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Text('Delete', style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17
                                    ),),
                                  ),
                                ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
              }
          );
        } else if (state is UsersError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.red
              ),
            ),
          );
        } else{
          return  const Center(
            child:  Text("No data", style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.red
            ),),
          );
        }
      }),

      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }

}
