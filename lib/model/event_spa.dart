import 'dart:convert';

import 'package:hive/hive.dart';

part 'event_spa.g.dart';

@HiveType(typeId: 0)
class ConstaAnalyticsEvent {
  /// The latitude and longitude of the user's location
  /// Need permission location
  @HiveField(0)
  final String? latitude;

  /// The latitude and longitude of the user's location
  /// Need permission location
  @HiveField(1)
  final String? longitude;

  /// The version of the library
  @HiveField(2)
  final String? libraryVersion;

  /// The IP address of the user
  /// Use the [NetworkRequest.getIpAddress] to get the IP address
  /// Use service [https://api64.ipify.org]
  /// Need permission internet
  @HiveField(3)
  final String? ipAddress;

  /// The screen of the app
  /// The screen is the current screen that the user is on
  /// Example: /home, /profile/settings
  @HiveField(4)
  final String? appScreen;

  /// The version of the app
  @HiveField(5)
  final String? appVersion;

  /// Unique user id is auth service
  @HiveField(6)
  final String? userId;

  /// The session id created when the app is opened and destroyed when the app is closed
  @HiveField(7)
  final String? sessionId;

  /// Unique counter id, counter get from the SPA service
  @HiveField(8)
  final String? counterId;

  /// The type of the event
  /// Example: app_exception, link_opened
  @HiveField(9)
  final String? eventType;

  /// The device id
  @HiveField(10)
  final String? deviceId;

  /// The name of the app
  @HiveField(11)
  final String? appName;

  /// The name of the device
  @HiveField(12)
  final String? deviceName;

  /// The version of the OS
  @HiveField(13)
  final String? osVersion;

  /// The name of the OS
  @HiveField(14)
  final String? osName;

  /// The platform of the device
  @HiveField(15)
  final String? platform;

  /// The language code of the device
  @HiveField(16)
  final String? language;

  /// The width of the screen
  @HiveField(17)
  final String? resolutionWidth;

  /// The height of the screen
  @HiveField(18)
  final String? resolutionHeight;

  /// The custom parameter of the event
  @HiveField(19)
  final Map<String, dynamic>? customParam;

  @HiveField(21)
  final String? id;

  @HiveField(22)
  final String? uriSand;

  const ConstaAnalyticsEvent({
    this.latitude,
    this.longitude,
    this.libraryVersion,
    this.ipAddress,
    this.userId,
    this.sessionId,
    this.counterId,
    this.appScreen,
    this.appVersion,
    required this.eventType,
    this.deviceId,
    this.appName,
    this.deviceName,
    this.osVersion,
    this.osName,
    this.platform,
    this.language,
    this.resolutionWidth,
    this.resolutionHeight,
    this.customParam,
    this.id,
    this.uriSand,
  });

  /// Convert this EventSpa to a json string

  String get toJsonString => jsonEncode(toMap());

  /// Convert this EventSpa to a json object

  dynamic get toJson => jsonDecode(toJsonString);

  /// Convert the json string to EventSpa

  factory ConstaAnalyticsEvent.fromJson(String source) => ConstaAnalyticsEvent._fromMap(json.decode(source));

  /// Use this constructor is app fatal error and crash app
  /// [fatal] is the error message
  /// [engagementTimeMSec] is the time in milliseconds, the user was engaged with the app

  ConstaAnalyticsEvent.appException({
    required String fatal,
    required String engagementTimeMSec,
  }) : this(eventType: "app_exception", customParam: {
          'fatal': fatal,
          'engagement_time_msec': engagementTimeMSec,
        });

  /// Use this constructor is end user update the app
  /// [previousAppVersion] is the previous version of the app

  ConstaAnalyticsEvent.appUpdate({
    required String previousAppVersion,
  }) : this(eventType: "app_update", customParam: {
          'previous_app_version': previousAppVersion,
        });

  /// Use this constructor is user click and open the link
  /// [linkUri] is the link that was opened

  ConstaAnalyticsEvent.linkOpened({
    required String linkUri,
  }) : this(eventType: "link_opened", customParam: {
          'link_uri': linkUri,
        });

  /// Use this constructor is app error
  /// [error] is the error message
  /// [errorValue] is the error value

  ConstaAnalyticsEvent.error({
    required String error,
    required String errorValue,
  }) : this(eventType: "error", customParam: {
          'error': error,
          'error_value': errorValue,
        });

