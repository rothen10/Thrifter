// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/error/failures.dart';
import 'package:thrifter/features/profile/domain/repository/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(
    this.imagePicker,
    @Named('settings') this.settings,
  );

  final ImagePicker imagePicker;
  final Box<dynamic> settings;

  @override
  Future<Either<Failure, bool>> pickImageAndSave() async {
    try {
      final XFile? imageFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        final String path = await _saveImageFileToCache(imageFile);
        await settings.put(userImageKey, path);
        return right(true);
      } else {
        return left(FileNotFoundFailure());
      }
    } catch (err) {
      debugPrint(err.toString());
      return left(ErrorImagePickFailure());
    }
  }

  Future<String> _saveImageFileToCache(XFile xFile) async {
    final Directory directory = await getTemporaryDirectory();
    final cachePath = '${directory.path}/profile_picture.jpg';
    final imageFile = File(xFile.path);
    await imageFile.copy(cachePath);
    return cachePath;
  }
}
