import '../clases/criterio.dart';
import '../clases/modelo_analisis.dart';
import '../clases/verificacion.dart';

void main() {
  final modelo = ModeloAnalisis(
    id: 4,
    nombre: 'Modelo de clases',
    descripcion: 'Estructura estática del sistema',
  );
  modelo.agregarCriterio(Criterio(
      id: 1,
      descripcion: 'Clases con nombre, atributos y métodos',
      estado: EstadoCriterio.cumple));
  modelo.agregarCriterio(Criterio(
      id: 2,
      descripcion: 'Multiplicidades definidas',
      estado: EstadoCriterio.noCumple,
      observacion: 'Faltan multiplicidades entre Pedido y Producto'));
  modelo.agregarCriterio(Criterio(
      id: 3,
      descripcion: 'Herencia y composición correctas',
      estado: EstadoCriterio.cumple));

  final verificacion = Verificacion(
    modelo: modelo,
    responsable: 'Luis Miguel Melo Muñoz',
  );
  verificacion.agregarObservacion(
      'Corregir las multiplicidades antes de pasar a desarrollo.');
  verificacion.procesarResultados();

  print(verificacion.generarResumen());
}
