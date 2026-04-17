import 'package:guvenli_sehrim/features/deprem/domain/model/earthquake_models.dart';

class EarthquakeFeedDto {
  const EarthquakeFeedDto({
    required this.generatedAt,
    required this.summary,
    required this.filterOptions,
    required this.events,
  });

  final DateTime generatedAt;
  final EarthquakeSummaryDto summary;
  final List<EarthquakeFilterOptionDto> filterOptions;
  final List<EarthquakeEventDto> events;

  factory EarthquakeFeedDto.fromJson(Map<String, dynamic> json) {
    return EarthquakeFeedDto(
      generatedAt: DateTime.parse(json['olusturmaZamani'] as String),
      summary: EarthquakeSummaryDto.fromJson(
        json['ozet'] as Map<String, dynamic>? ?? const {},
      ),
      filterOptions: (json['filtreler'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(EarthquakeFilterOptionDto.fromJson)
          .toList(growable: false),
      events: (json['depremler'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(EarthquakeEventDto.fromJson)
          .toList(growable: false),
    );
  }

  EarthquakeFeed toDomain() {
    final eventModels = events.map((item) => item.toDomain()).toList(growable: false);
    return EarthquakeFeed(
      generatedAt: generatedAt,
      summary: summary.toDomain(),
      events: eventModels,
      mapPoints: eventModels
          .map(
            (item) => EarthquakeMapPoint(
              eventId: item.id,
              latitude: item.latitude,
              longitude: item.longitude,
              magnitude: item.magnitude,
            ),
          )
          .toList(growable: false),
      filterOptions:
          filterOptions.map((item) => item.toDomain()).toList(growable: false),
    );
  }
}

class EarthquakeSummaryDto {
  const EarthquakeSummaryDto({
    required this.last24HoursCount,
    required this.maxMagnitude,
    required this.nearestCity,
    required this.averageDepthKm,
  });

  final int last24HoursCount;
  final double maxMagnitude;
  final String nearestCity;
  final double averageDepthKm;

  factory EarthquakeSummaryDto.fromJson(Map<String, dynamic> json) {
    return EarthquakeSummaryDto(
      last24HoursCount: json['son24SaatAdet'] as int? ?? 0,
      maxMagnitude: (json['enBuyukMagnitud'] as num? ?? 0).toDouble(),
      nearestCity: json['enYakinSehir'] as String? ?? '',
      averageDepthKm: (json['ortalamaDerinlikKm'] as num? ?? 0).toDouble(),
    );
  }

  EarthquakeSummary toDomain() {
    return EarthquakeSummary(
      last24HoursCount: last24HoursCount,
      maxMagnitude: maxMagnitude,
      nearestCity: nearestCity,
      averageDepthKm: averageDepthKm,
    );
  }
}

class EarthquakeFilterOptionDto {
  const EarthquakeFilterOptionDto({
    required this.code,
    required this.label,
  });

  final String code;
  final String label;

  factory EarthquakeFilterOptionDto.fromJson(Map<String, dynamic> json) {
    return EarthquakeFilterOptionDto(
      code: json['kod'] as String? ?? '',
      label: json['etiket'] as String? ?? '',
    );
  }

  EarthquakeFilterOption toDomain() {
    return EarthquakeFilterOption(code: code, label: label);
  }
}

class EarthquakeEventDto {
  const EarthquakeEventDto({
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

  factory EarthquakeEventDto.fromJson(Map<String, dynamic> json) {
    return EarthquakeEventDto(
      id: json['id'] as String? ?? '',
      locationName: json['yer'] as String? ?? '',
      city: json['sehir'] as String? ?? '',
      magnitude: (json['buyukluk'] as num? ?? 0).toDouble(),
      depthKm: (json['derinlikKm'] as num? ?? 0).toDouble(),
      occurredAt: DateTime.parse(json['zaman'] as String),
      latitude: (json['enlem'] as num? ?? 0).toDouble(),
      longitude: (json['boylam'] as num? ?? 0).toDouble(),
      alertLevel: json['uyariSeviyesi'] as String? ?? '',
      didUserFeelIt: json['hissedildi'] as bool? ?? false,
    );
  }

  EarthquakeEvent toDomain() {
    return EarthquakeEvent(
      id: id,
      locationName: locationName,
      city: city,
      magnitude: magnitude,
      depthKm: depthKm,
      occurredAt: occurredAt,
      latitude: latitude,
      longitude: longitude,
      alertLevel: alertLevel,
      didUserFeelIt: didUserFeelIt,
    );
  }
}

class EarthquakeDetailDto {
  const EarthquakeDetailDto({
    required this.eventId,
    required this.closestDistrict,
    required this.distanceToDistrictKm,
    required this.riskNote,
    required this.aftershockHistory,
  });

  final String eventId;
  final String closestDistrict;
  final double distanceToDistrictKm;
  final String riskNote;
  final List<double> aftershockHistory;

  factory EarthquakeDetailDto.fromJson(Map<String, dynamic> json) {
    return EarthquakeDetailDto(
      eventId: json['id'] as String? ?? '',
      closestDistrict: json['enYakinIlce'] as String? ?? '',
      distanceToDistrictKm: (json['mesafeKm'] as num? ?? 0).toDouble(),
      riskNote: json['riskNotu'] as String? ?? '',
      aftershockHistory: (json['artciGecmisi'] as List<dynamic>? ?? const [])
          .cast<num>()
          .map((item) => item.toDouble())
          .toList(growable: false),
    );
  }

  EarthquakeDetail toDomain(EarthquakeEvent event) {
    return EarthquakeDetail(
      event: event,
      closestDistrict: closestDistrict,
      distanceToDistrictKm: distanceToDistrictKm,
      riskNote: riskNote,
      aftershockHistory: aftershockHistory,
    );
  }
}
