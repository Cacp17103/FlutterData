import 'package:proyectoflutter/modelos/categoria.dart';
import 'package:proyectoflutter/repositorios/repositorio.dart';
import 'package:proyectoflutter/modelos/categoria.dart';

class ServicioCategoria {
  Repositorio _repositorio;

  ServicioCategoria() {
    _repositorio = Repositorio();
  }
  //Creando datos
  guardarCategoria(Categoria categoria) async {
    return await _repositorio.insertData(
        'categorias', categoria.CategoriaMap());
  }

  //Leer los datos de las tabla
  leerCategorias() async {
    return await _repositorio.leerDatos('categorias');
  }

  leerCategoriaById(categoriaId) async {
    return await _repositorio.leerDataById('categorias', categoriaId);
  }

  //Actualizar datos de la tabla
  actualizarCategoria(Categoria categoria) async {
    return await _repositorio.actualizarData(
        'categorias', categoria.CategoriaMap());
  }

  //Eliminar datos de la tabla
  eliminarCategoria(categoriaId) async {
    return await _repositorio.eliminarData('categorias', categoriaId);
  }
}
