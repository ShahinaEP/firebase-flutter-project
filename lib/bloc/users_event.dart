part of 'users_bloc.dart';

@immutable
abstract class UsersEvent extends Equatable{}

class GetUsers extends UsersEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class AddUser extends UsersEvent{
  final UsersModel usersModel;
  AddUser({required this.usersModel});
  @override
  // TODO: implement props
  List<Object?> get props => [usersModel];
}
