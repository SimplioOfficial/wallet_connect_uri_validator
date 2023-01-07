part of 'wallet_connect_uri_validator.dart';

/// Semantics
/// Required parameters are dependent on the WalletConnect protocol version:
///
/// For WalletConnect v1.0 protocol (version=1) the parameters are:
///
/// key - symmetric key used for encryption
/// bridge - url of the bridge server for relaying messages

class WalletConnectV1UriValidator extends WalletConnectUriValidator {
  static Set<WalletConnectUriValidationError> validate(
    WalletConnectV1Uri uri,
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
    final decoded = Uri.decodeFull(bridge);
    if ((Uri.tryParse(decoded)?.host.isNotEmpty ?? false)) return;

    throw const WalletConnectUriValidationError(
      message: 'Invalid bridge',
    );
  }

  static void validateKey(String key) {
    // TODO - check if decode does not throw an exception
    if (hex.decode(key).isNotEmpty) return;

    throw const WalletConnectUriValidationError(
      message: 'Invalid key',
    );
  }

  const WalletConnectV1UriValidator._({
    required this.uri,
    required this.errors,
  });

  WalletConnectV1UriValidator(WalletConnectV1Uri uri)
      : this._(uri: uri, errors: validate(uri));

  @override
  final WalletConnectV1Uri uri;

  @override
  final Set<WalletConnectUriValidationError> errors;
}
