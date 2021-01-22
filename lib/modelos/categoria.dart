class Categoria {
  int id;
  String nombre;
  String descripcion;

  CategoriaMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['nombre'] = nombre;
    mapping['descripcion'] = descripcion;

    return mapping;
  }
}
