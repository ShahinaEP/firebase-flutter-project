part of 'users_bloc.dart';

@immutable
class UsersState extends Equatable{
  List<UsersModel> usersModel =[];
  UsersState({this.usersModel = const <UsersModel>[]});
  @override
  // TODO: implement props
  List<Object?> get props => [usersModel];
}

class UsersInitial extends UsersState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UsersLoading extends UsersState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UsersLoaded extends UsersState {

  List<UsersModel> usersModel;
  UsersLoaded(this.usersModel);
  @override
  // TODO: implement props
  List<Object?> get props => [usersModel];
}

// class AddUser extends UsersState{
//   // final UsersModel usersModel;
//   AddUser({required this.usersModel});
//   @override
//   // TODO: implement props
//   List<Object?> get props => [usersModel];
// }

class NotDataError extends UsersState  {
  final String notData;
  NotDataError(this.notData);

  @override
  // TODO: implement props
  List<Object?> get props => [notData];

}

class UsersError extends UsersState {

  String message;
  UsersError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
