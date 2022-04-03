import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_aplicattion2/providers/snacbar_provider.dart';
import 'package:task_aplicattion2/services/tasks_service.dart';
import 'package:task_aplicattion2/widgets/AppBar_widget.dart';
import 'package:task_aplicattion2/widgets/snacbar_widget.dart';

import '../../estilos/Colores_estilos.dart';
import '../../models/tareas/task_modelGet.dart';

class ListTaskPage extends StatefulWidget {

  @override
  State<ListTaskPage> createState() => ListTaskPageState();
}

class ListTaskPageState extends State<ListTaskPage> {

  // final tasksProvider = new TasksService();
  Colores _colores = Colores();
  bool loading = false;
  TasksService tasksService = TasksService();




 @override
 void initState() {

    super.initState();
    // tasksService.cargarTasks(context);
  }

  @override
  Widget build(BuildContext context) {
    actualizarListado('actualizar');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: 'Lista de tareas'),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _crearListado()
    );
  }
  Future<void> actualizarListado (String proces) async {
    setState(() {
      _crearListado();

    print('actualizarListado');
    });
    // if (proces == 'cancelar') {
    //   snacbarProvider.selectedStatusCode == 0;
    // }else{
    // }
  }

  Widget _crearListado(){
    return FutureBuilder(
      future: tasksService.cargarTasks(context),
      builder: (BuildContext context, AsyncSnapshot<List<TaskModelGet>> snapshot){
        if (snapshot.hasData) {
          final tasks = snapshot.data;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context,i) => _crearItem(tasks[i],context,i)
          );

        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }



  Widget _crearItem( TaskModelGet task,BuildContext context,int index){
    final snacbarProvider = Provider.of<SnacBarProvider>(context,listen: false);

    return Container(
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          color:  Colors.white,
        ),
        onDismissed: (direccion) async {
          showDAlertDelete(context, task);
        //  snacbarProvider.selectedStatusCode = await tasksService.deleteTask(task.id);
        //  //boton de si o no


        //  mostrarSnacbar(
        //    context: context,
        //     typeModel: 'task',
        //     typeConsult: 'delete'
        //  );
        // snacbarProvider.selectedStatusCode = 0;
        },
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, 'task',arguments: task).then((value) {setState(() {
                  mostrarSnacbar(
                    // status:  snacbarProvider.selectedStatusCode,
                    context: context,
                    typeModel: 'task',
                    typeConsult: 'update'
                  );
              snacbarProvider.selectedStatusCode = 0;
                });});
              },
              child: Container(
                margin: EdgeInsets.all(15),
                width: double.infinity,
                height: 80,
                child: Card(
                  elevation: 10,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: _colores.getColor()[index % _colores.getColor().length],
                        ),
                      ),
                      // tomar el lado derecho de la tarjeta
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                task.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                task.description,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                     _statusTask(context,task),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  showDAlertDelete(BuildContext context, TaskModelGet taskModelGet) {


    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Eliminar'),
          content: Text('¿Esta seguro de eliminar la tarea?'),
          actions: [
            FlatButton(
              child: Text('Cancelar'),
              onPressed: (){
                print('Cancelar');
                Navigator.of(context).pop();
                actualizarListado('cancelar');
              },
            ),
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () async {
                // print('Aceptar');
                final snacbarProvider = Provider.of<SnacBarProvider>(context,listen: false);
                var result = await tasksService.deleteTask(taskModelGet.id);
                snacbarProvider.selectedStatusCode = result[0];
                snacbarProvider.selectedMessage = result[1];

                // print(result[0]);
                // print(result[1]);

                if (result[0] == 409) {
                  Navigator.pop(context);
                }
                if (result[0] == 200) {
                  Navigator.pop(context);
                }

              //  print(await tasksService.deleteTask(taskModelGet.id));
               mostrarSnacbar(
                 context: context,
                  typeModel: 'task',
                  typeConsult: 'delete'
               );
                actualizarListado('actualizar');
                snacbarProvider.selectedStatusCode = 0;
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }


  Widget _statusTask(BuildContext context,TaskModelGet taskModelGet) {

    // print(tipo.toString());
      return Container(
        padding: EdgeInsets.only(right: 20),
        child: Switch(
          value: taskModelGet.status,
          activeColor: _colores.secondary,
          onChanged:  (value)  async{
            await tasksService.editarEstadoTask(taskModelGet.id);
            setState(() {
              taskModelGet.status = value;
            });
          },
      ));
  }

}