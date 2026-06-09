import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor2.dart';
// import 'package:data_monitor/annotations.dart';
import 'package:source_gen/source_gen.dart';

// class ModelVisitor extends SimpleElementVisitor2<void> {
//   String                className = '';
//   Map<String, DartType> fields    = {};
//
//   @override
//   void visitConstructorElement(ConstructorElement element) {
//     className = element.returnType.toString();
//
//     super.visitConstructorElement(element);
//   }
//
//   @override
//   void visitFieldElement(FieldElement element) {
//     if (TypeChecker.typeNamed(Monitor).hasAnnotationOf(element)) {
//       fields[element.name!] = element.type;
//     }
//     super.visitFieldElement(element);
//   }
// }
