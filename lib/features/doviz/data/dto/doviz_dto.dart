import 'package:guvenli_sehrim/features/doviz/domain/model/market_models.dart';

class MarketsSnapshotDto {
  const MarketsSnapshotDto({
    required this.lastUpdatedLabel,
    required this.highlightCodes,
    required this.allQuotes,
    required this.trend,
  });

  final String lastUpdatedLabel;
  final List<String> highlightCodes;
  final List<MarketQuoteDto> allQuotes;
  final List<MarketTrendPointDto> trend;

  factory MarketsSnapshotDto.fromJson(Map<String, dynamic> json) {
    return MarketsSnapshotDto(
      lastUpdatedLabel: json['sonGuncelleme'] as String? ?? '',
      highlightCodes: (json['onecikanlar'] as List<dynamic>? ?? const [])
          .cast<String>()
          .toList(growable: false),
      allQuotes: (json['kurlar'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(MarketQuoteDto.fromJson)
          .toList(growable: false),
      trend: (json['trend'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(MarketTrendPointDto.fromJson)
          .toList(growable: false),
    );
  }

  MarketsSnapshot toDomain() {
    final quotes = allQuotes.map((item) => item.toDomain()).toList(growable: false);
    final highlightSet = highlightCodes.toSet();
    return MarketsSnapshot(
      lastUpdatedLabel: lastUpdatedLabel,
      highlights: quotes
          .where((item) => highlightSet.contains(item.code))
          .toList(growable: false),
      allQuotes: quotes,
      trend: trend.map((item) => item.toDomain()).toList(growable: false),
    );
  }
}

class MarketQuoteDto {
  const MarketQuoteDto({
    required this.code,
    required this.name,
    required this.buyPrice,
    required this.sellPrice,
    required this.dailyChangePercent,
    required this.isFavorite,
  });

  final String code;
  final String name;
  final double buyPrice;
  final double sellPrice;
  final double dailyChangePercent;
  final bool isFavorite;

  factory MarketQuoteDto.fromJson(Map<String, dynamic> json) {
    return MarketQuoteDto(
      code: json['kod'] as String? ?? '',
      name: json['ad'] as String? ?? '',
      buyPrice: (json['alis'] as num? ?? 0).toDouble(),
      sellPrice: (json['satis'] as num? ?? 0).toDouble(),
      dailyChangePercent: (json['degisim'] as num? ?? 0).toDouble(),
      isFavorite: json['favori'] as bool? ?? false,
    );
  }

  MarketQuote toDomain() {
    return MarketQuote(
      code: code,
      name: name,
      buyPrice: buyPrice,
      sellPrice: sellPrice,
      dailyChangePercent: dailyChangePercent,
      isFavorite: isFavorite,
    );
  }
}

class MarketTrendPointDto {
  const MarketTrendPointDto({
    required this.label,
    required this.value,
  });

  final String label;
  final double value;

  factory MarketTrendPointDto.fromJson(Map<String, dynamic> json) {
    return MarketTrendPointDto(
      label: json['etiket'] as String? ?? '',
      value: (json['deger'] as num? ?? 0).toDouble(),
    );
  }

  MarketTrendPoint toDomain() {
    return MarketTrendPoint(label: label, value: value);
  }
}
