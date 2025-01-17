import 'package:flutter_test/flutter_test.dart';

import 'package:streamline/streamline.dart';

part 'option.dart';

void main() {
  tearDown(Mediator.dispose);
  group("Option", _optionTests);
}
