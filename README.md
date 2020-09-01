# 克彥付錢

> Firebase Authentication with Google account, Firebase cloud storage as Database

## TODO

* Google login
  * email
  * avatar
  * name
* Order CRUD - cloudstore
  * Column
    * 付款人
    * 總金額
    * 成員 `[{name: "Bob", isPay: false, ...}]`
    * timestamp
    * memo
* Chat room - cloudstore - one group room only
* Push notification - OneSignal - member could push message to others
* Small interaction game
* Easter egg
  * maybe play with accelerometer


```dart

  // 登入
  static doSignIn(String residentId, String password) async {
    final response = await http.post("${Config.baseUrl}login",
        body: {"resident_id": residentId, "password": password});

    var result = _parseResponse(response);
    if (result["result"] == true) {
      _storeUserSessionId(result["session_id"]);
    }
    return result;
  }

  
  // 登出
  static doLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String sessionId = await pref.getString("sessionId");

    final response = await http.post("${Config.baseUrl}logout", body: {
      "session_id": sessionId,
    });

    await pref.remove("sessionId");
    return _parseResponse(response);
  }

```
