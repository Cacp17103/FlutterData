class Principal {
  int id;
  String titulo;
  String descripcion;
  String categoria;
  String fecha;
  int estaTerminado;

  PrincipalMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['titulo'] = titulo;
    mapping['descripcion'] = descripcion;
    mapping['categoria'] = categoria;
    mapping['fecha'] = fecha;
    mapping['estaTerminado'] = estaTerminado;

    return mapping;
  }
}
