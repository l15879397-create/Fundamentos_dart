/// Estados posibles de un criterio de verificación.
enum EstadoCriterio {
  enRevision('En revisión'),
  cumple('Cumple'),
  noCumple('No cumple');

  final String etiqueta;
  const EstadoCriterio(this.etiqueta);
}

/// Representa un criterio que debe verificarse en un modelo de análisis.
class Criterio {
  final int id;
  final String descripcion;
  EstadoCriterio estado;
  String observacion;

  Criterio({
    required this.id,
    required this.descripcion,
    this.estado = EstadoCriterio.enRevision,
    this.observacion = '',
  });

  /// Cambia el estado del criterio.
  void cambiarEstado(EstadoCriterio nuevoEstado) {
    estado = nuevoEstado;
  }

  /// Registra (o reemplaza) la observación del criterio.
  void registrarObservacion(String texto) {
    observacion = texto;
  }

  /// Indica si el criterio cumple.
  bool cumple() {
    return estado == EstadoCriterio.cumple;
  }

  /// Muestra la información del criterio en consola.
  void mostrarInformacion() {
    print('[$id] $descripcion');
    print('    Estado: ${estado.etiqueta}');
    print(
        '    Observación: ${observacion.isEmpty ? 'Sin observaciones' : observacion}');
  }
}
