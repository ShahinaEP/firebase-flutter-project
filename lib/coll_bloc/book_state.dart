part of 'book_bloc.dart';

@immutable
abstract class BookState extends Equatable{}

class BookInitial extends BookState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class BookDataLoading extends BookState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookDataLoaded extends BookState {
  List<BooksModel> booksModel;
  BookDataLoaded(this.booksModel);
  @override
  // TODO: implement props
  List<Object?> get props => [booksModel];
}

class BookMessage extends BookState {
  String message;
  BookMessage(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}