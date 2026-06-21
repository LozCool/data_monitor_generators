import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:data_monitor/annotations.dart';

import 'class_visitor.dart';

/// `DataMonitorGenerator` uses the information that was found
/// when any classes annotated by @dataMonitor were parsed by
/// a generator.
///
/// It creates concrete classes in (multiple) '.g.dart' files
/// that implement the required `field setters` and `property
/// getters` in in any associated data model classes.
class DataMonitorGenerator extends GeneratorForAnnotation<DataMonitor> {
  @override
  Future<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    final ClassVisitor          visitor    = ClassVisitor(resolver: buildStep.resolver);
    final Map<String, DartType> properties = {};
    final StringBuffer          buffer     = StringBuffer();

    if (element is ClassElement) {
      await visitor.visitClass(element);

      buffer.writeln('mixin _\$${visitor.className.replaceFirst('_', '')} on ${visitor.className} {');

      for (MapEntry<String, FieldContainer> field in visitor.fields.entries) {
        String name = field.key;

        properties.addAll(field.value.properties);

        buffer.writeln('late final DataItem _${field.key} = DataItem(${field.key}, [');

        for (String name in field.value.properties.keys) {
          buffer.writeln('  _$name,');
        }
        buffer.writeln(']);');

        buffer.writeln('');
        buffer.writeln('@override');
        buffer.writeln('set $name(${field.value.type} value) {');
        buffer.writeln('  if (_$name.setValue(value)) {');
        buffer.writeln('    notify(() {');
        buffer.writeln('      super.$name = value;');
        buffer.writeln('    });');
        buffer.writeln('  }');
        buffer.writeln('}');
      }
      for (MapEntry<String, DartType> property in properties.entries) {
        String name = property.key;

        buffer.writeln('late final DataProperty _$name = DataProperty(super.$name);');
        buffer.writeln('');
        buffer.writeln('@override');
        buffer.writeln('${property.value} get $name {');
        buffer.writeln('  return _$name.isDirty ? _$name.setValue(super.$name) : _$name.value;');
        buffer.writeln('}');
      }
    }
    buffer.writeln('}');

    return buffer.toString();
  }
}
