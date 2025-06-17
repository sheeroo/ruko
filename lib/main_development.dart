import 'package:ruko/app/app.dart';
import 'package:ruko/core/bootstrap.dart';

void main() {
  Bootstrap.development(() async => const App());
}
