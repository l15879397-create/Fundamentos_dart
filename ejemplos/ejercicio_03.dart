import '../clases/modelo_analisis.dart';

void main() {
  final modelos = [
    ModeloAnalisis(
      id: 1,
      nombre: 'Modelo de casos de uso',
      descripcion:
          'Representa las funcionalidades del sistema desde la perspectiva de los actores.',
    ),
    ModeloAnalisis(
      id: 2,
      nombre: 'Modelo de actividades',
      descripcion:
          'Representa el flujo de trabajo y las decisiones de un proceso.',
    ),
    ModeloAnalisis(
      id: 3,
      nombre: 'Modelo de secuencia',
      descripcion:
          'Representa la interacción ordenada de mensajes entre objetos.',
    ),
    ModeloAnalisis(
      id: 4,
      nombre: 'Modelo de clases',
      descripcion:
          'Representa la estructura estática del sistema: clases y relaciones.',
    ),
  ];

  for (final m in modelos) {
    print('${m.id}. ${m.nombre}');
    print('   ${m.descripcion}');
    print('   Criterios registrados: ${m.criterios.length}');
  }
}
