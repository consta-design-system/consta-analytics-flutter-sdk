# [Consta Analytics Flutter SDK](https://pub.dev/packages/consta_analytics)

Flutter SDK для интеграции системы продуктовой аналитики [Consta Analytics](https://analytics.consta.design).

Пакет используется для подключения Flutter-приложений к Consta Analytics. SDK  предоставляет возможность отправки пользовательских событий из приложения посредством интеграции c публичным API системы продуктовой аналитики.

## Как использовать

### Требования

Перед установкой необходимо интегрировать пакет в приложение с помощью команды

```dart
$ flutter pub add consta_analytics
```

### Импортируйте пакет

```dart
import 'package:consta_analytics/spa_sdk.dart';
```

### Инициализация пакета
##### Для инициализации пакета необходимо вызвать метод init() в main.dart

```dart
void main(){
    //...
    SpaSdk.init(counterId: {"Номер счетчика"}, uriServiceSpa: {"Url для отправки запроса "});
    //...
}
```

## Настройки для инициализации отправки геопозиции Android:
#### Добавьте в android/app/source/main/AndroidManifest.xml следующие разрешения:

```xml
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
```

## Настройки для инициализации отправки геопозиции iOS:
#### Добавьте в ios/Runner/Info.plist следующие разрешения:

```xml
     <key>NSLocationAlwaysUsageDescription</key>
     <string>Your location is required for xyz benefits for you</string>
     <key>NSLocationWhenInUseUsageDescription</key>
     <string>Your location is required for xyz benefits for you</string>
     <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
     <string>Your location is required for xyz benefits for you</string>
```

#### После добавления разрешений, вызовите метод [SpaSdk.activateLocation] для активации отправки геопозиции

## Авторизация пользователя и отправка идентификатора пользователя
#### Нужно вызвать метод [SpaSdk.auth] для добавления id пользователя ко всем событиям
    
```dart
   SpaSdk.auth(userId: "id пользователя");
```

### Отправка событий

#### Отправка событий возможна с помощью стандартных и кастомизируемых событий

```dart

SpaSdk.instance.sendEvent(const EventSpa.appSessionStart());
SpaSdk.instance.sendEvent(EventSpa.custom(eventType: "eventType", customParam: {
              "customParam1": "valueCustomParam1",
              "customParam2": "valueCustomParam2",
            }))
```


#### После инициализации SDK можно использовать методы для отправки событий на сервер СПА
#### Для отправки события на сервер используйте метод [SpaSdk.sendEvent]

    Есть несколько дефолтных конструкторов для создания событий:
    [EventSpa.appException] - для отправки исключений
    [EventSpa.appUpdate] - для отправки событий об обновлении приложения
    [EventSpa.linkOpened] - для отправки событий об открытии ссылки
    [EventSpa.error] - для отправки ошибок
    [EventSpa.fileOpenedInLink] - для отправки событий об открытии файла по ссылке
    [EventSpa.firstOpen] - для отправки событий первого открытия приложения
    [EventSpa.screenView] - для отправки событий просмотра экрана
    [EventSpa.scroll] - для отправки событий скролла
    [EventSpa.appSessionStart] - для отправки событий начала сессии
    [EventSpa.appSessionEnd] - для отправки событий окончания сессии
    [EventSpa.search] - для отправки событий поиска
    [EventSpa.custom] - для отправки кастомных событий
    
    Дефолтные данные которые мы собираем и отправляем вместе с событием:
    
    [EventSpa.ipAddress] - ip адрес
    [EventSpa.sessionId] - id сессии
    [EventSpa.libraryVersion] - версия библиотеки
    [EventSpa.counterId] - id счетчика
    [EventSpa.appVersion] - версия приложения
    [EventSpa.deviceId] - id устройства
    [EventSpa.appName] - название приложения
    [EventSpa.deviceName] - название устройства
    [EventSpa.osVersion] - версия операционной системы
    [EventSpa.osName] - название операционной системы
    [EventSpa.platform] - платформа
    [EventSpa.language] - язык
    [EventSpa.resolutionWidth] - ширина экрана
    [EventSpa.resolutionHeight] - высота экрана
    [EventSpa.id] - id события
    
    Поля которые требуют дополнителые действия:
    
    [EventSpa.latitude] - широта
    [EventSpa.longitude] - долгота
    [EventSpa.userId] - id пользователя

    В случае возникновения ошибок при отправке событий, они сохраняются в локальной базе данных
    и отправляются на сервер при следующей отправке событий
    
