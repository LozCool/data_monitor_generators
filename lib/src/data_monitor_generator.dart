import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:data_monitor/annotations.dart';

import 'model_visitor.dart';

/// `DataMonitorGenerator` uses the information that was found
/// when any `data_monitor` related annotations were parsed by
/// a generator.
///
/// It creates concrete classes in (multiple) '.g.dart' files
/// that implement the required field `setters` in any
/// associated data model classes.
class DataMonitorGenerator extends GeneratorForAnnotation<DataMonitor> {
  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final ModelVisitor visitor = ModelVisitor();
    final StringBuffer buffer  = StringBuffer();

    element.visitChildren(visitor);

    buffer.writeln('mixin _\$${visitor.className} on ${visitor.className} {');

    for (MapEntry<String, DartType> field in visitor.fields.entries) {
      buffer.writeln('@override');
      buffer.writeln('set ${field.key}(${field.value.toString()} value) {');
      buffer.writeln('  notify(() {');
      buffer.writeln('    super.${field.key} = value;');
      buffer.writeln('  });');
      buffer.writeln('}');
    }
    buffer.writeln('}');

    return buffer.toString();
  }
}
