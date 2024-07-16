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

### Отправка событий

Отправка событий возможна с помощью стандартных и кастомизируемых событий

```dart

SpaSdk.instance.sendEvent(const EventSpa.appSessionStart());
SpaSdk.instance.sendEvent(EventSpa.custom(eventType: "eventType", customParam: {
              "customParam1": "valueCustomParam1",
              "customParam2": "valueCustomParam2",
            }))
```
