import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConn {
  setDataBase() async {
    var directorio = await getApplicationDocumentsDirectory();
    var path = join(directorio.path, 'db_proyectoflutter');
    var database =
        await openDatabase(path, version: 1, onCreate: _creandoDataBase);
    return database;
  }

  _creandoDataBase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE categorias(id INTEGER PRIMARY KEY, nombre TEXT, descripcion TEXT)");

    //Creando la tabla de la pantalla principal
    await database.execute(
        "CREATE TABLE principal(id INTEGER PRIMARY KEY, titulo TEXT, descripcion TEXT, categoria TEXT, fecha TEXT, estaTerminado INTEGER)");
  }
}
