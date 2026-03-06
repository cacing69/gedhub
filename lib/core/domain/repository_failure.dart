import 'package:freezed_annotation/freezed_annotation.dart';

part 'repository_failure.freezed.dart';

/// Kegagalan operasi repository (database, not found, dll).
/// Dipakai dengan [dartz] Either di layer domain.
@freezed
abstract class RepositoryFailure with _$RepositoryFailure {
  const factory RepositoryFailure.database(String message) = _Database;
  const factory RepositoryFailure.notFound(String message) = _NotFound;
}
