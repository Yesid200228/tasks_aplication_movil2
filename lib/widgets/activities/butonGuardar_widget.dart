import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_aplicattion2/estilos/Colores_estilos.dart';
import 'package:task_aplicattion2/models/activity/activity_modelPost.dart';
import 'package:task_aplicattion2/providers/snacbar_provider.dart';
import 'package:task_aplicattion2/services/activity_service.dart';
import 'package:task_aplicattion2/widgets/snacbar_widget.dart';


Widget botonGuardar(
    {
      BuildContext context,
      ActivityModelPost activityModelPost,
      DateTime dateTime,
      DateTime dateTime2,
      String selected,
    }
  ){
    final snacbarProvider = Provider.of<SnacBarProvider>(context,listen: false);

    activityModelPost.dateEnd = dateTime2.toString();
    activityModelPost.dateStart = dateTime.toString();
    Colores _colores = Colores();
    ActivitiesService activitiesService = ActivitiesService();


    return Container(
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: _colores.secondary
        ),
        onPressed: () async {
          if (dateTime.isAfter(dateTime2)) {
            mostrarSnacbar(
              context: context,
              typeConsult: 'errorDateTime',
              typeModel: 'activities',
            );
          }else{
            if (selected == 'Seleccionar una Tarea') {
              mostrarSnacbar(
                context: context,
                typeConsult: 'errorTask',
                typeModel: 'activities',
              );
            }else{
              var respuesta = await activitiesService.createActivity(activityModelPost);
              snacbarProvider.selectedStatusCode = respuesta[0];
              snacbarProvider.selectedMessage = respuesta[1];

              if (respuesta[0]==200) {
                Navigator.pop(context);
              }

              if (respuesta[0]==400) {
                mostrarSnacbar(
                  context: context,
                  typeConsult: 'post',
                  typeModel: 'activities',
                );
              }else{
                Navigator.pop(context);
              }
            }
          }
        },
          child: Text('Guardar'),
        ),
    );
  }