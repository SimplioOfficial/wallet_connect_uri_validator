part of 'wallet_connect_uri_validator.dart';

class WalletConnectV1UriValidator extends WalletConnectUriValidator {
  /// Validates a [WalletConnectV1Uri] object.
  /// It runs a sequence of validation checks on the [WalletConnectV1Uri] object.
  /// It records all the errors and returns them as a [Set] of [WalletConnectUriValidationError].
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

  /// Validate [WalletConnectV1Uri] topic.
  /// It should be a valid UUID v4 string.
  static void validateTopic(String topic) {
    final isValid = Uuid.isValidUUID(fromString: topic);
    if (isValid) return;
    throw const WalletConnectUriValidationError(
      message: 'Invalid topic',
    );
  }

  /// Validate [WalletConnectV1Uri] protocol.
  /// It should be equal to the generic 'wc' url scheme.
  static void validateProtocol(String protocol) {
    return WalletConnectUriValidator.validateProtocol(protocol);
  }

  /// Validate [WalletConnectV1Uri] version.
  /// It should be equal to [WalletConnectVersion.v1].
  static void validateVersion(WalletConnectVersion version) {
    return WalletConnectUriValidator.validateVersion(
      version,
      compareTo: WalletConnectVersion.v1,
    );
  }

  /// Validate [WalletConnectV1Uri] bridge.
  /// It should be a valid url encoded string.
  static void validateBridge(String bridge) {
    final decoded = Uri.decodeFull(bridge);
    if ((Uri.tryParse(decoded)?.host.isNotEmpty ?? false)) return;

    throw const WalletConnectUriValidationError(
      message: 'Invalid bridge',
    );
  }

  /// Validate [WalletConnectV1Uri] key.
  /// It should be a valid hex encoded string.
  static void validateKey(String key) {
    try {
      if (hex.decode(key).isEmpty) throw Exception();
    } on FormatException catch (_) {
      throw const WalletConnectUriValidationError(
        message: 'Invalid key',
      );
    }
  }

  @override
  final WalletConnectV1Uri uri;

  @override
  final Set<WalletConnectUriValidationError> errors;

  const WalletConnectV1UriValidator._({
    required this.uri,
    required this.errors,
  });

  WalletConnectV1UriValidator(WalletConnectV1Uri uri)
      : this._(uri: uri, errors: validate(uri));
}
