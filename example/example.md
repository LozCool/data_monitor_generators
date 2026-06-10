## Example
This package should be used with the `data_monitor` package to
allow Flutter projects to generate a concrete framework from their
`@annotations` found elsewhere in their source tree.


Include the following in your Flutter application's `pubspec.yaml`
as developer dependencies:

```
dev_dependencies:
  build_runner: ^2.15.0
  data_monitor_generators: ^1.0.0
```

Then run (in a console) the following before you build / run your
application:

```
dart run build_runner build
```
