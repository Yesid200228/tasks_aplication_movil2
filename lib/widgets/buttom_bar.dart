
import 'package:flutter/material.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/model.dart';
import 'package:provider/provider.dart';
 import 'package:task_aplicattion2/widgets/snacbar_widget.dart';

import '../estilos/Colores_estilos.dart';
import '../providers/snacbar_provider.dart';
import '../providers/ui_provider.dart';



class ButtomNavigationBar extends StatefulWidget {

  @override
  State<ButtomNavigationBar> createState() => _ButtomNavigationBarState();
}

class _ButtomNavigationBarState extends State<ButtomNavigationBar> {
  String page = 'task';

  Colores _colores = Colores();

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);
    // final currentIndex = uiProvider.selectedMenuOpt;
    final snacbarProvider = Provider.of<SnacBarProvider>(context,listen: true);


    return PandaBar(
        buttonData: [
          PandaBarButtonData(
            id: 'task',
            icon: Icons.task_outlined,
            title: 'Tareas'
          ),
          PandaBarButtonData(
            id: 'activity',
            icon: Icons.local_activity_outlined,
            title: 'Actividades',
          ),
          PandaBarButtonData(
            id: 'favoritas',
            icon: Icons.person,
            title: 'Usuario',
          ),
        ],
        onChange: (id) {
            page = id;
            if (page=='activity') {
              uiProvider.selectedMenuOpt = 0;
                // Navigator.pushNamed(context, 'task');
            }
            if (page == 'task') {
              uiProvider.selectedMenuOpt = 1;
                // Navigator.pushNamed(context, 'activity');
            }
            // Navigator.pushNamed(context, routeName);
        },
        fabIcon: Icon(Icons.add),
        fabColors: [
          _colores.secondary,
          _colores.terciary,
        ],
        buttonSelectedColor: _colores.secondary,
        backgroundColor: _colores.terciary,
        onFabButtonPressed: () {
          if (uiProvider.selectedMenuOpt ==1) {
            Navigator.pushNamed(context, 'task').then((value) async {

              setState(() {
                mostrarSnacbar(
                  // status:  snacbarProvider.selectedStatusCode,
                  context: context,
                  typeModel: 'task',
                  typeConsult: 'post'
                );
              });
              snacbarProvider.selectedStatusCode = 0;

            });
          }
          if(uiProvider.selectedMenuOpt ==0){
            Navigator.pushNamed(context, 'activity');
          }
        },
      );
  }
}