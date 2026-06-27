import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/data_monitor_generator.dart';

/// Called by `build_runner` to generate required '.g.dart' files.
Builder generateBuilders(BuilderOptions options) {
  return SharedPartBuilder([DataMonitorGenerator()], 'data_monitor');
}
