import 'package:advanced_app/data/network/error_handler.dart';

import '../response/responses.dart';

const cachedHomeKey = 'CACHED_HOME_KEY';
const cachedStoreDetailsKey = 'CACHED_STORE_DETAILS_KEY';
const cachedHomeInterval = 60 * 1000; // 1 minute cache in millisec
const cachedStoreDetailsInterval = 60 * 1000; // 1 minute cache in millisec

abstract class LocalDataSource {
  //home
  Future<HomeResponse> getHomeData();
  Future<void> saveHomeDataToCache(HomeResponse homeResponse);
  void clearCache();
  void removeFromcache(String key);

  // store details
  Future<StoreDetailsResponse> getStoreDetails();
  Future<void> saveStoreDataToCache(StoreDetailsResponse storeDetailsResponse);
}

class LocalDataSourceImpl implements LocalDataSource {
//rum time cashe

  Map<String, CachedItem> cashedMap = Map();

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem = cashedMap[cachedHomeKey];

    if (cachedItem != null && cachedItem.isValid(cachedHomeInterval)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeDataToCache(HomeResponse homeResponse) async {
    cashedMap[cachedHomeKey] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cashedMap.clear();
  }

  @override
  void removeFromcache(String key) {
    cashedMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async {
    CachedItem? cachedItem = cashedMap[cachedStoreDetailsKey];
    if (cachedItem != null && cachedItem.isValid(cachedStoreDetailsInterval)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or it is not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreDataToCache(
      StoreDetailsResponse storeDetailsResponse) async {
    cashedMap[cachedStoreDetailsKey] = CachedItem(storeDetailsResponse);
  }
}

class CachedItem {
  dynamic data;
  int casheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMilliSec) {
    int currentTimeInMilliSec = DateTime.now().millisecondsSinceEpoch;
    bool isValid =
        currentTimeInMilliSec - casheTime <= expirationTimeInMilliSec;
    return isValid;
  }
}
