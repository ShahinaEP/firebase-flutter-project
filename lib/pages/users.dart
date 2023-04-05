
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../component/create-collection.dart';
import '../component/create-user.dart';
import 'show-data.dart';
import '../component/update-user.dart';
import '../service/firebase_data.dart';
import '../bloc/users_bloc.dart';


class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.read<UsersBloc>().add(GetUsers());
    FirebaseServices services = FirebaseServices();

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
                        onTap: (){
                          services.getBookList(data.userId.toString());
                        },
                        title:Text(data.fullName.toString()),
                        subtitle:Text(data.company.toString()),
                        trailing: SizedBox(
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Icon(Icons.mode_edit_outline_outlined),
                              // Icon(Icons.delete),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>ShowBook(data.userId.toString(), data.fullName.toString())));
                                },
                                child:  Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius:const BorderRadius.all(Radius.circular(2))
                                  ),
                                  child:const Padding(
                                      padding:  EdgeInsets.fromLTRB(5, 5, 5, 5),
                                      child: Icon(Icons.visibility, color: Colors.teal,)
                                    // Text('Edit', style: TextStyle(
                                    //   color: Colors.white,
                                    //   fontWeight: FontWeight.w500,
                                    //   fontSize: 17
                                    // ),),
                                  ),
                                ),),
                              const SizedBox(width: 10,),
                              InkWell(
                                onTap: (){
                                  showDialog(context: context, builder: (_){
                                    return   AlertDialog(
                                        title: const Center(child: Text("Book Collection")),
                                        content: AddCollection(data)
                                    );
                                  });
                                },
                                child:  Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius:const BorderRadius.all(Radius.circular(2))
                                  ),
                                  child:const Padding(
                                      padding:  EdgeInsets.fromLTRB(5, 5, 5, 5),
                                      child: Icon(Icons.add,color: Colors.teal,)
                                    // Text('Edit', style: TextStyle(
                                    //   color: Colors.white,
                                    //   fontWeight: FontWeight.w500,
                                    //   fontSize: 17
                                    // ),),
                                  ),
                                ),),
                              const SizedBox(width: 10,),
                              InkWell(
                                onTap: (){
                                  showDialog(context: context, builder: (_){
                                    return   AlertDialog(
                                      title: const Center(child: Text("Update User")),
                                      content: UpdateUser(data)
                                    );
                                  });
                                },
                                child:  Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                      borderRadius: const BorderRadius.all(Radius.circular(2))
                                  ),
                                  child:const Padding(
                                    padding:  EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: Icon(Icons.edit, color: Colors.teal,)
                                    // Text('Edit', style: TextStyle(
                                    //   color: Colors.white,
                                    //   fontWeight: FontWeight.w500,
                                    //   fontSize: 17
                                    // ),),
                                  ),
                                ),),
                              const SizedBox(width: 10,),
                              InkWell(
                                onTap: (){
                                  // FirebaseFirestore.instance.collection('users').doc(data.userId.toString()).delete();
                                  // print(data.userId.toString());
                                  // FirebaseServices().delete(data.userId.toString()).then((value){
                                  //   context.read<UsersBloc>().add(GetUsers());
                                  // });
                                  services.delete(data.userId.toString());
                                  context.read<UsersBloc>().add(GetUsers());
                                },
                                child:  Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius:const BorderRadius.all(Radius.circular(2))
                                  ),
                                  child:const Padding(
                                    padding:  EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child:Icon(Icons.delete, color: Colors.teal,)
                                    // Text('Delete', style: TextStyle(
                                    //     color: Colors.white,
                                    //     fontWeight: FontWeight.w500,
                                    //     fontSize: 17
                                    // ),),
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

      floatingActionButton: const CreateUser(),
    );
  }

}
