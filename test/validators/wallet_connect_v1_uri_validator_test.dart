import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_uri_validator/src/errors/wallet_connect_uri_validation_error.dart';
import 'package:wallet_connect_uri_validator/src/validators/wallet_connect_uri_validator.dart';
import 'package:wallet_connect_uri_validator/src/wallet_connect_uri.dart';

const wcV1UriValid =
    'wc:4acd9fa1-4350-4ddd-b31c-e22fa7bee8d0@1?bridge=https%3A%2F%2Fv.bridge.walletconnect.org&key=02eb8db0de49ccc186fb6bf5492d040148c538f0c27412a5431a90a1bf42a27d';

void main() {
  group(
    'WalletConnect URI validating valid uri:',
    () {
      final url = WalletConnectV1Uri.parse(wcV1UriValid);
      final validator = WalletConnectV1UriValidator(url);
      test(
        'validating a valid WalletConnect v1 URI returns isValid = true',
        () {
          expect(validator.isValid, isTrue);
        },
      );

      test(
        'validating a valid WalletConnect v1 URI does not have errors',
        () {
          expect(validator.errors, isEmpty);
        },
      );
    },
  );

  group(
    'WalletConnect URI validating invalid uri',
    () {
      const wcV1UriInvalid =
          'wc:4acd9fa1-4350-4ddd-b31c@1?bridge=https%3A%2F%2Fv.bridge.walletconnect.org&key=02eb8db0de49ccc186fb6bf5492d040148c538f0c27412a5431a90a1bf42a27d';
      final url = WalletConnectV1Uri.parse(wcV1UriInvalid);
      final validator = WalletConnectV1UriValidator(url);

      test(
        'validating an invalid WalletConnect v1 URI returns isValid = false',
        () {
          expect(validator.isValid, isFalse);
        },
      );

      test(
        'validating an invalid WalletConnect v1 URI has errors',
        () {
          expect(validator.errors, isNotEmpty);
        },
      );
    },
  );

  group(
    'WalletConnect URI validating uri segments:',
    () {
      test(
        'Validating a valid protocol',
        () {
          expect(
            () => WalletConnectV1UriValidator.validateProtocol('wc'),
            returnsNormally,
          );
        },
      );

      test(
        'Validating an invalid protocol',
        () {
          expect(
            () => WalletConnectV1UriValidator.validateProtocol('w'),
            throwsA(isA<WalletConnectUriValidationError>()),
          );
        },
      );

      test(
        'Validating a valid version',
        () {
          expect(
            () => WalletConnectV1UriValidator.validateVersion(
              WalletConnectVersion.v1,
            ),
            returnsNormally,
          );
        },
      );

      test(
        'Validating an invalid version',
        () {
          expect(
            () => WalletConnectV1UriValidator.validateVersion(
              WalletConnectVersion.unknown,
            ),
            throwsA(isA<WalletConnectUriValidationError>()),
          );
        },
      );

      test(
        'Validating a valid topic',
        () {
          expect(
            () => WalletConnectV1UriValidator.validateTopic(
              '4acd9fa1-4350-4ddd-b31c-e22fa7bee8d0',
            ),
            returnsNormally,
          );
        },
      );

      test(
        'Validating an invalid topic',
        () {
          expect(
            () => WalletConnectV1UriValidator.validateTopic(
              '4acd9fa1-4350-4ddd-b31c',
            ),
            throwsA(isA<WalletConnectUriValidationError>()),
          );
        },
      );

      test(
        'Validating a valid bridge',
        () {
          expect(
            () => WalletConnectV1UriValidator.validateBridge(
              'https://v.bridge.walletconnect.org',
            ),
            returnsNormally,
          );
        },
      );

      test(
        'Validating an invalid bridge',
        () {
          expect(
            () => WalletConnectV1UriValidator.validateBridge(
              'this-is-not-valid-url',
            ),
            throwsA(isA<WalletConnectUriValidationError>()),
          );
        },
      );

      test(
        'Validating a valid key',
        () {
          expect(
            () => WalletConnectV1UriValidator.validateKey(
              '02eb8db0de49ccc186fb6bf5492d040148c538f0c27412a5431a90a1bf42a27d',
            ),
            returnsNormally,
          );
        },
      );

      test(
        'Validating an invalid key',
        () {
          expect(
            () => WalletConnectV1UriValidator.validateKey(
              'this-is-not-valid-key',
            ),
            throwsA(isA<WalletConnectUriValidationError>()),
          );
        },
      );
    },
  );
}
