import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_aplicattion2/providers/task_provider.dart';

import '../estilos/Colores_estilos.dart';
import '../models/tareas/task_modelGet.dart';
import '../services/tasks_service.dart';



  final tasksService = new TasksService();
  Colores _colores = Colores();


Widget showMaterialDialog(BuildContext context) {


    showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlertDialog(
              title: Center(child: Text('Lista de Tareas')),
              actions: <Widget>[
                _crearListado()
              ],
            ),
          );
        });
  }


    Widget _crearListado(){
    return FutureBuilder(
      future: tasksService.cargarTasksTrue(),
      builder: (BuildContext context, AsyncSnapshot<List<TaskModelGet>> snapshot){
        if (snapshot.hasData) {
          final tasks = snapshot.data;
          return Container(
            height: 230,
            width: 302,
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context,i) => _crearItem(tasks[i],context)
            ),
          );

        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

    Widget _crearItem( TaskModelGet task,BuildContext context){

    final taskProvider = Provider.of<TaskProvider>(context,listen: false);
  //  ActivitiesPage ac = ActivitiesPage(a: 'APPPP',);


    return ListTile(
      title: Column(
        children: [
          Container(
            width: 500,
            height: 70,
            child: GestureDetector(
              onTap: (){
                taskProvider.selectedTask = task;
                // ActivitiesPage(a: 'Ojin',);
                Navigator.pop(context);
              },
              child: Card(
                color: _colores.primary,
                  child: Center(child: Text(task.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
              ),
            ),
          ),
        ],
      ),
    );
    // return Text('AAsssssssssssssA');
  }
