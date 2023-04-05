import 'package:firesore_flutter/coll_bloc/book_bloc.dart';
import 'package:firesore_flutter/pages/show_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/firebase_data.dart';

class ShowBook extends StatelessWidget {
  var docId;
  var name;
   ShowBook(  this.docId,this.name, { Key? key}) : super(key: key);
  FirebaseServices firebaseServices =  FirebaseServices();
  @override
  Widget build(BuildContext context) {
    // firebaseServices.getBookList(docId);
    return Scaffold(
      appBar: AppBar(
        title:  Text(name.toString()),
        centerTitle: true,
      ),
      body:BookItem(docId) ,
    );
  }

}

Widget BookItem(docId){

  return BlocProvider(create: (_)=> BookBloc(docId)..add(AllBook()),
      child: BlocBuilder<BookBloc, BookState>(
        builder: (context, state){
          if(state is BookDataLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is BookDataLoaded){
            return ListView.builder(
                itemCount: state.booksModel.length,
                itemBuilder: (context, index){
              var data = state.booksModel[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>ShowPdf(data.name, data.link)));
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: Text(data.name![0], style: const TextStyle(fontWeight: FontWeight.w600),),),
                      title: Text(data.name.toString(),style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),),
                    ),
                  ),
                ),
              );
            });
          }else if(state is BookMessage){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Text( state.message,style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),)
              ],
            );
          }
          else{
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                    Text("No Data",style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),)
              ],
            );
          }
        }
      ),
  );
}
