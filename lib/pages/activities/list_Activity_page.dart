import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_aplicattion2/estilos/Colores_estilos.dart';
import 'package:task_aplicattion2/models/activity/activity_modelPost.dart';
import 'package:task_aplicattion2/providers/snacbar_provider.dart';
import 'package:task_aplicattion2/services/activity_service.dart';
import 'package:task_aplicattion2/widgets/AppBar_widget.dart';

class ListACtivityPage extends StatefulWidget {

  @override
  State<ListACtivityPage> createState() => _ListACtivityPageState();
}

class _ListACtivityPageState extends State<ListACtivityPage> {
  ActivitiesService activitiesService = ActivitiesService();

  @override
  Widget build(BuildContext context) {

    actualizarListado();
    
    return Scaffold(
      appBar: appBar(title: 'Lista de Actividades'),
      body: _crearListado() ,

    );


  }

    Future<void> actualizarListado () async {
    final snacbarProvider = Provider.of<SnacBarProvider>(context,listen: true);
    snacbarProvider.selectedStatusCode == 0;
    //   setState(() {
    //   if (snacbarProvider.selectedStatusCode == 0) {
    //   // _crearListado();
    //   }
    // });
    // print('PPPPP');
  }


  Widget _crearListado(){
    return FutureBuilder(
      future: activitiesService.cargarActivities(context),
      builder: (BuildContext context, AsyncSnapshot<List<ActivityModelPost>> snapshot){
        if (snapshot.hasData) {
          final tasks = snapshot.data;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context,i) => _crearItem(context,tasks[i],i)
          );

        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

}

  _crearItem(BuildContext context, ActivityModelPost activities, int index) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.white,
      ),
      onDismissed: (direccion) {
        // activitiesService.deleteActivities(activities.id);
        // setState(() {
          // tasks.removeAt(index);
        // });
      },
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListTile(
          subtitle: Text('${activities.dateStart}'),
          title: Text('${activities.dateEnd}'),
          onTap: () {
            Navigator.pushNamed(context, 'activity', arguments: activities);
          },
        ),
      ),
    );

  }