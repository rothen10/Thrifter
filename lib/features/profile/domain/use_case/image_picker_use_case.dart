// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:thrifter/core/error/failures.dart';
import 'package:thrifter/features/profile/domain/repository/profile_repository.dart';

@lazySingleton
class ImagePickerUseCase {
  final ProfileRepository profileRepository;

  ImagePickerUseCase(this.profileRepository);

  Future<Either<Failure, bool>> call() => profileRepository.pickImageAndSave();
}
