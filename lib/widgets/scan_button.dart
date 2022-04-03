import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../estilos/Colores_estilos.dart';
import '../providers/ui_provider.dart';

class ScanButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    Colores _colores = Colores();

    return FloatingActionButton(
      backgroundColor: _colores.primary,
      elevation: 0,
      onPressed: () {
        if (currentIndex==0) {
          Navigator.pushNamed(context, 'activity');
        }
        if (currentIndex==1) {
          Navigator.pushNamed(context, 'task');
        }
      },
      child: Icon(Icons.add,color: _colores.terciary),
    );
  }
}