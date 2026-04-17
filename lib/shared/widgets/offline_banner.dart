import 'package:flutter/material.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({
    super.key,
    this.message = 'Şu anda çevrimdışı veri gösteriliyor.',
    this.bannerKey,
  });

  final String message;
  final Key? bannerKey;

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      key: bannerKey,
      content: Text(message),
      actions: const [SizedBox.shrink()],
    );
  }
}
