import '../clases/criterio.dart';

void main() {
  final criterio = Criterio(
    id: 1,
    descripcion: 'Los actores están asociados a sus casos de uso',
  );

  print('--- Información inicial ---');
  criterio.mostrarInformacion();
  print('¿Cumple? ${criterio.cumple()}');

  criterio.cambiarEstado(EstadoCriterio.noCumple);
  criterio.registrarObservacion(
      'El actor Administrador no está asociado a ningún caso');

  print('\n--- Después de modificar ---');
  criterio.mostrarInformacion();
  print('¿Cumple? ${criterio.cumple()}');

  criterio.cambiarEstado(EstadoCriterio.cumple);
  print('\n--- Después de corregir ---');
  criterio.mostrarInformacion();
  print('¿Cumple? ${criterio.cumple()}');
}
