import 'package:flutter/material.dart';
import 'package:proyectoflutter/modelos/principal.dart';
import 'package:proyectoflutter/servicios/categoria_servicio.dart';
import 'package:intl/intl.dart';
import 'package:proyectoflutter/servicios/principal_servicio.dart';

class creacionPage extends StatefulWidget {
  @override
  _creacionPageState createState() => _creacionPageState();
}

class _creacionPageState extends State<creacionPage> {
  var _tituloController = TextEditingController();

  var _descripcionController = TextEditingController();

  var _fechaController = TextEditingController();

  var _seleccionaValor;

  var _categorias = List<DropdownMenuItem>();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _cargarCategorias();
  }

  _cargarCategorias() async {
    var _servicioCategoria = ServicioCategoria();
    var categorias = await _servicioCategoria.leerCategorias();
    categorias.forEach((categoria) {
      setState(() {
        _categorias.add(DropdownMenuItem(
          child: Text(categoria['nombre']),
          value: categoria['nombre'],
        ));
      });
    });
  }

  DateTime _dateTime = DateTime.now();

  _selectedDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        _fechaController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
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
        title: Text('Crea tu lista'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                  labelText: 'Titulo', hintText: 'Escribe tu titulo'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(
                  labelText: 'Descripción', hintText: 'Escribe tu descripción'),
            ),
            TextField(
              controller: _fechaController,
              decoration: InputDecoration(
                labelText: 'Fecha',
                hintText: 'Elige una fecha',
                prefixIcon: InkWell(
                  onTap: () {
                    _selectedDate(context);
                  },
                  child: Icon(Icons.calendar_today),
                ),
              ),
            ),
            DropdownButtonFormField(
              value: _seleccionaValor,
              items: _categorias,
              hint: Text('Categoria'),
              onChanged: (value) {
                setState(() {
                  _seleccionaValor = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async {
                var principalObjet = Principal();
                principalObjet.titulo = _tituloController.text;
                principalObjet.descripcion = _descripcionController.text;
                principalObjet.estaTerminado = 0;
                principalObjet.categoria = _seleccionaValor.toString();
                principalObjet.fecha = _fechaController.text;

                var _servicioPrincipal = ServicioPrincipal();
                var resultado =
                    await _servicioPrincipal.guardarPrincipal(principalObjet);

                if (resultado > 0) {
                  _showSuccessShackBar(Text('Creada'));
                }

                print(resultado);
              },
              color: Colors.green,
              child: Text(
                'Guardar',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
