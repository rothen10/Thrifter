// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:thrifter/config/routes.dart';
import 'package:thrifter/core/common.dart';

class PaisaSearchButton extends StatelessWidget {
  const PaisaSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.search,
        color: context.onBackground,
      ),
      onPressed: () {
        const SearchPageData().push(context);
      },
    );
  }
}
