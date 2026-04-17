class MarketsSnapshot {
  const MarketsSnapshot({
    required this.lastUpdatedLabel,
    required this.highlights,
    required this.allQuotes,
    required this.trend,
  });

  final String lastUpdatedLabel;
  final List<MarketQuote> highlights;
  final List<MarketQuote> allQuotes;
  final List<MarketTrendPoint> trend;
}

class MarketQuote {
  const MarketQuote({
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
}

class MarketTrendPoint {
  const MarketTrendPoint({
    required this.label,
    required this.value,
  });

  final String label;
  final double value;
}
