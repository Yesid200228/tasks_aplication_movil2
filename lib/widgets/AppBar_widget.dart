import 'package:flutter/material.dart';
import 'package:task_aplicattion2/estilos/Colores_estilos.dart';

Widget appBar({String title}){
  Colores _colores = Colores();
  return AppBar(
    //app bar  con espacio para el titulo
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _colores.terciary,
            _colores.secondary,
            _colores.secondary,

          ],
        ),
      ),
    ),
    elevation: 0,
    title: Text(title),
    actions: [
      IconButton(
        onPressed: (){},
        icon: Icon(Icons.search)
      )
    ],
    );
}