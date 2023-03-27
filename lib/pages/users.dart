import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/users_bloc.dart';


class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<UsersBloc>().add(GetUsers());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        centerTitle: true,
      ),
      body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
        if (state is UsersLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UsersLoaded) {
          return ListView.builder(
              itemCount: state.usersModel.length,
              itemBuilder:(context, index){
                var data = state.usersModel[index];
                return

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title:Text(data.fullName.toString()),
                        subtitle:Text(data.company.toString()) ,
                      ),
                    ),
                  );
              }
          );
        } else if (state is UsersError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.red
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
