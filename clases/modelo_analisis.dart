import 'criterio.dart';

/// Representa un modelo de análisis (casos de uso, actividades, etc.)
/// compuesto por una lista de criterios de verificación.
class ModeloAnalisis {
  final int id;
  final String nombre;
  final String descripcion;
  final List<Criterio> criterios;

  ModeloAnalisis({
    required this.id,
    required this.nombre,
    required this.descripcion,
    List<Criterio>? criterios,
  }) : criterios = criterios ?? [];

  // ---------- Ejercicio 4: gestión de criterios ----------

  /// Agrega un criterio. Devuelve false si ya existe uno con el mismo id.
  bool agregarCriterio(Criterio criterio) {
    if (buscarCriterio(criterio.id) != null) {
      print('Ya existe un criterio con id ${criterio.id} en "$nombre".');
      return false;
    }
    criterios.add(criterio);
    return true;
  }

  /// Devuelve una copia de solo lectura de la lista de criterios.
  List<Criterio> consultarCriterios() {
    return List.unmodifiable(criterios);
  }

  /// Muestra todos los criterios del modelo.
  void mostrarCriterios() {
    print('Criterios de "$nombre":');
    if (criterios.isEmpty) {
      print('  (el modelo aún no tiene criterios)');
      return;
    }
    for (final criterio in criterios) {
      criterio.mostrarInformacion();
    }
  }

  /// Busca un criterio por id. Devuelve null si no existe.
  Criterio? buscarCriterio(int id) {
    for (final criterio in criterios) {
      if (criterio.id == id) {
        return criterio;
      }
    }
    return null;
  }

  /// Cuenta los criterios del modelo.
  int contarCriterios() {
    return criterios.length;
  }

  // ---------- Ejercicio 5: verificación ----------

  /// Recorre los criterios y cuenta cuántos cumplen, no cumplen
  /// o requieren revisión.
  ({int cumplen, int noCumplen, int enRevision}) verificarCriterios() {
    int cumplen = 0;
    int noCumplen = 0;
    int enRevision = 0;

    for (final criterio in criterios) {
      if (criterio.estado == EstadoCriterio.cumple) {
        cumplen++;
      } else if (criterio.estado == EstadoCriterio.noCumple) {
        noCumplen++;
      } else {
        enRevision++;
      }
    }
    return (cumplen: cumplen, noCumplen: noCumplen, enRevision: enRevision);
  }

  // ---------- Ejercicio 6: porcentaje de cumplimiento ----------

  /// Porcentaje de criterios que cumplen (0 si no hay criterios).
  double calcularPorcentajeCumplimiento() {
    if (criterios.isEmpty) {
      return 0;
    }
    final conteo = verificarCriterios();
    return conteo.cumplen / criterios.length * 100;
  }

  // ---------- Ejercicio 7: estado del modelo ----------

  /// Determina el estado general del modelo según las reglas del taller.
  String determinarEstadoModelo() {
    if (criterios.isEmpty) {
      return 'Sin criterios';
    }
    final conteo = verificarCriterios();
    if (conteo.noCumplen > 0) {
      return 'Requiere ajustes';
    } else if (conteo.enRevision > 0) {
      return 'En revisión';
    } else {
      return 'Aprobado';
    }
  }
}
