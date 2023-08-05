# flutter-getx-clean-architecture
A Flutter Clean Architecture Using [GetX](https://github.com/jonataslaw/getx).

## Work Flow
![alt text](/assets/images/Clean-Architecture-Flutter-Diagram.png?raw=true)
## Project Structure
```
|-- lib
    |-- main.dart
    |-- app
        |-- core
            |-- usecases
        |-- config
            |-- app_constants.dart
            |-- app_colors.dart
        |   -- app_text_styles.dart
        |-- services
        |-- util
        |-- types
        |-- extensitons
    |-- data
        |-- models
        |-- repositories
        |-- providers
            |-- database
            |-- network
                |-- apis
                |-- api_endpoints.dart
                |-- api_provider.dart
                |-- api_representable.dart
    |-- domain
        |-- entities
        |-- repositories
        |-- usecases
    |-- presentation
        |-- controllers
        |-- pages
        |-- views
        |-- app.dart
```

## Features
- Integrating Unit Test.
- Create an easy to use API provider with [GetConnect](https://github.com/jonataslaw/getx#getconnect).

## 파이어 베이스 설정
1. firebase 추가 : (https://firebase.google.com/docs/flutter/setup?platform=android)
    1. firebase login
    2. dart pub global activate flutterfire_cli
    3. flutter pub add firebase_core firebase_auth cloud_firestore firebase_storage firebase_crashlytics firebase_remote_config
       1. flutterfire configure
          await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
          );
       2. // Pass all uncaught errors from the framework to Crashlytics.
         if (!kIsWeb) {
           FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
         }

2. 기본 라이브러리 추가
    1. flutter pub add 
       1. get loggy pref easy_localization cached_network_image package_info_plus 
       2. provider google_sign_in easy_sidemenu flutter_svg bottom_navy_bar
    2. flutter pub -dev add build_runner json_serializable

3. UI / Data 구성

## 푸시 수신 설정(native code 적용필요하여 - 라이브러리 사이트 참조)
1. firebase_messaging + flutter_local_notifications 코드 추가
   1. flutter pub add firebase_messaging flutter_local_notifications
   2. https://firebase.google.com/docs/cloud-messaging/flutter/client?hl=ko
   3. flutter pub add google_api_availability
   4. https://pub.dev/packages/flutter_local_notifications

## build & run
- get dependency
- flutter pub get
- flutter pub run build_runner build --delete-conflicting-outputs
- flutter run
- flutter build apk
- flutter build appbundle --release
## ipa
- flutter build ipa --export-options-plist=ios/exportOptions.plist

## web render image
- flutter build web --web-renderer html
- flutter run -d chrome --web-renderer html
- flutter run -d chrome --web-browser-flag "--disable-web-security"


## package name change
dev_dependencies:
    change_app_package_name: ^1.1.0
- flutter pub run change_app_package_name:main com.returncode.fitness

## 카카오 안드로이드 해시키 등록하기 -> 업데이트가 안되고 있어서 사용 불가
keytool -exportcert -alias upload -keystore /Users/yongjun.choi/upload-keystore.jks -storepass upload0806 -keypass upload0806 | openssl sha1 -binary | openssl base64
## keytool -list -v -keystore /Users/yongjun.choi/upload-keystore.jks -alias upload

## ios Simluator
xcrun simctl list
open -a Simulator --args -CurrentDeviceUDID 2C041A2E-E4B0-458C-802D-C64612585529

## bulid ipa
flutter build ipa --export-options-plist=ios/exportOptions.plist

## splash 생성
flutter_native_splash: ^2.3.1
flutter pub run flutter_native_splash:create

## 런처 아이콘 생성
flutter_launcher_icons: ^0.13.1
flutter pub run flutter_launcher_icons


