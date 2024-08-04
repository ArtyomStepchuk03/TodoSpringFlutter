import 'package:flutter/material.dart';

/// Виджет с индикатором загрузки и фоном.
class LoadingIndicatorWidget extends StatelessWidget {
  const LoadingIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) => Stack(children: [
        Container(color: Colors.white),
        const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        )
      ]);
}
