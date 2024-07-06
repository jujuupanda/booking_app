import 'package:flutter/material.dart';

import 'src/presentation/utils/routes/route_app.dart';

class Apps extends StatelessWidget {
  const Apps({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        routerConfig: routeApp,
      ),
    );
  }
}
