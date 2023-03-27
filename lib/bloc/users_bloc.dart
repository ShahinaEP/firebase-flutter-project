import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/user-model.dart';
import '../servoce/firebase_data.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  List<UsersModel> usersModel =[];
  UsersBloc() : super(UsersInitial()) {
    FirebaseServices service = FirebaseServices();
    on<UsersEvent>((event, emit) async{
      // TODO: implement event handler

      try{
        emit(UsersLoading());
        usersModel = await service.getUserList();
        emit(UsersLoaded(usersModel));
      }catch(e){
        emit(UsersError(e.toString()));
      }
    });
  }
}
