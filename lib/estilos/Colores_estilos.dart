
import 'package:flutter/material.dart';

class Colores{
  final Color primary = Color(0xFFEEEEEE);
  final Color secondary  = Color(0xFF00ADB5);
  final Color terciary  = Color(0xFF393E46);
  final Color cuaternary = Color(0xFF222831);

  getColor() {
  final Color red = Color(0xFFF44336);
  final Color cyan = Color(0xFF00BCD4);
  final Color purple = Color(0xFF9C27B0);
  final Color indigo = Color(0xFF3F51B5);
  final Color pink = Color(0xFFE91E63);
  final Color blue = Color(0xFF2196F3);
  final Color deepPurple = Color(0xFF673AB7);
  final Color green = Color(0xFF4CAF50);
  final Color teal = Color(0xFF009688);
  final Color lightBlue = Color(0xFF03A9F4);
    //retornar lista de colores
    List<Color> list = [red, cyan, purple, indigo, pink, blue, deepPurple, green, teal, lightBlue];
    //retronar una lista de colores  que cuando llegue al final del listado regrese al principio
    // print(TaskProvider().listTasks.length);
    print(list.length);
    return list;
  }

  Color getColoresSnacBar({String color}){
    if (color=='green') return Colors.green;
    if (color=='red') return Colors.red;
    if (color=='yellow') return Colors.yellow.shade800;

  }
}