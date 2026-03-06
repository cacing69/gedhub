import 'package:dartz/dartz.dart';
import 'package:gedhub/core/domain/repository_failure.dart';
import 'package:gedhub/features/peoples/domain/person.dart';

/// Abstraksi repository kontak (implementasi: [ContactsRepositoryImpl], fake: untuk test).
abstract interface class ContactsRepository {
  Future<Either<RepositoryFailure, int>> createContact({
    required int projectId,
    required int personId,
    required String provider,
    required String contactType,
    required String value,
    String? label,
    String? providerContactId,
    int? sortOrder,
    String? notes,
  });
  Future<Either<RepositoryFailure, bool>> updateContact(
    int id, {
    required String provider,
    required String contactType,
    required String value,
    String? label,
    String? providerContactId,
    int? sortOrder,
    String? notes,
  });
  Future<Either<RepositoryFailure, bool>> deleteContact(int id);
  Stream<List<Contact>> watchContacts(int personId);
}
