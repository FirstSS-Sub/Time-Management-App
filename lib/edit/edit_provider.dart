import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_management_app/entity/models.dart';
import 'package:time_management_app/entity/type_bloc.dart';

import 'edit_view.dart';

// ignore: must_be_immutable
class Edit extends StatelessWidget { // <- (※1)
  DType task;
  Edit(this.task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<DTypeBloc>(
        create: (context) => new DTypeBloc(),
        dispose: (context, bloc) => bloc.dispose(),
        child: EditView(task),
      ),
    );
  }
}