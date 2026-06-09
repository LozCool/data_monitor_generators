import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

// import 'package:data_monitor/annotations.dart';
// import 'package:data_monitor_generators/generators.dart';
//
// class DataMonitorGenerator extends GeneratorForAnnotation<DataMonitor> {
//   @override
//   String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
//     final ModelVisitor visitor = ModelVisitor();
//     final StringBuffer buffer  = StringBuffer();
//
//     element.visitChildren(visitor);
//
//     buffer.writeln('mixin _\$${visitor.className} on ${visitor.className} {');
//
//     for (MapEntry<String, DartType> field in visitor.fields.entries) {
//       // buffer.writeln('// next field is called ${field.key} and its type is ${field.value.toString()}');
//
//       // buffer.writeln('@override');
//       // buffer.writeln('${field.value.toString()} get ${field.key} {');
//       // buffer.writeln('  return super.${field.key};');
//       // buffer.writeln('}');
//       // buffer.writeln();
//       buffer.writeln('@override');
//       buffer.writeln('set ${field.key}(${field.value.toString()} value) {');
//       buffer.writeln('  notifyListeners();');
//       buffer.writeln();
//       buffer.writeln('  super.${field.key} = value;');
//       buffer.writeln('}');
//     }
//     buffer.writeln('}');
//
//     return buffer.toString();
//   }
// }
