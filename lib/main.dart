import 'package:flutter/material.dart';
import 'package:proyectoflutter/pages/home.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(LoginApp());

String username;

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Listas',
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => new Home_screen(),
        });
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final usuario = TextEditingController();
  final password = TextEditingController();

  String user = 'cesar';
  String pass = '123';

  void ingresar(usuario, pass) async {
    try {
      var url = 'http://joussalonso.com/php/ingresar.php';
      var respuesta = await http.post(url, body: {
        'correo': usuario,
        'pass': pass
      }).timeout(const Duration(seconds: 90));
      if (respuesta.body == '1') {
        Navigator.pushNamed(context, '/home',
            arguments: {'usuario': user, 'password': pass});
        FocusScope.of(context).unfocus();
      } else {
        print('Usuario incorrecto');
      }
    } on TimeoutException catch (e) {
      print('Se extendio de tiempo la conexión');
    } on Error catch (e) {
      print('Http error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            alignment: Alignment.center,
            child: Image.asset('assets/images/logotec.png'),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: usuario,
              decoration: InputDecoration(hintText: 'Usuario'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Contraseña'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              color: Colors.green,
              child: Text(
                'Ingresar',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'rbold',
                ),
              ),
              onPressed: () {
                user = usuario.text;
                pass = password.text;

                if (user != '' && pass != '') {
                  ingresar(user, pass);
                } else {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('APP PRUEBA'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text('Checa tus datos'),
                              ],
                            ),
                          ),
                          actions: [
                            FlatButton(
                                child: Text('Aceptar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        );
                      });
                }
                usuario.text = '';
                password.text = '';
              },
            ),
          ),
        ],
      ),
    );
  }
}
