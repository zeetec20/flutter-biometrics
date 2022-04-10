import 'package:app/service/biometrics_service.dart';
import 'package:app/utils/biometrics_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'biometrics_test.mocks.dart';

@GenerateMocks([BiometricsService])
void main() {
  MockBiometricsService biometricsService = MockBiometricsService();

  group('biometrics', () {
    test('check available biometrics', () async {
      when(biometricsService.checkAvailableBiometrics())
          .thenAnswer((_) async => true);

      expect(await biometricsService.checkAvailableBiometrics(), isA<bool>());
    });

    test('try auth', () async {
      when(biometricsService.tryAuth('reason'))
          .thenAnswer((_) async => BiometricsResult(true));
      BiometricsResult result = await biometricsService.tryAuth('reason');

      expect(result.success, isTrue);
    });
  });
}
