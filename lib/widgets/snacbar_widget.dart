  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_aplicattion2/estilos/Colores_estilos.dart';

import '../providers/snacbar_provider.dart';

void mostrarSnacbar({
   BuildContext context,String typeModel,typeConsult,mensaje
}) {
  // final scaffoldkey = GlobalKey<ScaffoldState>();
  String mensaje = '';
  Color _colorStatus;
  Colores _colores = Colores();
  
    final snacbarProvider = Provider.of<SnacBarProvider>(context,listen: false);
    var status = snacbarProvider.selectedStatusCode;


  if (status==201 && typeModel=='task' && typeConsult =='post') {
    mensaje = 'Tarea Registrada';
    _colorStatus = _colores.getColoresSnacBar(color: 'green');
  }
  if (status==200 && typeModel=='task' && typeConsult =='delete') {
    mensaje = 'Tarea Eliminada';
    _colorStatus = _colores.getColoresSnacBar(color: 'red');
  }
  if (status==200 && typeModel=='task' && typeConsult =='update') {
    mensaje = 'Tarea Actualizada';
    _colorStatus = _colores.getColoresSnacBar(color: 'yellow');
  }

  if (status==400 && typeConsult =='post') {
    mensaje = snacbarProvider.selectedMessage;
    _colorStatus = _colores.getColoresSnacBar(color: 'yellow');
  }

  if (typeConsult =='errorDateTime' && typeModel=='activities') {
    mensaje = 'La Fecha inicio no puede ser mayor a la final';
    _colorStatus = _colores.getColoresSnacBar(color: 'yellow');
  }
  if(typeConsult=='errorTask' && typeModel=='activities'){
    mensaje = 'Seleccione una tarea';
    _colorStatus = _colores.getColoresSnacBar(color: 'yellow');
  }
  if(typeModel=='task' && typeConsult=='delete' && status==409){
    mensaje = snacbarProvider.selectedMessage;
    _colorStatus = _colores.getColoresSnacBar(color: 'yellow');
  }

  var snackBar = SnackBar(
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    backgroundColor: _colorStatus,
    content: Text(
      mensaje==null ? '' : mensaje,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    duration: Duration(milliseconds: 2200),
    );

    if (status == 0) {
    }else{
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    // scaffoldkey.currentState.showSnackBar(snackbar);
  }