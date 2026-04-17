const Map<String, dynamic> namazPayload = {
  'sehir': 'İstanbul',
  'siradakiVakit': {'ad': 'İkindi', 'saat': '16:42', 'geriSayim': '01:18:00'},
  'bugun': [
    {'ad': 'İmsak', 'saat': '04:46', 'siradaki': false},
    {'ad': 'Güneş', 'saat': '06:17', 'siradaki': false},
    {'ad': 'Öğle', 'saat': '13:06', 'siradaki': false},
    {'ad': 'İkindi', 'saat': '16:42', 'siradaki': true},
    {'ad': 'Akşam', 'saat': '19:45', 'siradaki': false},
    {'ad': 'Yatsı', 'saat': '21:10', 'siradaki': false},
  ],
  'haftalik': [
    {
      'gun': 'Cuma',
      'vakitler': [
        {'ad': 'İmsak', 'saat': '04:46', 'siradaki': false},
        {'ad': 'Güneş', 'saat': '06:17', 'siradaki': false},
        {'ad': 'Öğle', 'saat': '13:06', 'siradaki': false},
        {'ad': 'İkindi', 'saat': '16:42', 'siradaki': true},
        {'ad': 'Akşam', 'saat': '19:45', 'siradaki': false},
        {'ad': 'Yatsı', 'saat': '21:10', 'siradaki': false},
      ],
    },
    {
      'gun': 'Cumartesi',
      'vakitler': [
        {'ad': 'İmsak', 'saat': '04:44', 'siradaki': false},
        {'ad': 'Güneş', 'saat': '06:15', 'siradaki': false},
        {'ad': 'Öğle', 'saat': '13:06', 'siradaki': false},
        {'ad': 'İkindi', 'saat': '16:43', 'siradaki': false},
        {'ad': 'Akşam', 'saat': '19:46', 'siradaki': false},
        {'ad': 'Yatsı', 'saat': '21:12', 'siradaki': false},
      ],
    },
    {
      'gun': 'Pazar',
      'vakitler': [
        {'ad': 'İmsak', 'saat': '04:42', 'siradaki': false},
        {'ad': 'Güneş', 'saat': '06:14', 'siradaki': false},
        {'ad': 'Öğle', 'saat': '13:05', 'siradaki': false},
        {'ad': 'İkindi', 'saat': '16:44', 'siradaki': false},
        {'ad': 'Akşam', 'saat': '19:47', 'siradaki': false},
        {'ad': 'Yatsı', 'saat': '21:13', 'siradaki': false},
      ],
    },
  ],
};

class NamazMockSource {
  const NamazMockSource();

  Map<String, dynamic> get snapshotPayload => namazPayload;
}
