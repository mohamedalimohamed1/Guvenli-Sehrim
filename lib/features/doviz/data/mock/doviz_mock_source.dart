const Map<String, dynamic> dovizPayload = {
  'sonGuncelleme': '17 Nisan 2026 09:08',
  'onecikanlar': ['USD', 'EUR', 'GA'],
  'kurlar': [
    {
      'kod': 'USD',
      'ad': 'ABD Doları',
      'alis': 39.1472,
      'satis': 39.1826,
      'degisim': 0.42,
      'favori': true,
    },
    {
      'kod': 'EUR',
      'ad': 'Euro',
      'alis': 44.2210,
      'satis': 44.3056,
      'degisim': 0.36,
      'favori': true,
    },
    {
      'kod': 'GA',
      'ad': 'Gram Altın',
      'alis': 4176.45,
      'satis': 4182.10,
      'degisim': 0.91,
      'favori': true,
    },
    {
      'kod': 'GBP',
      'ad': 'İngiliz Sterlini',
      'alis': 51.4035,
      'satis': 51.6201,
      'degisim': -0.18,
      'favori': false,
    },
    {
      'kod': 'CHF',
      'ad': 'İsviçre Frangı',
      'alis': 46.1142,
      'satis': 46.2897,
      'degisim': 0.11,
      'favori': false,
    },
  ],
  'trend': [
    {'etiket': 'Pzt', 'deger': 38.71},
    {'etiket': 'Sal', 'deger': 38.88},
    {'etiket': 'Çar', 'deger': 39.02},
    {'etiket': 'Per', 'deger': 39.10},
    {'etiket': 'Cum', 'deger': 39.18},
  ],
};

class DovizMockSource {
  const DovizMockSource();

  Map<String, dynamic> get snapshotPayload => dovizPayload;
}
