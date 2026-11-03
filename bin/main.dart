import '../clases/criterio.dart';
import '../clases/modelo_analisis.dart';
import '../clases/verificacion.dart';

/// Cada evaluación es (descripción, estado, observación).
typedef Evaluacion = (String, EstadoCriterio, String);

const cumple = EstadoCriterio.cumple;
const noCumple = EstadoCriterio.noCumple;
const enRevision = EstadoCriterio.enRevision;

/// Ejecuta el flujo completo de verificación de un modelo:
/// crear modelo -> agregar criterios -> evaluar -> registrar estados ->
/// agregar observaciones -> procesar -> calcular porcentaje ->
/// determinar estado -> generar resumen.
void verificarModelo({
  required ModeloAnalisis modelo,
  required List<Evaluacion> evaluaciones,
  required String responsable,
  String? observacionGeneral,
}) {
  // 1. Agregar criterios (nacen "En revisión")
  for (var i = 0; i < evaluaciones.length; i++) {
    final (descripcion, _, _) = evaluaciones[i];
    modelo.agregarCriterio(Criterio(id: i + 1, descripcion: descripcion));
  }

  // 2. Evaluar criterios, registrar estados y observaciones
  for (var i = 0; i < evaluaciones.length; i++) {
    final (_, estado, observacion) = evaluaciones[i];
    final criterio = modelo.buscarCriterio(i + 1);
    if (criterio == null) continue;

    criterio.cambiarEstado(estado);
    if (observacion.isNotEmpty) {
      criterio.registrarObservacion(observacion);
    }
  }

  // 3. Procesar resultados (porcentaje y estado) y generar el resumen
  final verificacion = Verificacion(modelo: modelo, responsable: responsable);
  if (observacionGeneral != null) {
    verificacion.agregarObservacion(observacionGeneral);
  }
  verificacion.procesarResultados();

  print(verificacion.generarResumen());
  print('=' * 60);
  print('');
}

void main() {
  const responsable = 'Luis Miguel Melo Muñoz';

  // 1. Modelo de casos de uso (10 criterios)
  verificarModelo(
    modelo: ModeloAnalisis(
      id: 1,
      nombre: 'Modelo de casos de uso',
      descripcion:
          'Funcionalidades del sistema desde la perspectiva de los actores.',
    ),
    responsable: responsable,
    observacionGeneral:
        'Corregir las relaciones include y confirmar los nombres con el informe de requisitos.',
    evaluaciones: [
      ('Todos los actores del sistema están identificados', cumple, ''),
      ('Cada caso de uso tiene un nombre con verbo en infinitivo', cumple, ''),
      ('Las relaciones entre actores y casos de uso son correctas', cumple, ''),
      ('Los límites del sistema están definidos', cumple, ''),
      ('Los casos de uso cubren todos los requisitos funcionales', cumple, ''),
      (
        'Las relaciones include y extend se usan correctamente',
        noCumple,
        'Falta la relación include entre Registrar pedido y Validar datos'
      ),
      ('Cada caso de uso tiene su especificación textual', cumple, ''),
      ('No existen casos de uso duplicados', cumple, ''),
      (
        'Los nombres son consistentes con el informe de requisitos',
        enRevision,
        'Pendiente de contrastar con el informe de requisitos'
      ),
      ('El diagrama es legible y está documentado', cumple, ''),
    ],
  );

  // 2. Modelo de actividades (6 criterios)
  verificarModelo(
    modelo: ModeloAnalisis(
      id: 2,
      nombre: 'Modelo de actividades',
      descripcion: 'Flujo de trabajo y decisiones de un proceso.',
    ),
    responsable: responsable,
    evaluaciones: [
      ('Existe un nodo inicial y al menos un nodo final', cumple, ''),
      ('Todas las acciones están nombradas con verbos', cumple, ''),
      ('Los flujos de control conectan todas las acciones', cumple, ''),
      ('Cada salida de una decisión tiene su condición', cumple, ''),
      ('Las calles identifican a los responsables', cumple, ''),
      ('El flujo es coherente con el caso de uso asociado', cumple, ''),
    ],
  );

  // 3. Modelo de secuencia (5 criterios)
  verificarModelo(
    modelo: ModeloAnalisis(
      id: 3,
      nombre: 'Modelo de secuencia',
      descripcion: 'Interacción ordenada de mensajes entre objetos.',
    ),
    responsable: responsable,
    observacionGeneral: 'Validar los mensajes contra el modelo de clases.',
    evaluaciones: [
      ('Los objetos y actores participantes están identificados', cumple, ''),
      ('Los mensajes están en orden cronológico', cumple, ''),
      (
        'Los mensajes corresponden a métodos de las clases',
        enRevision,
        'Verificar nombres de métodos contra el modelo de clases'
      ),
      (
        'Las líneas de vida y activaciones están bien representadas',
        cumple,
        ''
      ),
      (
        'Se representan los mensajes de retorno',
        enRevision,
        'Faltan retornos en dos interacciones'
      ),
    ],
  );

  // 4. Modelo de clases (5 criterios)
  verificarModelo(
    modelo: ModeloAnalisis(
      id: 4,
      nombre: 'Modelo de clases',
      descripcion: 'Estructura estática del sistema: clases y relaciones.',
    ),
    responsable: responsable,
    evaluaciones: [
      ('Cada clase tiene nombre, atributos y métodos', cumple, ''),
      ('Los atributos tienen tipo de dato y visibilidad', cumple, ''),
      (
        'Las multiplicidades de las asociaciones están definidas',
        noCumple,
        'Faltan multiplicidades entre Pedido y Producto'
      ),
      ('Las relaciones de herencia y composición son correctas', cumple, ''),
      (
        'Las clases son consistentes con los casos de uso',
        noCumple,
        'Hay clases sin casos de uso que las justifiquen'
      ),
    ],
  );
}
