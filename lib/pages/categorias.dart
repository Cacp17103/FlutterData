import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:proyectoflutter/pages/home.dart';
import 'package:proyectoflutter/modelos/categoria.dart';
import 'package:proyectoflutter/servicios/categoria_servicio.dart';

class Categoria_screen extends StatefulWidget {
  @override
  _Categoria_screenState createState() => _Categoria_screenState();
}

class _Categoria_screenState extends State<Categoria_screen> {
  var _categoriaNombreController = TextEditingController();
  var _categoriaDescripcionController = TextEditingController();

  var _categoria = Categoria();
  var _ServicioCategoria = ServicioCategoria();

  List<Categoria> _listaCategoria = List<Categoria>();

  var categoria;
  var _editcategoriaNombreController = TextEditingController();
  var _editcategoriaDescripcionController = TextEditingController();

  void initState() {
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _listaCategoria = List<Categoria>();
    var categorias = await _ServicioCategoria.leerCategorias();
    categorias.forEach((categoria) {
      setState(() {
        var modeloCategoria = Categoria();
        modeloCategoria.nombre = categoria['nombre'];
        modeloCategoria.descripcion = categoria['descripcion'];
        modeloCategoria.id = categoria['id'];
        _listaCategoria.add(modeloCategoria);
      });
    });
  }

  _editCategoria(BuildContext context, categoriaId) async {
    categoria = await _ServicioCategoria.leerCategoriaById(categoriaId);
    setState(() {
      _editcategoriaNombreController.text =
          categoria[0]['nombre'] ?? 'Sin nombre';
      _editcategoriaDescripcionController.text =
          categoria[0]['descripcion'] ?? 'Sin descripcion';
    });
    _editFormDialog(context);
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              FlatButton(
                color: Colors.green,
                onPressed: () async {
                  _categoria.nombre = _categoriaNombreController.text;
                  _categoria.descripcion = _categoriaDescripcionController.text;

                  var resultado =
                      await _ServicioCategoria.guardarCategoria(_categoria);
                  if (resultado > 0) {
                    print(resultado);
                    Navigator.pop(context);
                    getAllCategories();
                  }
                },
                child: Text('Guardar'),
              )
            ],
            title: Text('Formulario de Categorias'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categoriaNombreController,
                    decoration: InputDecoration(
                        hintText: 'Escribe una categoria',
                        labelText: 'Categoria'),
                  ),
                  TextField(
                    controller: _categoriaDescripcionController,
                    decoration: InputDecoration(
                        hintText: 'Escribe una descripción',
                        labelText: 'Descripción'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              FlatButton(
                color: Colors.green,
                onPressed: () async {
                  _categoria.id = categoria[0]['id'];
                  _categoria.nombre = _editcategoriaNombreController.text;
                  _categoria.descripcion =
                      _editcategoriaDescripcionController.text;

                  var resultado =
                      await _ServicioCategoria.actualizarCategoria(_categoria);
                  if (resultado > 0) {
                    Navigator.pop(context);
                    getAllCategories();
                    _showSuccessShackBar(Text('Actualizado'));
                  }
                },
                child: Text('Editar'),
              )
            ],
            title: Text('Edicion del Formulario de Categorias'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _editcategoriaNombreController,
                    decoration: InputDecoration(
                        hintText: 'Escribe una categoria',
                        labelText: 'Categoria'),
                  ),
                  TextField(
                    controller: _editcategoriaDescripcionController,
                    decoration: InputDecoration(
                        hintText: 'Escribe una descripción',
                        labelText: 'Descripción'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoriaId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                color: Colors.green[700],
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              FlatButton(
                color: Colors.red,
                onPressed: () async {
                  var resultado =
                      await _ServicioCategoria.eliminarCategoria(categoriaId);
                  if (resultado > 0) {
                    Navigator.pop(context);
                    getAllCategories();
                    _showSuccessShackBar(Text('Eliminado'));
                  }
                },
                child: Text('Eliminar'),
              )
            ],
            title: Text('¿Estas seguro de que quieres eliminar esto?'),
          );
        });
  }

  _showSuccessShackBar(message) {
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: RaisedButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Home_screen())),
          elevation: 0.0,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          color: Colors.green,
        ),
        title: Text('Categorias'),
      ),
      body: ListView.builder(
          itemCount: _listaCategoria.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editCategoria(context, _listaCategoria[index].id);
                      }),
                  title: Row(
                    children: <Widget>[
                      Text(_listaCategoria[index].nombre),
                      IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteFormDialog(
                                context, _listaCategoria[index].id);
                          })
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
