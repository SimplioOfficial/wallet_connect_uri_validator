/// WalletConnect URI validation error
/// It is thrown when any [WalletConnectUri] is invalid.
class WalletConnectUriValidationError {
  final String message;

  const WalletConnectUriValidationError({
    required this.message,
  });

  @override
  String toString() => '$runtimeType: $message';
}
