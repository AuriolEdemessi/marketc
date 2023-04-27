
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final HiveService hive = HiveService.instance;

class HiveService {

  //region INITIALIZE

  static const String boxToken = 'boxToken';
  static const String keyToken = 'keyToken';

  static const String boxOsUserID = 'boxOsUserID';
  static const String keyOsUserID = 'keyOsUserID';

  static const String boxIsFirst = 'boxIsFirst';
  static const String keyIsFirst = 'keyIsFirst';

  static final HiveService _instance = HiveService();

  static HiveService get instance => _instance;

  Future<void> init() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocDirectory.path);
  }

  //endregion


  //region SAVE

  saveToken(String token) async {
    final Box box = await Hive.openBox(boxToken);
    await box.put(keyToken, token);
    box.close();
  }

  saveIsFirst(bool value) async {
    final Box box = await Hive.openBox(boxIsFirst);
    await box.put(keyIsFirst, value);
    box.close();
  }

  saveOsUserID(String? value) async {
    final Box box = await Hive.openBox(boxOsUserID);
    await box.put(keyOsUserID, value);
    await box.close();
  }

  //endregion


  //region GETTER

  Future<String?> getToken() async {
    final Box box = await Hive.openBox(boxToken);
    String? token = await box.get(keyToken);
    box.close();
    return token;
  }

  Future<String?> getOsUserID() async {
    final Box box = await Hive.openBox(boxOsUserID);
    String? osUserID = await box.get(keyOsUserID);
    box.close();
    return osUserID;
  }

  Future<bool> getIsFirst() async {
    final Box box = await Hive.openBox(boxIsFirst);
    bool? isFirst = await box.get(keyIsFirst);
    box.close();
    return isFirst??false;
  }

  //endregion


  //region DELETE

  deleteToken() async {
    final Box box = await Hive.openBox(boxToken);
    await box.delete(keyToken);
    box.close();
  }

  //endregion

}
