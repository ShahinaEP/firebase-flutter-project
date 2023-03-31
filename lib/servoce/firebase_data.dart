import '../models/user-model.dart';
import 'google-services.dart';

class FirebaseServices {
  Future<List<UsersModel>> getUserList() async {
    List<UsersModel> userList = [];
    await GoogleHelper.fireBaseStore.collection("users").get().then((value) {
      for (var element in value.docs) {
        UsersModel usersModel = UsersModel(
            userId: element["userId"],
            fullName: element["full_name"],
            company: element["company"],
            age: element["age"].hashCode //int value only
            );
        userList.add(usersModel);
      }
    });
    return userList;
  }

  addUsers(data) async {
    await GoogleHelper.fireBaseStore.collection('users').doc(data['userId']).set(data);
  }
  Future update(Map<String, dynamic> data, String docId)async{
    await GoogleHelper.fireBaseStore.collection("users").doc(docId).update(data);

  }
  delete(String docId)async{
    print(docId);
    await GoogleHelper.fireBaseStore.collection("users").doc(docId).delete();

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
