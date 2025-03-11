abstract class LocalCacheService {
  Future<bool> saveData<T>(String key, T data);
  Future<T?> restoreData<T>(String key);
  Future<bool> removeData(String key);
  Future<bool> clearData();
}
