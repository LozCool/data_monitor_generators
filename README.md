<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

## WARNING:

This package is in beta and still being tested. Please do not use it yet.

## Details

This package should be used with the `data_monitor` package to
allow Flutter projects to generate a concrete framework from their
`@annotations` found elsewhere in their source tree.

## Getting started

Please see the example in `data_monitor` for usage.

## Usage

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
