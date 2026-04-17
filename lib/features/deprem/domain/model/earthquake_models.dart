class EarthquakeFeed {
  const EarthquakeFeed({
    required this.generatedAt,
    required this.summary,
    required this.events,
    required this.mapPoints,
    required this.filterOptions,
  });

  final DateTime generatedAt;
  final EarthquakeSummary summary;
  final List<EarthquakeEvent> events;
  final List<EarthquakeMapPoint> mapPoints;
  final List<EarthquakeFilterOption> filterOptions;
}

class EarthquakeSummary {
  const EarthquakeSummary({
    required this.last24HoursCount,
    required this.maxMagnitude,
    required this.nearestCity,
    required this.averageDepthKm,
  });

  final int last24HoursCount;
  final double maxMagnitude;
  final String nearestCity;
  final double averageDepthKm;
}

class EarthquakeEvent {
  const EarthquakeEvent({
    required this.id,
    required this.locationName,
    required this.city,
    required this.magnitude,
    required this.depthKm,
    required this.occurredAt,
    required this.latitude,
    required this.longitude,
    required this.alertLevel,
    required this.didUserFeelIt,
  });

  final String id;
  final String locationName;
  final String city;
  final double magnitude;
  final double depthKm;
  final DateTime occurredAt;
  final double latitude;
  final double longitude;
  final String alertLevel;
  final bool didUserFeelIt;
}

class EarthquakeMapPoint {
  const EarthquakeMapPoint({
    required this.eventId,
    required this.latitude,
    required this.longitude,
    required this.magnitude,
  });

  final String eventId;
  final double latitude;
  final double longitude;
  final double magnitude;
}

class EarthquakeFilterOption {
  const EarthquakeFilterOption({
    required this.code,
    required this.label,
  });

  final String code;
  final String label;
}

class EarthquakeDetail {
  const EarthquakeDetail({
    required this.event,
    required this.closestDistrict,
    required this.distanceToDistrictKm,
    required this.riskNote,
    required this.aftershockHistory,
  });

  final EarthquakeEvent event;
  final String closestDistrict;
  final double distanceToDistrictKm;
  final String riskNote;
  final List<double> aftershockHistory;
}
