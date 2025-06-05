import 'package:ruko/app/app.dart';
import 'package:ruko/core/bootstrap.dart';

void main() {
  Bootstrap.production(() async => const App());
}
