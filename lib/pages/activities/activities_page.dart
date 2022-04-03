import 'package:flutter/material.dart';
import 'package:flutter_dropdown_x/flutter_dropdown_x.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_aplicattion2/estilos/Colores_estilos.dart';
import 'package:task_aplicattion2/providers/snacbar_provider.dart';
import 'package:task_aplicattion2/providers/task_provider.dart';
import 'package:task_aplicattion2/services/activity_service.dart';
import 'package:task_aplicattion2/widgets/activities/butonGuardar_widget.dart';
import 'package:task_aplicattion2/widgets/snacbar_widget.dart';

import '../../models/activity/activity_modelPost.dart';


class ActivitiesPage extends StatefulWidget {

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();

  ActivityModelPost activityModelPost =  ActivityModelPost();
  ActivitiesService activitiesService = ActivitiesService();

  Colores _colores = Colores();
  DateTime dateTime;
  DateTime dateTime2;

  String _selected = "";


  @override
  void initState() {
      super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final taskProvider = Provider.of<TaskProvider>(context,listen: false);

    // actualizarCard();

    setState(() {
      taskProvider.selectedTask;
    });
    return Scaffold(
       key: scaffoldkey,
      appBar: AppBar(
        backgroundColor: _colores.secondary,
        title: Text('Crear Actividades',style: TextStyle(color:_colores.primary ),),
        actions: [
        ],
        centerTitle: true,
      ),
        body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 30),
                title('Escoger fechas'),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Column(children: [
                      // title('Fecha Inicio'),
                      SizedBox(height: 20),
                      buttonFecha(context,dateTime,'inicio'),
                    ]),
                  Column(children: [
                    // title('Fecha final'),
                      SizedBox(height: 20),
                    buttonFecha(context,dateTime2,'final'),
                  ]),
                ],
                ),

                // buttonTareas(context),
                SizedBox(height: 30),
                combox(),
                // cardSeleccionada(),
                SizedBox(height: 50),
                botonGuardar(
                  context: context,
                  activityModelPost: activityModelPost,
                  dateTime: dateTime,
                  dateTime2: dateTime2,
                  selected: _selected,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void actualizarCards(){
    setState(() {
      // cardSeleccionada();
    });
  }

  Widget buttonFecha(BuildContext context,DateTime _dateTime,String fecha){
    return Container(
      width: 160,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Fecha',
          helperText: fecha == 'inicio' ? 'Seleccione Fecha Inicio' : 'Seleccione Fecha Final',
          suffixIcon: GestureDetector(child: Icon(Icons.calendar_today), onTap:(){ pickDateTime(context,_dateTime, fecha);}),
        ),
        onTap: (){
          // pickDateTime(context,_dateTime, fecha);
        },
        controller: TextEditingController(text: getText(fecha)),
      ),
    );
  }


  Widget title(String mensaje){
  return Container(
    alignment: Alignment.bottomCenter, child:
    Text(mensaje, style: TextStyle(color: _colores.terciary,fontWeight: FontWeight.bold,fontSize: 20)));
  }

  Future pickDateTime(BuildContext context,_dateTime,fecha) async {

    if (fecha=='inicio') {
      final date = await pickDate(context);
      if (date == null) return;

      final time = await pickTime(context);
      if (time == null) return;
      setState(() {
        dateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      });
    }

  if (fecha =='final') {
      final date2 = await pickDate(context);
      if (date2 == null) return;

      final time2 = await pickTime(context);
      if (time2 == null) return;
      setState(() {
        dateTime2 = DateTime(
          date2.year,
          date2.month,
          date2.day,
          time2.hour,
          time2.minute,
        );
      });
    }
  }

  String getText(String fecha){
    if (fecha=='inicio') {
      if (dateTime == null) {
        return '2022-01-01 00:00:00';
      }else{
        return DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime);
      }
    }
    if (fecha=='final') {
      if (dateTime2 == null) {
        return '2022-01-01 00:00:00';
      }else{
        return DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime2);
      }
    }
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return null;

    return newDate;
  }

 Future<TimeOfDay> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
        ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute,)
        : initialTime,
    );

  if (newTime == null) return null;

  return newTime;
  }

  // Widget buttonTareas(BuildContext context) {
  //   return ElevatedButton(
  //     onPressed: (){
  //       // modalProvider.selectedModal = showMaterialDialog(context);

  //       // alertDialog(context);
  //       showMaterialDialog(context);
  //     },
  //     child: Text('Seleccionar tarea')
  //   );
  // }

  Widget combox(){
    final taskProvider = Provider.of<TaskProvider>(context,listen: false);

  List<dynamic> dataSource = [];


    taskProvider.listTasks.forEach((item) {
      dataSource.add({"id": item.id, "name": item.name});
    });
  print(_selected);
  activityModelPost.taskId = _selected;


// //     var item = taskProvider.listTaskModelGet ;
    return  DropDownField(
      value: _selected,
      hintText: 'Seleccionar una Tarea',
      dataSource: dataSource,
      onChanged: (v) {
        print(v);
        setState(() {
          _selected = v;
        });
      },
      valueField: 'id',
      textField: 'name',
    );
  }

  // Widget botonGuardar(){

  //   activityModelPost.dateEnd = dateTime2.toString();
  //   activityModelPost.dateStart = dateTime.toString();
  //   final snacbarProvider = Provider.of<SnacBarProvider>(context,listen: false);

  //   return Container(
  //     width: 150,
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         primary: _colores.secondary
  //       ),
  //       onPressed: () async {
  //         if (dateTime.isAfter(dateTime2)) {
  //           mostrarSnacbar(
  //             context: context,
  //             typeConsult: 'errorDateTime',
  //             typeModel: 'activities',
  //           );
  //         }else{
  //           if (_selected == 'Seleccionar una Tarea') {
  //             mostrarSnacbar(
  //               context: context,
  //               typeConsult: 'errorTask',
  //               typeModel: 'activities',
  //             );
  //           }else{
  //             var respuesta = await activitiesService.createActivity(activityModelPost);
  //             snacbarProvider.selectedStatusCode = respuesta[0];
  //             snacbarProvider.selectedMessage = respuesta[1];

  //             if (respuesta[0]==200) {
  //               Navigator.pop(context);
  //             }

  //             if (respuesta[0]==400) {
  //               mostrarSnacbar(
  //                 context: context,
  //                 typeConsult: 'post',
  //                 typeModel: 'activities',
  //               );
  //             }else{
  //               Navigator.pop(context);
  //             }
  //           }
  //         }
  //       },
  //         child: Text('Guardar'),
  //       ),
  //   );
  // }


}