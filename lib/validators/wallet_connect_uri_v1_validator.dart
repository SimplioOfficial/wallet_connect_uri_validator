part of 'wallet_connect_uri_validator.dart';

/// Semantics
/// Required parameters are dependent on the WalletConnect protocol version:
///
/// For WalletConnect v1.0 protocol (version=1) the parameters are:
///
/// key - symmetric key used for encryption
/// bridge - url of the bridge server for relaying messages

class WalletConnectUriV1Validator extends WalletConnectUriValidator {
  static Set<WalletConnectUriValidationError> validate(
    WalletConnectUriV1 uri,
  ) {
    final Set<WalletConnectUriValidationError> errors = {};

    try {
      WalletConnectUriValidator.validateProtocol(uri.protocol);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      validateTopic(uri.topic);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      WalletConnectUriValidator.validateVersion(uri.version);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      validateBridge(uri.bridge);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      validateKey(uri.key);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    return errors;
  }

  static void validateTopic(String topic) {
    print(topic);
    final isValid = Uuid.isValidUUID(fromString: topic);
    if (isValid) return;
    throw const WalletConnectUriValidationError(
      message: 'Invalid topic',
    );
  }

  static void validateProtocol(String protocol) {
    return WalletConnectUriValidator.validateProtocol(protocol);
  }

  static void validateVersion(WalletConnectVersion version) {
    return WalletConnectUriValidator.validateVersion(
      version,
      compareTo: WalletConnectVersion.v1,
    );
  }

  static void validateBridge(String bridge) {
    print('bridge: $bridge');
    try {
      final decoded = Uri.decodeFull(bridge);
      Uri.parse(decoded).host.isNotEmpty;
    } catch (_) {
      throw const WalletConnectUriValidationError(
        message: 'Invalid bridge',
      );
    }
  }

  static void validateKey(String key) {
    print('key: $key');
    try {
      hex.decode(key).isNotEmpty;
    } catch (_) {
      throw const WalletConnectUriValidationError(
        message: 'Invalid key',
      );
    }
  }

  const WalletConnectUriV1Validator._({
    required this.uri,
    required this.errors,
  });

  WalletConnectUriV1Validator(WalletConnectUriV1 uri)
      : this._(uri: uri, errors: validate(uri));

  @override
  final WalletConnectUriV1 uri;

  @override
  final Set<WalletConnectUriValidationError> errors;
}




// # 1.0
// wc:8a5e5bdc-a0e4-4702-ba63-8f1a5655744f@1?bridge=https%3A%2F%2Fbridge.walletconnect.org&key=41791102999c339c844880b23950704cc43aa840f3739e365323cda4dfa89e7a

// # 2.0
// wc:c9e6d30fb34afe70a15c14e9337ba8e4d5a35dd695c39b94884b0ee60c69d168@2?relay-protocol=waku&symKey=7ff3e362f825ab868e20e767fe580d0311181632707e7c878cbeca0238d45b8b
// library wallet_connect_uri_validator;
