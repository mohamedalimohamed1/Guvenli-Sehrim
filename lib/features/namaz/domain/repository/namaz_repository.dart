import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/namaz/domain/model/prayer_models.dart';

abstract class NamazRepository {
  Future<Result<RepositoryData<PrayerTimesSnapshot>>> getPrayerTimes();
}
