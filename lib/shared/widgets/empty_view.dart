import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    this.message = 'Gosterilecek veri yok.',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
