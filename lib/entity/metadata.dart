/// Metadata for a secure share.
class SecureShareMetadata {
  /// Create a new [SecureShareMetadata] instance.
  /// The [policyId] is the policy id of the TDF.
  /// The [name] is the name of the encrypted file.
  /// The [size] is the size of the encrypted file.
  /// The [rcaLink] is the link to the remote content access (RCA).
  SecureShareMetadata({
    required this.policyId,
    required this.name,
    required this.size,
    required this.rcaLink,
  });

  final String policyId;
  final String name;
  final int size;
  final String rcaLink;
}
