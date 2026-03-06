import 'package:dartz/dartz.dart';
import 'package:gedhub/core/domain/repository_failure.dart';
import 'package:gedhub/features/projects/domain/project.dart';

/// Abstraksi repository project (implementasi: [ProjectsRepositoryImpl], fake: untuk test).
abstract interface class ProjectsRepository {
  Future<Either<RepositoryFailure, Project?>> getProjectById(int id);
  Future<Either<RepositoryFailure, int>> createProject({
    required String name,
    String? description,
    String? locale,
  });
  Future<Either<RepositoryFailure, bool>> updateProject(
    int id, {
    required String name,
    String? description,
    String? locale,
  });
  Future<Either<RepositoryFailure, bool>> deleteProject(int id);
  Stream<List<Project>> watchProjects();
}
