const Map<String, dynamic> dashboardOverviewPayload = {
  'konum': {
    'sehir': 'İstanbul',
    'ilce': 'Üsküdar',
  },
  'sonGuncelleme': '2026-04-17T09:12:00+03:00',
  'kartlar': [
    {
      'featureKey': 'deprem',
      'baslik': 'Deprem',
      'anaDeger': 'Son 24 saatte 18 kayıt',
      'ikincilDeger': 'En yakın: Silivri 3.2',
      'durum': 'Düşük risk',
    },
    {
      'featureKey': 'hava',
      'baslik': 'Hava',
      'anaDeger': '18° Çok bulutlu',
      'ikincilDeger': 'Hissedilen 16°',
      'durum': 'Şemsiye önerilir',
    },
    {
      'featureKey': 'aqi',
      'baslik': 'Hava Kalitesi',
      'anaDeger': 'AQI 61',
      'ikincilDeger': 'Üsküdar Sahil İstasyonu',
      'durum': 'Orta',
    },
    {
      'featureKey': 'namaz',
      'baslik': 'Namaz',
      'anaDeger': 'İkindi 16:42',
      'ikincilDeger': 'Kalan süre 01:18',
      'durum': 'Sıradaki vakit',
    },
    {
      'featureKey': 'doviz',
      'baslik': 'Döviz ve Altın',
      'anaDeger': 'USD 39,18',
      'ikincilDeger': 'Gram Altın 4.182',
      'durum': 'Piyasa açık',
    },
  ],
  'uyarilar': [
    {
      'id': 'alert-rain',
      'baslik': 'Akşam yağış bekleniyor',
      'mesaj': 'Saat 19:00 sonrası kısa süreli sağanak görülebilir.',
      'seviye': 'info',
    },
    {
      'id': 'alert-aqi',
      'baslik': 'Hassas gruplar dikkat',
      'mesaj': 'Öğle saatlerinde partikül seviyesi yükseliyor.',
      'seviye': 'warning',
    },
  ],
};

class DashboardMockSource {
  const DashboardMockSource();

  Map<String, dynamic> get overviewPayload => dashboardOverviewPayload;
}
