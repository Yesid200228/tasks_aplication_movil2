// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_aplicattion2/providers/snacbar_provider.dart';

import '../../estilos/Colores_estilos.dart';
import '../../models/tareas/task_modelGet.dart';
import '../../models/tareas/task_modelPost.dart';
import '../../providers/ui_provider.dart';
import '../../services/tasks_service.dart';
import '../../widgets/snacbar_widget.dart';
import '../../widgets/textFormField_task_widget.dart';

class TaskPage extends StatefulWidget {
  // TaskPage({Key key, @required this.animalCard}) : super(key: key);

  final TaskModelGet taskModelGet;
  TaskPage({
    this.taskModelGet,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final tasksService = TasksService();


  

  TaskModelPost taskModelPost = TaskModelPost();
  TaskModelGet taskModelGet = TaskModelGet();

  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    final TaskModelGet taskDataGet = ModalRoute.of(context).settings.arguments;

    Colores _colores = Colores();

    
    // bool tipo = ModalRoute.of(context).settings.arguments;
    taskModelGet = taskDataGet;


    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        backgroundColor: _colores.teal,
        title: Text(
          'Crear tareas',
          style: TextStyle(color: _colores.space),
        ),
        actions: [],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(50.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // _crearName(_colores),
                formField(
                  type: 'name',
                  icon: Icon(Icons.task_outlined,color: _colores.grey),
                  hintext: 'Ir a la universidad',
                  labelText: 'Nombre de la tarea',
                  taskModelGet: taskModelGet,
                  taskModelPost: taskModelPost,
                  validatorFalse:  'Ingrese el nombre de la tarea',
                  validatorTrue: 'La tarea no puede contener mas de 45 caracteres',
                ),
                SizedBox(height: 20,),
                formField(
                  type: 'descripcion',
                  icon: Icon(Icons.description_outlined),
                  hintext: 'Ir al Bloque I',
                  labelText: 'Descripcion',
                  taskModelGet: taskModelGet,
                  taskModelPost: taskModelPost,
                  validatorFalse:  '',
                  validatorTrue: 'La descripcion no puede contener mas \nde 255 caracteres',
                ),
                // _crearDescripcion(_colores),
                SizedBox(height: 20,),
                _crearDisponible(context),
                SizedBox(
                  height: 20,
                ),
                _botonAgregar(_colores),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _crearName(Colores colores) {
  //   return TextFormField(
  //     textCapitalization: TextCapitalization.sentences,
  //     initialValue:
  //         taskModelGet == null ? taskModelPost.name : taskModelGet.name,
  //     decoration: InputDecoration(
  //       labelText: 'Nombre de la tarea',
  //       focusedBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: colores.grey),
  //       ),
  //       icon: Icon(
  //         Icons.task_outlined,
  //         color: Color.fromRGBO(57, 62, 70, 1),
  //       ),
  //       hintText: 'Ir a la universidad',
  //       labelStyle: TextStyle(color: colores.grey),
  //     ),
  //     onSaved: (value) => taskModelGet == null
  //         ? taskModelPost.name = value
  //         : taskModelGet.name = value,
  //     validator: (value) {
  //       if (value.length < 1) {
  //         if (value.length > 45) {
  //           return 'La tarea no puede contener mas de 45 caracteres';
  //         }
  //         return 'Ingrese el nombre de la tarea';
  //       } else {
  //         return null;
  //       }
  //     },
  //   );
  // }

  // Widget _crearDescripcion() {
  //   return TextFormField(
  //     textCapitalization: TextCapitalization.sentences,
  //     initialValue: taskModelGet == null ? '' : taskModelGet.description,
  //     decoration: InputDecoration(
  //       labelText: 'Descripcion',
  //       focusedBorder: UnderlineInputBorder(
  //         borderSide: BorderSide(color: colores.grey),
  //       ),
  //       icon: Icon(
  //         Icons.description_outlined,
  //         color: colores.grey,
  //       ),
  //       hintText: 'ir a el bloque i',
  //       labelStyle: TextStyle(color: colores.grey),
  //     ),
  //     onSaved: (value) => taskModelGet == null
  //         ? taskModelPost.description = value
  //         : taskModelGet.description = value,
  //     validator: (value) {
  //       if (value.length > 255) {
  //         return 'La descripcion no puede contener mas de 255 caracteres';
  //       } else {
  //         return null;
  //       }
  //     },
  //   );
  // }

  Widget _botonAgregar(Colores colores) {
    return (Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      width: 120,
      height: 40,
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(primary: colores.teal),
        child: Row(
          children: [
            Icon(Icons.save, color: colores.space),
            SizedBox(
              width: 10,
            ),
            Text(
              'Guardar',
              style: TextStyle(color: colores.space),
            )
          ],
        ),
        // onPressed: (_guardando) ? null : _submit,
        onPressed: (){_submit(context);},
      ),
    ));
  }

  Widget _crearDisponible(BuildContext context) {
    // print(tipo.toString());
    if (taskModelGet == null) {
      return Container();
    } else {
      return SwitchListTile(
        value: taskModelGet.status,
        title: Text('Status'),
        activeColor: Color.fromRGBO(57, 62, 70, 1),
        onChanged: (value) => setState(() {
              taskModelGet.status = value;
            }));
    }
  }

  Future<void> _submit(BuildContext context) async {
    final snacbarProvider = Provider.of<SnacBarProvider>(context,listen: false);


    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (taskModelGet != null) {
      // print(taskModelGetToJson(taskModelGet));
      snacbarProvider.selectedStatusCode = await tasksService.editartask(taskModelGet);

    } else {
      //Registrar
      snacbarProvider.selectedStatusCode = await tasksService.crearTask(taskModelPost);
    }


    Navigator.pop(context);
  }

}
