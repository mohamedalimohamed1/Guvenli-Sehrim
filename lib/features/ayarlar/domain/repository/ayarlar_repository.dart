import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/ayarlar/domain/model/settings_models.dart';

abstract class AyarlarRepository {
  Future<Result<RepositoryData<SettingsSnapshot>>> getSettings();
}
