import 'package:flutter/material.dart';
import 'package:proyectoflutter/pages/home.dart';
import 'package:proyectoflutter/pages/categorias.dart';
import 'package:proyectoflutter/pages/lista_categoria.dart';
import 'package:proyectoflutter/servicios/categoria_servicio.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _listaCategoria = List<Widget>();

  ServicioCategoria _servicioCategoria = ServicioCategoria();

  @override
  void initState() {
    super.initState();
    getAllCategorias();
  }

  getAllCategorias() async {
    var categorias = await _servicioCategoria.leerCategorias();
    categorias.forEach((categoria) {
      setState(() {
        _listaCategoria.add(InkWell(
          onTap: () => Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ListaCategoria(
                        categoria: categoria['nombre'],
                      ))),
          child: ListTile(
            title: Text(categoria['nombre']),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://lh3.googleusercontent.com/ogw/ADGmqu_F3Cm3TWnuIZ972JvFfWzeulmVUZBF1sWmvShRTA=s83-c-mo'),
              ),
              accountName: Text('César Cano'),
              accountEmail: Text('cacp17103@gmail.com'),
              decoration: BoxDecoration(color: Colors.green),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Home_screen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categorias'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Categoria_screen())),
            ),
            Divider(),
            Column(
              children: _listaCategoria,
            )
          ],
        ),
      ),
    );
  }
}
