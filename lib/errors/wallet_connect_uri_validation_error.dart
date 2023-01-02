class WalletConnectUriValidationError {
  final String message;

  const WalletConnectUriValidationError({
    required this.message,
  });

  @override
  String toString() => '$runtimeType: $message';
}
