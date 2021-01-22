import 'package:proyectoflutter/repositorios/db_conexion.dart';
import 'package:sqflite/sqflite.dart';

class Repositorio {
  DatabaseConn _databaseConn;

  Repositorio() {
    //iniciar la base de datos
    _databaseConn = DatabaseConn();
  }

  static Database _database;
  //Prueba si existe la base de datos
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConn.setDataBase();
    return _database;
  }

  //Insertar datos a la tabla
  insertData(table, data) async {
    var conn = await database;
    return await conn.insert(table, data);
  }

  //Leer datos de la tabla
  leerDatos(table) async {
    var conn = await database;
    return await conn.query(table);
  }

  leerDataById(table, itemId) async {
    var conn = await database;
    return await conn.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //Actualizar datos de la tabla
  actualizarData(table, data) async {
    var conn = await database;
    return await conn
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Eliminar datos de la tabla
  eliminarData(table, itemId) async {
    var conn = await database;
    return await conn.rawDelete("DELETE FROM $table WHERE id  = $itemId");
  }

  //Leer datos de la tabla por nombre de la columna
  leerDatosPorColumna(table, columnName, columnValue) async {
    var conn = await database;
    return await conn
        .query(table, where: '$columnName=?', whereArgs: [columnValue]);
  }
}
