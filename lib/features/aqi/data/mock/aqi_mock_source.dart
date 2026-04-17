const Map<String, dynamic> aqiPayload = {
  'sehir': 'İstanbul',
  'anaIstasyon': 'Üsküdar Sahil',
  'aqi': 85,
  'kategori': 'Orta',
  'renk': '#F2C94C',
  'oneri':
      'Hassas gruplar öğle saatlerinde açık havada uzun süre kalırken dikkatli olmalıdır.',
  'trend': [
    {'saat': '06:00', 'deger': 54},
    {'saat': '09:00', 'deger': 63},
    {'saat': '12:00', 'deger': 78},
    {'saat': '15:00', 'deger': 85},
    {'saat': '18:00', 'deger': 71},
  ],
  'istasyonlar': [
    {
      'id': 'uskudar',
      'ad': 'Üsküdar Sahil',
      'ilce': 'Üsküdar',
      'aqi': 85,
      'kategori': 'Orta',
      'enlem': 41.0267,
      'boylam': 29.0152,
    },
    {
      'id': 'kadikoy',
      'ad': 'Kadıköy Rıhtım',
      'ilce': 'Kadıköy',
      'aqi': 72,
      'kategori': 'Orta',
      'enlem': 40.9904,
      'boylam': 29.0255,
    },
    {
      'id': 'besiktas',
      'ad': 'Beşiktaş Meydan',
      'ilce': 'Beşiktaş',
      'aqi': 59,
      'kategori': 'İyi',
      'enlem': 41.0439,
      'boylam': 29.0053,
    },
  ],
};

class AqiMockSource {
  const AqiMockSource();

  Map<String, dynamic> get snapshotPayload => aqiPayload;
}
