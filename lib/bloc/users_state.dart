part of 'users_bloc.dart';

@immutable
abstract class UsersState extends Equatable{}

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

class UsersError extends UsersState {

  String message;
  UsersError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
