import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/collection-model.dart';
import '../service/firebase_data.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final String docId;
  BookBloc(this.docId) : super(BookInitial()) {
    on<BookEvent>((event, emit) async{
      // TODO: implement event handler
      List<BooksModel> bookItems =[];
      emit(BookDataLoading());
      bookItems = await FirebaseServices().getBookList(docId);
      emit(BookDataLoaded(bookItems));
    });
  }
}
