import '../clases/criterio.dart';

void main() {
  final c1 = Criterio(
    id: 1,
    descripcion: 'Todos los actores del sistema están identificados',
  );
  final c2 = Criterio(
    id: 2,
    descripcion: 'Cada caso de uso tiene un nombre claro',
    estado: EstadoCriterio.cumple,
  );
  final c3 = Criterio(
    id: 3,
    descripcion: 'Los límites del sistema están definidos',
    estado: EstadoCriterio.noCumple,
    observacion: 'Falta el rectángulo que delimita el sistema',
  );

  final criterios = [c1, c2, c3];
  for (final c in criterios) {
    print('Criterio ${c.id}: ${c.descripcion}');
    print('  Estado: ${c.estado.etiqueta}');
    print(
        '  Observación: ${c.observacion.isEmpty ? 'Sin observaciones' : c.observacion}');
  }
}