  /// Use this constructor is user click link and open the file
  /// Open file is current regular: pdf|xlsx?|docx?|txt|rtf|csv|exe|key|pp(s|t|tx)|7z|pkg|rar|gz|zip|avi|mov|mp4|mpe?g|wmv|midi?|mp3|wav|wma
  /// [linkUri] is the link that was opened
  /// [linkId] is the link id
  /// [linkText] is the link text
  /// [linkDomain] is the link domain
  /// [linkClassed] is the link classed
  /// [fileName] is the file name
  /// [fileExtension] is the file extension

  ConstaAnalyticsEvent.fileOpenedInLink({
    required String linkUri,
    required String linkId,
    required String linkText,
    required String linkDomain,
    required String linkClassed,
    required String fileName,
    required String fileExtension,
  }) : this(
          eventType: "file_opened",
          customParam: {
            'link_uri': linkUri,
            'link_id': linkId,
            'link_text': linkText,
            'link_domain': linkDomain,
            'link_classed': linkClassed,
            'file_name': fileName,
            'file_extension': fileExtension,
          },
        );

  /// Use this constructor is user first open the app
  /// [previousGmpAppId] is the previous gmp app id
  /// [updatedWithAnalytics] is the updated with analytics
  /// [previousFirstOpenCount] is the previous first open count
  /// [systemApp] is the system app
  /// [systemAppUpdate] is the system app update
  /// [deferredAnalyticsCollection] is the deferred analytics collection
  /// [resetAnalyticsCause] is the reset analytics cause
  /// [engagementTimeMsec] is the time in milliseconds, the user was engaged with the app

  ConstaAnalyticsEvent.firstOpen({
    required String previousGmpAppId,
    required String updatedWithAnalytics,
    required String previousFirstOpenCount,
    required String systemApp,
    required String systemAppUpdate,
    required String deferredAnalyticsCollection,
    required String resetAnalyticsCause,
    required String engagementTimeMSec,
  }) : this(eventType: "first_open", customParam: {
          'previous_gmp_app_id': previousGmpAppId,
          'updated_with_analytics': updatedWithAnalytics,
          'previous_first_open_count': previousFirstOpenCount,
          'system_app': systemApp,
          'system_app_update': systemAppUpdate,
          'deferred_analytics_collection': deferredAnalyticsCollection,
          'reset_analytics_cause': resetAnalyticsCause,
          'engagement_time_msec': engagementTimeMSec,
        });

  /// Use this constructor is user open screen
  /// [pageLocation] is new screen uri
  /// [pageReferrer] is old screen uri

  ConstaAnalyticsEvent.screenView({
    required String pageLocation,
    required String pageReferrer,
  }) : this(
          eventType: "screen_view",
          customParam: {
            'page_location': pageLocation,
            'page_referrer': pageReferrer,
          },
        );

  /// Use this constructor is user scroll
  /// [engagementTimeMSec] is the time in milliseconds, the user was engaged with the app
  /// user first time reach the bottom of the screen

  ConstaAnalyticsEvent.scroll(
    String engagementTimeMSec,
  ) : this(eventType: "scroll", customParam: {
          'engagement_time_msec': engagementTimeMSec,
        });

  /// Use this constructor is open the app

  const ConstaAnalyticsEvent.appSessionStart()
      : this(
          eventType: "session_start",
        );

  /// Use this constructor is destroy the app

  const ConstaAnalyticsEvent.appSessionEnd()
      : this(
          eventType: "session_end",
        );

  /// Use this constructor is user search
  /// [value] is the search value

  ConstaAnalyticsEvent.search({required String value})
      : this(eventType: "search", customParam: {
          'search_request': value,
        });

  /// Use this constructor need create custom event
  /// [eventType] is the event type
  /// [customParam] is the custom parameter

  ConstaAnalyticsEvent.custom({
    required String eventType,
    required Map<String, dynamic> customParam,
  }) : this(
          eventType: eventType,
          customParam: customParam,
        );

