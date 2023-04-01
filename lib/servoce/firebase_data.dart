import '../models/user-model.dart';
import 'google-services.dart';
import 'package:intl/intl.dart';
class FirebaseServices {
  Future<List<UsersModel>> getUserList() async {
    List<UsersModel> userList = [];
    await GoogleHelper.fireBaseStore.collection("users").get().then((value) {
      for (var element in value.docs) {
        UsersModel usersModel = UsersModel(
            userId: element["userId"],
            fullName: element["full_name"],
            company: element["company"],
            age: element["age"]
            );
        userList.add(usersModel);
      }
    });
    return userList;
  }

  addUsers(data) async {
    await GoogleHelper.fireBaseStore.collection('users').doc(data['userId']).set(data);
  }
  update(data,  docId)async{
    print(docId);
    print(data);
   await GoogleHelper.fireBaseStore.collection("users").doc(docId).update({
      "full_name":data['full_name'],
      "company":data['company'],
      "age":data['age'],
     "userId":docId
    }).then((_) => print('Success'))
       .catchError((error) => print('Failed: $error'));

  }
  delete(String docId)async{
    await GoogleHelper.fireBaseStore.collection("users").doc(docId).delete();

  }


  addSubCollection(collection,data)async{
    await GoogleHelper.fireBaseStore.collection('users').doc(data).collection(data).doc(collection['collectionId']).set(collection);
  }
  Future<List<UsersModel>?> deleteUser(documentId) async {
    await GoogleHelper.fireBaseStore
        .collection('users')
        .doc(documentId)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
