// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:thrifter/main.dart';

class IntroImagePickerWidget extends StatelessWidget {
  const IntroImagePickerWidget({
    super.key,
  });

  void _pickImage(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((pickedFile) {
      if (pickedFile != null) {
        settings.put(userImageKey, pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>(),
      child: SafeArea(
        child: Column(
          children: [
            IntroTopWidget(
              title: context.loc.image,
              icon: Icons.camera_enhance,
              description: context.loc.imageDesc,
            ),
            Center(
              child: PaisaUserImageWidget(
                pickImage: () => _pickImage(context),
                maxRadius: 72,
                useDefault: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IntroTopWidget extends StatelessWidget {
  const IntroTopWidget({
    super.key,
    required this.title,
    this.titleWidget,
    this.description,
    required this.icon,
  });

  final String? description;
  final IconData icon;
  final String title;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              context.primary,
              BlendMode.srcIn,
            ),
            child: Icon(
              icon,
              size: 72,
            ),
          ),
          const SizedBox(height: 16),
          titleWidget ??
              Text(
                title,
                style: context.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.onSurface,
                ),
              ),
          const SizedBox(height: 6),
          if (description != null)
            Text(
              description!,
              style: context.titleSmall?.copyWith(
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
              ),
            )
          else
            const SizedBox.shrink(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