  Map<String, dynamic> toMap() {
    final date = DateTime.now();
    return {
      'apiVersion': "1.0",
      'counterId': counterId ?? '',
      'timestamp': date.toUtc().millisecondsSinceEpoch ~/ 1000,
      'channelType': "CustomScript",
      'user_id': userId.toString(),
      'channelName': "RegEvents API",
      'eventCaption': eventType ?? '',
      'customparams': [
        if (latitude != null)
          {
            'name': 'latitude',
            'type': 'STRING',
            'value': latitude,
          },
        if (longitude != null)
          {
            'name': 'latitude',
            'type': 'STRING',
            'value': longitude,
          },
        if (osName != null)
          {
            'name': 'osName',
            'type': 'STRING',
            'value': osName,
          },
        if (deviceName != null)
          {
            'name': 'deviceName',
            'type': 'STRING',
            'value': deviceName,
          },
        if (libraryVersion != null)
          {
            'name': 'libraryVersion',
            'type': 'STRING',
            'value': libraryVersion,
          },
        if (ipAddress != null)
          {
            'name': 'ipAddress',
            'type': 'STRING',
            'value': ipAddress,
          },
        if (deviceId != null)
          {
            'name': 'deviceId',
            'type': 'STRING',
            'value': deviceId,
          },
        if (userId != null)
          {
            'name': 'userId',
            'type': 'STRING',
            'value': userId,
          },
        if (sessionId != null)
          {
            'name': 'sessionId',
            'type': 'STRING',
            'value': sessionId,
          },
        if (appScreen != null)
          {
            'name': 'appScreen',
            'type': 'STRING',
            'value': appScreen,
          },
        if (osVersion != null)
          {
            'name': 'osVersion',
            'type': 'STRING',
            'value': osVersion,
          },
        if (appVersion != null)
          {
            'name': 'appVersion',
            'type': 'STRING',
            'value': appVersion,
          },
        if (appName != null)
          {
            'name': 'appName',
            'type': 'STRING',
            'value': appName,
          },
        if (platform != null)
          {
            'name': 'platform',
            'type': 'STRING',
            'value': platform,
          },
        if (language != null)
          {
            'name': 'language',
            'type': 'STRING',
            'value': language,
          },
        if (resolutionWidth != null)
          {
            'name': 'resolutionWidth',
            'type': 'STRING',
            'value': resolutionWidth,
          },
        if (resolutionHeight != null)
          {
            'name': 'resolutionHeight',
            'type': 'STRING',
            'value': resolutionHeight,
          },
        ...?customParam?.keys.map((e) {
          if (customParam?[e] == null) return null;
          return {
            'name': e,
            'type': 'STRING',
            'value': customParam?[e],
          };
        }).nonNulls,
      ]
    };
  }

  factory ConstaAnalyticsEvent._fromMap(Map<String, dynamic> map) {
    return ConstaAnalyticsEvent(
      latitude: map['latitude'],
      longitude: map['longitude'],
      libraryVersion: map['library'],
      ipAddress: map['ip_address'],
      userId: map['user_id'],
      sessionId: map['session_id'],
      counterId: map['counter_id'],
      appScreen: map['app_screen'],
      appVersion: map['release_version'],
      eventType: map['eventCaption'],
      customParam: map['customparams'],
    );
  }

  /// CopyWith the current EventSpa with the new values
  /// [event] is the new values
  /// Return the new EventSpa
  /// If the value is null, the old value will be used
  /// If the value is not null, the new value will be used

  ConstaAnalyticsEvent copyWith(ConstaAnalyticsEvent event) {
    return ConstaAnalyticsEvent(
      latitude: event.latitude ?? latitude,
      longitude: event.longitude ?? longitude,
      libraryVersion: event.libraryVersion ?? libraryVersion,
      ipAddress: event.ipAddress ?? ipAddress,
      userId: event.userId ?? userId,
      sessionId: event.sessionId ?? sessionId,
      counterId: event.counterId ?? counterId,
      appScreen: event.appScreen ?? appScreen,
      appVersion: event.appVersion ?? appVersion,
      eventType: event.eventType ?? eventType,
      deviceId: event.deviceId ?? deviceId,
      appName: event.appName ?? appName,
      deviceName: event.deviceName ?? deviceName,
      osVersion: event.osVersion ?? osVersion,
      osName: event.osName ?? osName,
      platform: event.platform ?? platform,
      language: event.language ?? language,
      resolutionWidth: event.resolutionWidth ?? resolutionWidth,
      resolutionHeight: event.resolutionHeight ?? resolutionHeight,
      customParam: event.customParam,
      id: event.id ?? id,
      uriSand: event.uriSand ?? uriSand,
    );
  }
}
