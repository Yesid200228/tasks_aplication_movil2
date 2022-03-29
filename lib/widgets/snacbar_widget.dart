  import 'package:flutter/material.dart';

void mostrarSnacbar({
  int status, BuildContext context,String typeModel,typeConsult
}) {
  // final scaffoldkey = GlobalKey<ScaffoldState>();
  String mensaje = '';
  Color _colorStatus;

  if (status==201 && typeModel=='task' && typeConsult =='post') {
    mensaje = 'Tarea Registra';
    _colorStatus = Colors.green;
  }
  if (status==200 && typeModel=='task' && typeConsult =='delete') {
    mensaje = 'Tarea Eliminada';
    _colorStatus = Colors.red;
  }
  if (status==200 && typeModel=='task' && typeConsult =='update') {
    mensaje = 'Tarea Actualizada';
    _colorStatus = Colors.blue;
  }

  var snackBar = SnackBar(
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    backgroundColor: _colorStatus,
    content: Text(
      mensaje,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    duration: Duration(milliseconds: 3000),
    );

    if (status == 0) {
    }else{
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    // scaffoldkey.currentState.showSnackBar(snackbar);
  }