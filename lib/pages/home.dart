import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final fullName = TextEditingController();
  final company = TextEditingController();
  final age = TextEditingController();
  addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': fullName.text, // John Doe
          'company': company.text, // Stokes and Sons
          'age': age.text // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots(includeMetadataChanges: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Home"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['full_name']),
                      subtitle: Text(data['company']),
                    );
                  }).toList(),
                );
              },
            ),


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
                          fontWeight: FontWeight.w500,
                          color: Colors.teal),
                    ),
                  ),

                  content:  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      TextField(
                          controller: fullName,
                          decoration: InputDecoration(
                            hintText: "Name",
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
                        controller: company,
                        decoration: InputDecoration(
                          hintText: "Company",
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(width: 3, color: Colors.grey),
                            borderRadius: BorderRadius.circular(50.0), //<-- SEE HERE
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: age,
                        decoration: InputDecoration(
                          hintText: "Age",
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
                            addUser();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(elevation: 10,
                              shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                // side: BorderSide(color: Colors.red),
                              )),
                          child:const Padding(
                            padding:  EdgeInsets.all(15.0),
                            child:  Text("Add User",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400
                            ),),
                          ))
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
