import 'package:flutter/material.dart';
import 'package:proyectoflutter/servicios/principal_servicio.dart';
import 'package:proyectoflutter/modelos/principal.dart';

class ListaCategoria extends StatefulWidget {
  final String categoria;
  ListaCategoria({this.categoria});
  @override
  ListaCategoriaState createState() => ListaCategoriaState();
}

class ListaCategoriaState extends State<ListaCategoria> {
  List<Principal> _listaPrincipal = List<Principal>();
  ServicioPrincipal _servicioPrincipal = ServicioPrincipal();

  @override
  void initState() {
    super.initState();
    getListaCategorias();
  }

  getListaCategorias() async {
    var lista = await _servicioPrincipal
        .leerPrincipalPorCategoria(this.widget.categoria);
    lista.forEach((principal) {
      setState(() {
        var modelo = Principal();
        modelo.titulo = principal['titulo'];
        modelo.descripcion = principal['descripcion'];
        modelo.fecha = principal['fecha'];

        _listaPrincipal.add(modelo);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas por categoria'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _listaPrincipal.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        elevation: 8,
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text(_listaPrincipal[index].titulo)],
                          ),
                          subtitle: Text(_listaPrincipal[index].descripcion),
                          trailing: Text(_listaPrincipal[index].fecha),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
