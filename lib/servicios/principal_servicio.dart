import 'package:proyectoflutter/modelos/principal.dart';
import 'package:proyectoflutter/repositorios/repositorio.dart';

class ServicioPrincipal {
  Repositorio _repositorio;

  ServicioPrincipal() {
    _repositorio = Repositorio();
  }

  guardarPrincipal(Principal principal) async {
    return await _repositorio.insertData('principal', principal.PrincipalMap());
  }

  leerPrincipal() async {
    return await _repositorio.leerDatos('principal');
  }

  leerPrincipalPorCategoria(categoria) async {
    return await _repositorio.leerDatosPorColumna(
        'principal', 'categoria', categoria);
  }
}
