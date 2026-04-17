import 'package:guvenli_sehrim/features/aqi/data/datasource/aqi_mock_data_source.dart';
import 'package:guvenli_sehrim/features/aqi/data/repository/aqi_repository_impl.dart';
import 'package:guvenli_sehrim/features/aqi/presentation/provider/aqi_provider.dart';
import 'package:guvenli_sehrim/features/ayarlar/data/datasource/ayarlar_mock_data_source.dart';
import 'package:guvenli_sehrim/features/ayarlar/data/repository/ayarlar_repository_impl.dart';
import 'package:guvenli_sehrim/features/ayarlar/presentation/provider/ayarlar_provider.dart';
import 'package:guvenli_sehrim/features/dashboard/data/datasource/dashboard_mock_data_source.dart';
import 'package:guvenli_sehrim/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:guvenli_sehrim/features/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:guvenli_sehrim/features/deprem/data/datasource/deprem_mock_data_source.dart';
import 'package:guvenli_sehrim/features/deprem/data/repository/deprem_repository_impl.dart';
import 'package:guvenli_sehrim/features/deprem/presentation/provider/deprem_provider.dart';
import 'package:guvenli_sehrim/features/doviz/data/datasource/doviz_mock_data_source.dart';
import 'package:guvenli_sehrim/features/doviz/data/repository/doviz_repository_impl.dart';
import 'package:guvenli_sehrim/features/doviz/presentation/provider/doviz_provider.dart';
import 'package:guvenli_sehrim/features/hava/data/datasource/hava_mock_data_source.dart';
import 'package:guvenli_sehrim/features/hava/data/repository/hava_repository_impl.dart';
import 'package:guvenli_sehrim/features/hava/presentation/provider/hava_provider.dart';
import 'package:guvenli_sehrim/features/namaz/data/datasource/namaz_mock_data_source.dart';
import 'package:guvenli_sehrim/features/namaz/data/repository/namaz_repository_impl.dart';
import 'package:guvenli_sehrim/features/namaz/presentation/provider/namaz_provider.dart';

class AppDependencies {
  AppDependencies._({
    required this.dashboardProvider,
    required this.depremProvider,
    required this.havaProvider,
    required this.aqiProvider,
    required this.namazProvider,
    required this.dovizProvider,
    required this.ayarlarProvider,
  });

  factory AppDependencies.mock() {
    return AppDependencies._(
      dashboardProvider: DashboardProvider(
        DashboardRepositoryImpl(
          mockDataSource: DashboardMockDataSource(),
        ),
      ),
      depremProvider: DepremProvider(
        DepremRepositoryImpl(
          mockDataSource: EarthquakeMockDataSource(),
        ),
      ),
      havaProvider: HavaProvider(
        HavaRepositoryImpl(
          mockDataSource: WeatherMockDataSource(),
        ),
      ),
      aqiProvider: AqiProvider(
        AqiRepositoryImpl(
          mockDataSource: AirQualityMockDataSource(),
        ),
      ),
      namazProvider: NamazProvider(
        NamazRepositoryImpl(
          mockDataSource: PrayerMockDataSource(),
        ),
      ),
      dovizProvider: DovizProvider(
        DovizRepositoryImpl(
          mockDataSource: MarketMockDataSource(),
        ),
      ),
      ayarlarProvider: AyarlarProvider(
        AyarlarRepositoryImpl(
          mockDataSource: SettingsMockDataSource(),
        ),
      ),
    );
  }

  final DashboardProvider dashboardProvider;
  final DepremProvider depremProvider;
  final HavaProvider havaProvider;
  final AqiProvider aqiProvider;
  final NamazProvider namazProvider;
  final DovizProvider dovizProvider;
  final AyarlarProvider ayarlarProvider;

  void dispose() {
    dashboardProvider.dispose();
    depremProvider.dispose();
    havaProvider.dispose();
    aqiProvider.dispose();
    namazProvider.dispose();
    dovizProvider.dispose();
    ayarlarProvider.dispose();
  }
}
