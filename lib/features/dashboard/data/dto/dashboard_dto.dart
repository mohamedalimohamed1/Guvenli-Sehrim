import 'package:guvenli_sehrim/features/dashboard/domain/model/dashboard_models.dart';

class DashboardSnapshotDto {
  const DashboardSnapshotDto({
    required this.city,
    required this.district,
    required this.lastUpdated,
    required this.cards,
    required this.alerts,
  });

  final String city;
  final String district;
  final DateTime lastUpdated;
  final List<DashboardCardSummaryDto> cards;
  final List<DashboardAlertDto> alerts;

  factory DashboardSnapshotDto.fromJson(Map<String, dynamic> json) {
    final location = json['konum'] as Map<String, dynamic>? ?? const {};
    return DashboardSnapshotDto(
      city: location['sehir'] as String? ?? '',
      district: location['ilce'] as String? ?? '',
      lastUpdated: DateTime.parse(json['sonGuncelleme'] as String),
      cards: (json['kartlar'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(DashboardCardSummaryDto.fromJson)
          .toList(growable: false),
      alerts: (json['uyarilar'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(DashboardAlertDto.fromJson)
          .toList(growable: false),
    );
  }

  DashboardSnapshot toDomain({bool isOffline = false}) {
    return DashboardSnapshot(
      city: city,
      district: district,
      lastUpdated: lastUpdated,
      isOffline: isOffline,
      cards: cards.map((item) => item.toDomain()).toList(growable: false),
      alerts: alerts.map((item) => item.toDomain()).toList(growable: false),
    );
  }
}

class DashboardCardSummaryDto {
  const DashboardCardSummaryDto({
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

  factory DashboardCardSummaryDto.fromJson(Map<String, dynamic> json) {
    return DashboardCardSummaryDto(
      featureKey: json['featureKey'] as String? ?? '',
      title: json['baslik'] as String? ?? '',
      primaryValue: json['anaDeger'] as String? ?? '',
      secondaryValue: json['ikincilDeger'] as String? ?? '',
      statusLabel: json['durum'] as String? ?? '',
    );
  }

  DashboardCardSummary toDomain() {
    return DashboardCardSummary(
      featureKey: featureKey,
      title: title,
      primaryValue: primaryValue,
      secondaryValue: secondaryValue,
      statusLabel: statusLabel,
    );
  }
}

class DashboardAlertDto {
  const DashboardAlertDto({
    required this.id,
    required this.title,
    required this.message,
    required this.severity,
  });

  final String id;
  final String title;
  final String message;
  final String severity;

  factory DashboardAlertDto.fromJson(Map<String, dynamic> json) {
    return DashboardAlertDto(
      id: json['id'] as String? ?? '',
      title: json['baslik'] as String? ?? '',
      message: json['mesaj'] as String? ?? '',
      severity: json['seviye'] as String? ?? '',
    );
  }

  DashboardAlert toDomain() {
    return DashboardAlert(
      id: id,
      title: title,
      message: message,
      severity: severity,
    );
  }
}
