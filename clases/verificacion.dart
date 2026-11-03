import 'criterio.dart';
import 'modelo_analisis.dart';

/// Registra el resultado de verificar un [ModeloAnalisis].
class Verificacion {
  final ModeloAnalisis modelo;
  final DateTime fecha;
  final String responsable;
  double porcentaje;
  String estadoFinal;
  final List<String> observaciones;

  Verificacion({
    required this.modelo,
    required this.responsable,
    DateTime? fecha,
  })  : fecha = fecha ?? DateTime.now(),
        porcentaje = 0,
        estadoFinal = 'Sin procesar',
        observaciones = [];

  /// Agrega una observación general a la verificación.
  void agregarObservacion(String texto) {
    observaciones.add(texto);
  }

  /// Calcula el porcentaje y el estado final a partir del modelo.
  void procesarResultados() {
    porcentaje = modelo.calcularPorcentajeCumplimiento();
    estadoFinal = modelo.determinarEstadoModelo();
  }

  String _formatearFecha(DateTime f) {
    final dia = f.day.toString().padLeft(2, '0');
    final mes = f.month.toString().padLeft(2, '0');
    return '$dia/$mes/${f.year}';
  }

  String _formatearPorcentaje(double valor) {
    return valor.toStringAsFixed(valor % 1 == 0 ? 0 : 1);
  }

  // ---------- Ejercicio 9: resumen ----------

  /// Genera el resumen de la verificación como texto.
  String generarResumen() {
    final conteo = modelo.verificarCriterios();
    final buffer = StringBuffer();

    buffer.writeln('RESULTADO DE LA VERIFICACIÓN');
    buffer.writeln();
    buffer.writeln('Modelo: ${modelo.nombre}');
    buffer.writeln('Fecha de verificación: ${_formatearFecha(fecha)}');
    buffer.writeln('Responsable: $responsable');
    buffer.writeln();
    buffer.writeln('Total de criterios: ${modelo.contarCriterios()}');
    buffer.writeln('Cumplen: ${conteo.cumplen}');
    buffer.writeln('No cumplen: ${conteo.noCumplen}');
    buffer.writeln('En revisión: ${conteo.enRevision}');
    buffer.writeln();
    buffer.writeln('Cumplimiento: ${_formatearPorcentaje(porcentaje)} %');
    buffer.writeln();
    buffer.writeln('Estado: ${estadoFinal.toUpperCase()}');

    final incumplidos = modelo.criterios
        .where((c) => c.estado == EstadoCriterio.noCumple)
        .toList();
    if (incumplidos.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('Criterios que no cumplen:');
      for (final c in incumplidos) {
        final detalle =
            c.observacion.isEmpty ? 'Sin observación' : c.observacion;
        buffer.writeln('  - [${c.id}] ${c.descripcion} -> $detalle');
      }
    }

    if (observaciones.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('Observaciones generales:');
      for (final o in observaciones) {
        buffer.writeln('  - $o');
      }
    }
    return buffer.toString();
  }
}
