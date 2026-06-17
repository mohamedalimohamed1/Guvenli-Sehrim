# Güvenli Şehrim Uygulaması

Güvenli Şehrim, Türkiye’de yaşayan kullanıcıların günlük yaşamda ihtiyaç duyduğu temel bilgileri tek bir mobil uygulama üzerinden sunmayı amaçlayan bir mobil uygulamadır.

---

## 🎯 Proje Amacı

Bu projenin amacı:

* Farklı veri kaynaklarını tek bir uygulamada birleştirmek
* Kullanıcıya hızlı, anlaşılır ve erişilebilir bilgi sunmak
* Temiz ve sürdürülebilir bir yazılım mimarisi geliştirmek
* Modern mobil uygulama geliştirme prensiplerini uygulamak

---

## 📱 Uygulama Özellikleri

### 🏠 Dashboard

* Deprem, hava, hava kalitesi, namaz ve döviz verilerinin özet gösterimi
* Kullanıcı konum bilgisi
* Yenileme işlemi

---

### 🌍 Deprem

* Deprem listesi
* Büyüklük, derinlik ve zaman bilgileri
* Filtreleme altyapısı
* Harita entegrasyonu için uygun yapı

---

### 🌦 Hava Durumu

* Anlık hava bilgisi
* Saatlik tahmin
* 5 günlük tahmin
* Şehir seçimi altyapısı

---

### 🌫 Hava Kalitesi (AQI)

* AQI değeri ve kategori bilgisi
* Sağlık önerileri
* Trend verisi için uygun yapı

---

### 🕌 Namaz Vakitleri

* Günlük namaz vakitleri
* Haftalık görünüm
* Yaklaşan vakit bilgisi

---

### 💱 Döviz ve Altın

* USD, EUR ve altın fiyatları
* Alış ve satış değerleri
* Değişim oranları

---

### ⚙️ Ayarlar

* Tema seçimi (Light / Dark / System)
* Bildirim eşikleri
* Yenileme sıklığı ayarları

---

## 🏗 Kullanılan Teknolojiler

### Mobil

* Flutter
* Provider / Riverpod
* Hive
* Dio

### Backend

* Node.js
* Express
* Axios
* node-cache
* node-cron

---

## 🧱 Mimari Yapı

Proje, feature-first ve katmanlı mimari yaklaşımı ile geliştirilmiştir.

Klasör yapısı:

```
mobile/lib/
  core/
  shared/
  features/
```

Her feature aşağıdaki katmanlara sahiptir:

```
data/
domain/
presentation/
```

Veri akışı:

```
DTO → Domain Model → Repository → Provider → UI
```

---

## 📂 Proje Yapısı

Uygulama aşağıdaki ana modüllerden oluşur:

* Dashboard
* Deprem
* Hava
* AQI
* Namaz
* Döviz
* Ayarlar

---

## 🚀 Kurulum

Flutter ortamının kurulu olduğundan emin olun:

```
flutter doctor
```

Bağımlılıkları yükleyin:

```
flutter pub get
```

Uygulamayı başlatın:

```
flutter run
```

---

## 🎯 Sonuç

Bu proje, modern mobil uygulama geliştirme prensiplerine uygun olarak yapılandırılmış, ölçeklenebilir ve sürdürülebilir bir sistem oluşturmayı hedeflemektedir.
