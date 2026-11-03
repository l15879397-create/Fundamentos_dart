import '../clases/criterio.dart';
import '../clases/modelo_analisis.dart';

void main() {
  final modelo = ModeloAnalisis(
    id: 3,
    nombre: 'Modelo de secuencia',
    descripcion: 'Interacción entre objetos',
  );

  modelo.agregarCriterio(Criterio(
      id: 1,
      descripcion: 'Participantes identificados',
      estado: EstadoCriterio.cumple));
  modelo.agregarCriterio(Criterio(
      id: 2,
      descripcion: 'Mensajes en orden cronológico',
      estado: EstadoCriterio.cumple));
  modelo.agregarCriterio(Criterio(
      id: 3,
      descripcion: 'Mensajes de retorno',
      estado: EstadoCriterio.enRevision));
  modelo.agregarCriterio(Criterio(
      id: 4,
      descripcion: 'Activaciones correctas',
      estado: EstadoCriterio.noCumple));

  // Ejercicio 5
  final conteo = modelo.verificarCriterios();
  print('Cumplen: ${conteo.cumplen}');
  print('No cumplen: ${conteo.noCumplen}');
  print('Requieren revisión: ${conteo.enRevision}');

  // Ejercicio 6
  print(
      'Porcentaje de cumplimiento: ${modelo.calcularPorcentajeCumplimiento()} %');

  // Ejercicio 7: se prueban las tres reglas
  print('\nEstado con un incumplimiento: ${modelo.determinarEstadoModelo()}');

  modelo.buscarCriterio(4)!.cambiarEstado(EstadoCriterio.cumple);
  print(
      'Estado sin incumplimientos y con un criterio en revisión: ${modelo.determinarEstadoModelo()}');

  modelo.buscarCriterio(3)!.cambiarEstado(EstadoCriterio.cumple);
  print(
      'Estado con todos los criterios cumplidos: ${modelo.determinarEstadoModelo()}');
}
