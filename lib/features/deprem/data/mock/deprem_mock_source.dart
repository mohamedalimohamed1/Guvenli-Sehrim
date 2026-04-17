const Map<String, dynamic> depremFeedPayload = {
  'olusturmaZamani': '2026-04-17T08:50:00+03:00',
  'ozet': {
    'son24SaatAdet': 18,
    'enBuyukMagnitud': 4.1,
    'enYakinSehir': 'İstanbul',
    'ortalamaDerinlikKm': 8.6,
  },
  'filtreler': [
    {'kod': 'all', 'etiket': 'Tümü'},
    {'kod': 'critical', 'etiket': '3.5+ Depremler'},
    {'kod': 'nearby', 'etiket': 'Yakınımda'},
    {'kod': 'felt', 'etiket': 'Hissedilenler'},
  ],
  'depremler': [
    {
      'id': 'eq-20260417-001',
      'yer': 'Silivri Açıkları',
      'sehir': 'İstanbul',
      'buyukluk': 3.2,
      'derinlikKm': 7.1,
      'zaman': '2026-04-17T07:18:00+03:00',
      'enlem': 40.8042,
      'boylam': 28.2511,
      'uyariSeviyesi': 'low',
      'hissedildi': true,
    },
    {
      'id': 'eq-20260417-002',
      'yer': 'Gemlik Körfezi',
      'sehir': 'Bursa',
      'buyukluk': 4.1,
      'derinlikKm': 10.8,
      'zaman': '2026-04-17T04:42:00+03:00',
      'enlem': 40.4217,
      'boylam': 29.1699,
      'uyariSeviyesi': 'medium',
      'hissedildi': true,
    },
    {
      'id': 'eq-20260416-019',
      'yer': 'Marmara Ereğlisi',
      'sehir': 'Tekirdağ',
      'buyukluk': 2.7,
      'derinlikKm': 5.4,
      'zaman': '2026-04-16T22:13:00+03:00',
      'enlem': 40.9651,
      'boylam': 27.9748,
      'uyariSeviyesi': 'low',
      'hissedildi': false,
    },
  ],
};

const Map<String, dynamic> depremDetailPayload = {
  'id': 'eq-20260417-002',
  'enYakinIlce': 'Mudanya',
  'mesafeKm': 17.4,
  'riskNotu': 'Kıyı kesimlerinde kısa süreli hissedildi, yapısal hasar bildirimi yok.',
  'artciGecmisi': [1.6, 1.9, 2.1, 1.4, 2.3],
};

class DepremMockSource {
  const DepremMockSource();

  Map<String, dynamic> get feedPayload => depremFeedPayload;
  Map<String, dynamic> get detailPayload => depremDetailPayload;
}
