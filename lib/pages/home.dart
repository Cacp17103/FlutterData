import 'package:flutter/material.dart';
import 'package:proyectoflutter/modelos/principal.dart';
import 'package:proyectoflutter/pages/creacion.dart';
import 'package:proyectoflutter/servicios/principal_servicio.dart';
import 'package:proyectoflutter/wid/drawer_nav.dart';

class Home_screen extends StatefulWidget {
  @override
  _Home_screenState createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  ServicioPrincipal _servicioPrincipal;

  List<Principal> _listaPrincipal = List<Principal>();

  @override
  void initState() {
    super.initState();
    getAllPrincipal();
  }

  getAllPrincipal() async {
    _servicioPrincipal = ServicioPrincipal();
    _listaPrincipal = List<Principal>();

    var principal = await _servicioPrincipal.leerPrincipal();

    principal.forEach((principal) {
      setState(() {
        var modelo = Principal();
        modelo.id = principal['id'];
        modelo.titulo = principal['titulo'];
        modelo.descripcion = principal['descripcion'];
        modelo.categoria = principal['categoria'];
        modelo.fecha = principal['fecha'];
        modelo.estaTerminado = principal['estaTerminado'];

        _listaPrincipal.add(modelo);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: _listaPrincipal.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_listaPrincipal[index].titulo ?? 'Sin titulo')
                      ],
                    ),
                    subtitle: Text(
                        _listaPrincipal[index].categoria ?? 'Sin categoria'),
                    trailing: Text(_listaPrincipal[index].fecha ?? 'Sin fecha'),
                  )),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => creacionPage())),
        child: Icon(Icons.add),
      ),
    );
  }
}
