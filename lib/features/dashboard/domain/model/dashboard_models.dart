class DashboardSnapshot {
  const DashboardSnapshot({
    required this.city,
    required this.district,
    required this.lastUpdated,
    required this.isOffline,
    required this.cards,
    required this.alerts,
  });

  final String city;
  final String district;
  final DateTime lastUpdated;
  final bool isOffline;
  final List<DashboardCardSummary> cards;
  final List<DashboardAlert> alerts;
}

class DashboardCardSummary {
  const DashboardCardSummary({
    required this.featureKey,
    required this.title,
    required this.primaryValue,
    required this.secondaryValue,
    required this.statusLabel,
  });

  final String featureKey;
  final String title;
  final String primaryValue;
  final String secondaryValue;
  final String statusLabel;
}

class DashboardAlert {
  const DashboardAlert({
    required this.id,
    required this.title,
    required this.message,
    required this.severity,
  });

  final String id;
  final String title;
  final String message;
  final String severity;
}
