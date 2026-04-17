const Map<String, dynamic> havaPayload = {
  'sehir': 'İstanbul',
  'ilce': 'Üsküdar',
  'arkaPlan': 'cloudy-day',
  'anlik': {
    'sicaklik': 18,
    'hissedilen': 16,
    'nem': 71,
    'ruzgarMs': 4.8,
    'basinc': 1014,
    'aciklama': 'Çok bulutlu',
    'ikon': 'cloudy',
  },
  'saatlik': [
    {'saat': '10:00', 'sicaklik': 18, 'yagis': 20, 'ikon': 'cloudy'},
    {'saat': '13:00', 'sicaklik': 19, 'yagis': 15, 'ikon': 'partly_cloudy'},
    {'saat': '16:00', 'sicaklik': 17, 'yagis': 42, 'ikon': 'rain'},
    {'saat': '19:00', 'sicaklik': 15, 'yagis': 61, 'ikon': 'rain'},
    {'saat': '22:00', 'sicaklik': 13, 'yagis': 18, 'ikon': 'night_cloud'},
  ],
  'besGunluk': [
    {'gun': 'Cuma', 'min': 12, 'max': 19, 'aciklama': 'Bulutlu', 'ikon': 'cloudy'},
    {'gun': 'Cumartesi', 'min': 11, 'max': 17, 'aciklama': 'Sağanak', 'ikon': 'rain'},
    {'gun': 'Pazar', 'min': 10, 'max': 18, 'aciklama': 'Parçalı bulutlu', 'ikon': 'partly_cloudy'},
    {'gun': 'Pazartesi', 'min': 9, 'max': 20, 'aciklama': 'Açık', 'ikon': 'sunny'},
    {'gun': 'Salı', 'min': 11, 'max': 21, 'aciklama': 'Açık', 'ikon': 'sunny'},
  ],
  'oneriler': [
    {'sehir': 'İstanbul', 'ilce': 'Üsküdar', 'gps': true},
    {'sehir': 'Ankara', 'ilce': 'Çankaya', 'gps': false},
    {'sehir': 'İzmir', 'ilce': 'Konak', 'gps': false},
  ],
};

class HavaMockSource {
  const HavaMockSource();

  Map<String, dynamic> get snapshotPayload => havaPayload;
}
