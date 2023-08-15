/// Error objects thrown in the case of a Virtru Client operation failure.
class NativeError extends Error {
  /// Status of the operation.
  final int status;

  /// Error message.
  final String message;

  NativeError(this.status, this.message);
}
