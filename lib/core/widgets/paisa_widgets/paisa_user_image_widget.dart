// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:thrifter/core/common.dart';
import 'package:thrifter/features/profile/presentation/cubit/profile_cubit.dart';

class PaisaUserImageWidget extends StatelessWidget {
  const PaisaUserImageWidget({
    super.key,
    required this.pickImage,
    this.maxRadius,
    this.useDefault = false,
  });

  final double? maxRadius;
  final VoidCallback pickImage;
  final bool useDefault;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: context
          .read<ProfileCubit>()
          .settings
          .listenable(keys: [userImageKey]),
      builder: (context, value, _) {
        String image = value.get(userImageKey, defaultValue: '');
        if (image == 'no-image') {
          image = '';
        }
        try {
          return GestureDetector(
            onTap: pickImage,
            child: Builder(
              builder: (context) {
                if (image.isEmpty) {
                  return CircleAvatar(
                    backgroundColor: context.primary,
                    maxRadius: maxRadius,
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: context.onPrimary,
                    ),
                  );
                } else {
                  if (useDefault) {
                    return CircleAvatar(
                      foregroundImage: FileImage(File(image)),
                      maxRadius: maxRadius,
                    );
                  } else {
                    return Badge(
                      alignment: AlignmentDirectional.bottomEnd,
                      label: GestureDetector(
                        onTap: () {
                          value.put(userImageKey, '');
                        },
                        child: Center(
                          child: Icon(
                            MdiIcons.delete,
                            size: 8,
                            color: context.onPrimary,
                          ),
                        ),
                      ),
                      backgroundColor: context.primary,
                      child: CircleAvatar(
                        foregroundImage: FileImage(File(image)),
                        maxRadius: maxRadius,
                      ),
                    );
                  }
                }
              },
            ),
          );
        } catch (er) {
          return CircleAvatar(
            backgroundColor: context.primary,
            maxRadius: maxRadius,
            child: Icon(
              Icons.account_circle_outlined,
              color: context.onPrimary,
            ),
          );
        }
      },
    );
  }
}
