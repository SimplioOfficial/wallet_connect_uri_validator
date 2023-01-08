part of 'wallet_connect_uri_validator.dart';

class WalletConnectV2UriValidator extends WalletConnectUriValidator {
  /// Validates a [WalletConnectV2Uri] object.
  /// It runs a sequence of validation checks on the [WalletConnectV2Uri] object.
  /// It records all the errors and returns them as a [Set] of [WalletConnectUriValidationError].
  static Set<WalletConnectUriValidationError> validate(
    WalletConnectV2Uri uri,
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

  /// Validate [WalletConnectV2Uri] protocol.
  /// It should be equal to the generic 'wc' url scheme.
  static void validateProtocol(String protocol) {
    return WalletConnectUriValidator.validateProtocol(protocol);
  }

  /// Validate [WalletConnectV2Uri] topic.
  /// It checks if the topic is hex encoded
  /// but it does not checks its (32 bytes) size.
  static void validateTopic(String topic) {
    try {
      final bytes = Uint8List.fromList(utf8.encoder.convert(topic));
      if (bytes.isEmpty) throw Exception();
    } catch (_) {
      throw const WalletConnectUriValidationError(
        message: 'Topic is empty',
      );
    }
  }

  /// Validate [WalletConnectV2Uri] version.
  /// It should be equal to [WalletConnectVersion.v2].
  static void validateVersion(WalletConnectVersion version) {
    return WalletConnectUriValidator.validateVersion(
      version,
      compareTo: WalletConnectVersion.v2,
    );
  }

  /// Validate [WalletConnectV2Uri] relay protocol.
  /// It checks if the relay protocol is empty.
  /// There is no other validation for the relay protocol.
  ///
  /// TODO - we can find out the list of supported protocols.
  static void validateRelayProtocol(String protocol) {
    if (protocol.isEmpty) {
      throw const WalletConnectUriValidationError(
        message: 'Invalid relay protocol',
      );
    }
    return;
  }

  /// Validate [WalletConnectV2Uri] relay data.
  /// It checks if the relay data is hex encoded if provided.
  static void validateRelayData([String? data]) {
    if (data == null || data.isEmpty) return;

    try {
      if (hex.decode(data).isEmpty) throw Exception();
    } catch (_) {
      throw const WalletConnectUriValidationError(
        message: 'Relay Data are not valid hex string',
      );
    }
  }

  /// Validate [WalletConnectV2Uri] symmetric key.
  /// It checks if the symmetric key is hex encoded.
  /// and if it has a valid length.
  static void validateSymKey(String key) {
    try {
      if (hex.decode(key).isEmpty) throw Exception();
    } catch (_) {
      throw const WalletConnectUriValidationError(
        message: 'Symmetric key is not valid hex string',
      );
    }

    final bytes = Uint8List.fromList(utf8.encoder.convert(key));

    if (bytes.isEmpty) {
      throw const WalletConnectUriValidationError(
        message: 'Symmetric key is empty',
      );
    }

    switch (bytes.length) {
      case 64:
        break;
      default:
        throw const WalletConnectUriValidationError(
          message: 'Symmetric key does not have a valid length',
        );
    }

    return;
  }

  @override
  final WalletConnectV2Uri uri;

  @override
  final Set<WalletConnectUriValidationError> errors;

  const WalletConnectV2UriValidator._({
    required this.uri,
    required this.errors,
  });

  WalletConnectV2UriValidator(WalletConnectV2Uri uri)
      : this._(uri: uri, errors: validate(uri));
}
