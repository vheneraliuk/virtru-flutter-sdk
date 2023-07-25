class NativeError extends Error {
  final int status;
  final String message;

  NativeError(this.status, this.message);
}
