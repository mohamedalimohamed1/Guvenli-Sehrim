const Map<String, dynamic> ayarlarPayload = {
  'tema': 'system',
  'bildirimler': {
    'aktif': true,
    'depremEsik': 3.5,
    'aqiEsik': 110,
  },
  'veri': {
    'yenilemeDakika': 15,
    'cacheMb': 28.4,
    'secenekler': [5, 15, 30, 60],
  },
};

class AyarlarMockSource {
  const AyarlarMockSource();

  Map<String, dynamic> get snapshotPayload => ayarlarPayload;
}
