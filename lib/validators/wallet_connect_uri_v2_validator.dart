part of 'wallet_connect_uri_validator.dart';

/// For WalletConnect v2.0 protocol (version=2) the parameters are:
///
/// symKey - symmetric key used for encrypting messages over relay
/// relay-protocol - transport protocol for relaying messages
/// relay-data - (optional) transport data for relaying messages

class WalletConnectUriV2Validator extends WalletConnectUriValidator {
  static Set<WalletConnectUriValidationError> validate(
    WalletConnectUriV2 uri,
  ) {
    final Set<WalletConnectUriValidationError> errors = {};

    try {
      validateProtocol(uri.protocol);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      validateTopic(uri.topic);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      validateVersion(uri.version);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      validateSymKey(uri.symKey);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      validateRelayProtocol(uri.relayProtocol);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    try {
      validateRelayData(uri.relayData);
    } on WalletConnectUriValidationError catch (e) {
      errors.add(e);
    }

    return errors;
  }

  static void validateProtocol(String protocol) {
    return WalletConnectUriValidator.validateProtocol(protocol);
  }

  // TODO - V2 topic is a sha256 hash. We cannot check its checksum. Therefore, we can validate only its length and byte size.
  static void validateTopic(String topic) {
    // TODO - implement topic validation.
    throw const WalletConnectUriValidationError(
      message: 'Invalid topic',
    );
  }

  static void validateVersion(WalletConnectVersion version) {
    return WalletConnectUriValidator.validateVersion(version);
  }

  static void validateRelayProtocol(String protocol) {
    try {
      final decoded = Uri.decodeFull(protocol);
      final isValid = Uri.parse(decoded).host.isNotEmpty;
      if (isValid) return;
      throw Exception();
    } catch (_) {
      throw const WalletConnectUriValidationError(
        message: 'Invalid relay protocol',
      );
    }
  }

  static void validateRelayData(String? data) {
    if (data == null) return;
    // TODO - implement relay data validation.
    throw const WalletConnectUriValidationError(
      message: 'Invalid relay data',
    );
  }

  static void validateSymKey(String key) {
    final isValid = hex.decode(key).isNotEmpty;
    if (isValid) return;
    throw const WalletConnectUriValidationError(
      message: 'Invalid symmetric key',
    );
  }

  const WalletConnectUriV2Validator._({
    required this.uri,
    required this.errors,
  });

  WalletConnectUriV2Validator(WalletConnectUriV2 uri)
      : this._(uri: uri, errors: validate(uri));

  @override
  final WalletConnectUriV2 uri;

  @override
  final Set<WalletConnectUriValidationError> errors;

  @override
  bool get isValid => errors.isEmpty;
}
