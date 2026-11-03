import '../clases/criterio.dart';
import '../clases/modelo_analisis.dart';

void main() {
  final modelo = ModeloAnalisis(
    id: 1,
    nombre: 'Modelo de casos de uso',
    descripcion: 'Funcionalidades del sistema',
  );

  modelo.agregarCriterio(
      Criterio(id: 1, descripcion: 'Los actores están identificados'));
  modelo.agregarCriterio(
      Criterio(id: 2, descripcion: 'Los casos de uso tienen nombre con verbo'));
  modelo.agregarCriterio(
      Criterio(id: 3, descripcion: 'Los límites del sistema están definidos'));
  modelo.agregarCriterio(Criterio(id: 2, descripcion: 'Criterio repetido'));

  print('Total de criterios: ${modelo.contarCriterios()}\n');
  modelo.mostrarCriterios();

  print('\nBúsqueda del criterio 3:');
  final encontrado = modelo.buscarCriterio(3);
  print(encontrado != null ? encontrado.descripcion : 'No encontrado');

  print('\nBúsqueda del criterio 9:');
  final noExiste = modelo.buscarCriterio(9);
  print(noExiste != null ? noExiste.descripcion : 'No encontrado');

  print('\nCriterios consultados: ${modelo.consultarCriterios().length}');
}
