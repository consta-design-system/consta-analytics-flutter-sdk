import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:consta_analytics/model/event_spa.dart';
import 'package:hive/hive.dart';

import 'network_request.dart';

class EventManager {
  static const String boxName = 'unsentEvents';
  static final NetworkRequest _networkRequest = NetworkRequest();

  EventManager() {
    _initHive();
  }

  Future<void> _initHive() async {
    final appDocumentDir = Directory.systemTemp;
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(ConstaAnalyticsEventAdapter());
    await openBox();
    startMonitoring();
  }

  Future<void> openBox() async {
    await Hive.openBox<ConstaAnalyticsEvent>(boxName);
  }

  Future<void> saveEvent(ConstaAnalyticsEvent event) async {
    final box = Hive.box<ConstaAnalyticsEvent>(boxName);
    await box.add(event);
    await sendEvents();
  }

  Future<List<ConstaAnalyticsEvent>> getEvents() async {
    final box = Hive.box<ConstaAnalyticsEvent>(boxName);
    return box.values.toList();
  }

  Future<void> sendEvents() async {
    final box = Hive.box<ConstaAnalyticsEvent>(boxName);
    final events = box.keys.toList();
    if (events.isEmpty) return;

    for (var key in events) {
      final ConstaAnalyticsEvent? event = box.get(key);
      try {
        if (event?.uriSand == null) {
          await box.delete(key);
          continue;
        }
        await _networkRequest.postSpaMessage(event!);
        await box.delete(key);
      } catch (e) {
        return;
      }
    }
  }

  void startMonitoring() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result.lastOrNull != ConnectivityResult.none) {
        sendEvents();
      }
    });
  }
}
