import 'package:flutter/material.dart';
import 'package:task_aplicattion2/blocs/provider.dart';
import 'package:task_aplicattion2/estilos/Colores_estilos.dart';


class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Colores _colores = Colores();
  bool _isObscure = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _creatFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Providers.of(context);
    final Size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 220.0,
            ),
          ),
          Container(
            width: Size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0,
                  )
                ]),
            child: Column(
              children: [
                Text('Ingreso', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: _colores.terciary)),
                SizedBox(height: 60.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc)
              ],
            ),
          ),
          GestureDetector  (child: Text('¿Olvido la contraseña?')),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBLoc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _colores.secondary),
                ),
                  icon: Icon(Icons.alternate_email, color: _colores.cuaternary),
                  hintText: 'ejemplo@correo.com',
                  labelText: 'Correo electronico',
                  labelStyle: TextStyle(
                    color: _colores.cuaternary
                  ),
                  counterText: snapshot.data,
                  errorText: snapshot.error
                ),
              onChanged: bloc.changeEmail,
            ),
          );
        });
  }

  Widget _crearPassword(LoginBLoc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: _isObscure,
            decoration: InputDecoration(
              suffix: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: (){
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _colores.secondary),
                ),
                icon: Icon(Icons.lock_outline, color: _colores.cuaternary),
                labelText: 'Contraseña',
                labelStyle: TextStyle(
                  color: _colores.cuaternary
                ),
                errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBLoc bloc) {
    // formValidStream
    //snapshot.hasData
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        // ignore: deprecated_member_use
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15.0),
            child: Text('Ingresar',style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: _colores.secondary,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=> _login(context) : null ,
        );
      },
    );
  }

  _login(BuildContext context){
    Navigator.pushReplacementNamed(context, 'homes');
  }

  Widget _creatFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.58,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            _colores.secondary,
            _colores.terciary,
            // _colores.cuaternary,

        // Color.fromRGBO(63, 63, 156, 1.0),
        // Color.fromRGBO(90, 70, 178, 1.0),
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(238, 238, 238, 0.1)),
    );

    return Stack(
      children: [
        fondoMorado,
        Positioned(
          top: 90.0,
          left: 30.0,
          child: circulo,
        ),
        Positioned(
          top: 20.0,
          right: -40,
          child: circulo,
        ),
        Positioned(
          top: -40.0,
          left: -30.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          right: -10.0,
          child: circulo,
        ),
        // Positioned(
        //   bottom: 120.0,
        //   right: 20.0,
        //   child: circulo,
        // ),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Icon(
                Icons.task_outlined,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text('APLICACION DE TAREAS',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
}
