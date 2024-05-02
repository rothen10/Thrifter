// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/common.dart';
import 'package:thrifter/core/widgets/paisa_widget.dart';
import 'package:thrifter/features/settings/data/authenticate.dart';
import 'package:thrifter/main.dart';

class BiometricPage extends StatefulWidget {
  const BiometricPage({super.key});

  @override
  State<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends State<BiometricPage> {
  @override
  void initState() {
    super.initState();
    checkBiometrics();
  }

  Future<void> checkBiometrics() async {
    final localAuth = getIt<Authenticate>();

    final bool canCheckBiometrics = await localAuth.canCheckBiometrics();

    if (canCheckBiometrics) {
      final bool result = await localAuth.authenticateWithBiometrics();
      if (result) {
        if (context.mounted) {
          const LandingPageData().go(context);
        }
      } else {
        //SystemNavigator.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PaisaBigButton(
            onPressed: () {
              checkBiometrics();
            },
            title: context.loc.authenticate,
          ),
        ),
      ),
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              MdiIcons.lock,
              color: context.primary,
            ),
          ),
          Text(
            context.loc.paisaLocked,
            style: context.headlineSmall,
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MdiIcons.fingerprint,
                    size: 72,
                  ),
                  Text(
                    context.loc.biometricMessage,
                    style: context.bodyMedium,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
