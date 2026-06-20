import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:data_monitor/annotations.dart';

/// The `ClassVisitor` class is called by `DataMonitorGenerator` when the
/// generators are invoked by the 'build_runner' command.
///
/// It performs three functions:
///
///   1. It saves the name of any class which has an `@dataMonitor
///    ` annotation.
///
///   2. For those class(s), it saves the name and data type of each
///      defined field that has an `@monitor` annotation.
///
///   3. It then adds property getters that have an @cache annotation
///      to a map for each field that is referred to by the getter.
class ClassVisitor {
  final Resolver _resolver;

  String                      className  = '';
  Map<String, FieldContainer> fields     = {};

  ClassVisitor({required this._resolver});

  Future<void> visitClass(ClassElement element) async {
    className = element.name!;

    for (FieldElement fieldElement in element.fields) {
      await visitClassField(fieldElement);
    }
    for (GetterElement getterElement in element.getters) {
      await visitClassGetter(getterElement);
    }
  }

  Future<void> visitClassField(FieldElement element) async {
    if (TypeChecker.typeNamed(Monitor).hasAnnotationOf(element)) {
      fields[element.name!] = FieldContainer(element.type);
    }
  }

  Future<void> visitClassGetter(GetterElement element) async {
    if (TypeChecker.typeNamed(Cache).hasAnnotationOf(element)) {
      AstNode? codeFragment = await _resolver.astNodeFor(element.firstFragment);
      String?  codeSource   = codeFragment?.toSource();

      if (codeSource != null) {
        for (String fieldName in fields.keys) {
          if (codeSource.contains(fieldName)) {
            fields[fieldName]![element.name!] = element.returnType;
          }
        }
      }
    }
  }
}

class FieldContainer
{
  final DartType              type;
  final Map<String, DartType> properties = {};

  FieldContainer(this.type);

  void operator []=(String name, DartType type) {
    properties[name] = type;
  }
}
