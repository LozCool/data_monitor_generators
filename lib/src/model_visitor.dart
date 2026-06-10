import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor2.dart';
import 'package:source_gen/source_gen.dart';

import 'package:data_monitor/annotations.dart';

/// The `ModelVisitor` class is called by `DataMonitorGenerator` when the
/// generators are invoked by the 'build_runner' command.
///
/// It performs two functions:
///
///   1. It saves the name of any class which has an `@dataMonitor
///    ` annotation.
///
///   2. For those class(s), it saves the name and data type of each
///      defined field that has an `@monitor` annotation.
class ModelVisitor extends SimpleElementVisitor2<void> {
  String                className = '';
  Map<String, DartType> fields    = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    className = element.returnType.toString();

    super.visitConstructorElement(element);
  }

  @override
  void visitFieldElement(FieldElement element) {
    if (TypeChecker.typeNamed(Monitor).hasAnnotationOf(element)) {
      fields[element.name!] = element.type;
    }
    super.visitFieldElement(element);
  }
}
