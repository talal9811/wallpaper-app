import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Center(
            child: CircularProgressIndicator(
          color: color ?? Theme.of(context).colorScheme.primary,
        )));
  }
}