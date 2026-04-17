import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/shared/widgets/map_section_container.dart';

class DepremMapSection extends StatelessWidget {
  const DepremMapSection({
    super.key,
    required this.activePointCount,
  });

  final int activePointCount;

  @override
  Widget build(BuildContext context) {
    return MapSectionContainer(
      title: 'Olay Haritası',
      badge: '$activePointCount aktif nokta',
      height: 240,
    );
  }
}
