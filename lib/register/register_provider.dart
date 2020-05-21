import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_management_app/entity/type_bloc.dart';
import 'package:time_management_app/register/register_view.dart';


class Register extends StatelessWidget {
  // <- (※1)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<DTypeBloc>(
        create: (context) => new DTypeBloc(),
        dispose: (context, bloc) => bloc.dispose(),
        child: RegisterView(),
      ),
    );
  }
}