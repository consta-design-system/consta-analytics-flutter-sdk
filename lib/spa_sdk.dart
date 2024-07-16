
import 'dart:async';
import 'dart:io';

import 'package:client_information/client_information.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';
import 'event_manager.dart';
import 'model/event_spa.dart';
import 'network_request.dart';


///need singleton
class ConstaAnalytics {
  
  /// Singleton instance of the SpaSdk

  static ConstaAnalytics? _instance;

  /// Singleton init of the SpaSdk
  /// [counterId] is the counter id which is required to send the event
  /// [uriServiceSpa] is the uri of the server where the event will be sent

  static ConstaAnalytics init({required String counterId, required String uriServiceSpa,}) => _instance = ConstaAnalytics._(counterId: counterId, uriServiceSpa: uriServiceSpa);

  /// Version of the sdk
  
  static const String _version = "0.0.1";

  /// Singleton instance of the SpaSdk

  static ConstaAnalytics get instance => _instance ?? ConstaAnalytics._(counterId: "", uriServiceSpa: "");

  /// Location instance

  static Location location = Location();

  /// Counter id

  final String counterId;

  /// Uri of the spa server

  final String uriServiceSpa;

  /// id auth user
  
  static String? _userId;

  /// id session

  static final String _sessionId = const Uuid().v4();

  /// ip address

  static String _ip = "0.0.0.0";

  /// Network request

  static final NetworkRequest _networkRequest = NetworkRequest();

  /// Event save and send

  static final EventManager _eventManager = EventManager();

  /// Client information

  static late ClientInformation _clientInfo;

  /// Window instance for the flutter

  static final SingletonFlutterWindow _window = WidgetsBinding.instance.window;

  ConstaAnalytics._({
    required this.uriServiceSpa,
    required this.counterId,
  }){
    _initIpAddress();
    _initClientInfo();
  }

  Future<void> _initClientInfo() async {
    _clientInfo = await ClientInformation.fetch();
  }

  Future<void> _initIpAddress() async {
    try {
      var value = await _networkRequest.getIpAddress();
      _ip = value['ip'] ?? 'none';
    } catch (_) {
      _ip = 'none';
    }
  }

  /// Set the user id
  /// and add this id to all events

  void auth(String userId) {
    _userId = userId;
  }


  /// Save and send the event to the server
  /// or Send to Delete this event in hive bd
  /// [event] is the event which need to send
  /// add the default data to the event

  Future<void> sendEvent(ConstaAnalyticsEvent event) async {
    return _eventManager.saveEvent(
      (await  _defaultDataEvent()).copyWith(event),
    );
  }

  /// Default data for the event

  Future<ConstaAnalyticsEvent> _defaultDataEvent() async {
    LocationData? locationData = await getLocation();
    return Future.value(
      ConstaAnalyticsEvent(
        latitude: locationData?.latitude?.toString(),
        longitude: locationData?.longitude?.toString(),
        libraryVersion: _version,
        ipAddress: _ip,
        userId: _userId,
        sessionId: _sessionId,
        counterId: counterId,
        appVersion: _clientInfo.applicationVersion,
        deviceId: _clientInfo.deviceId,
        appName: _clientInfo.applicationName,
        deviceName: _clientInfo.deviceName,
        osVersion: _clientInfo.osVersion,
        osName: _clientInfo.osName,
        platform: _getCurrentPlatform(),
        language: _window.locale.languageCode,
        resolutionWidth: _window.physicalSize.width.toString(),
        resolutionHeight: _window.physicalSize.height.toString(),
        eventType: null,
        id: const Uuid().v4(),
        uriSand: uriServiceSpa,
      ),
    );
  }

  /// Get the current platform
  
  String _getCurrentPlatform() {
    if (kIsWeb) return "web";

    return Platform.operatingSystem;
  }

  /// Get the location data

  Future<LocationData?> getLocation() async {

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) return Future.value();

    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) return Future.value();

    try{
      return await location.getLocation().timeout(const Duration(milliseconds: 500));
    }catch(a){
      return null;
    }
  }

  /// Activate the location
  /// if the location is not enabled
  /// or the permission is not granted
  /// ask the user to enable the location
  /// and grant the permission

  Future<dynamic> activateLocation() async {

    bool serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) return await location.requestService();

    PermissionStatus permission = await location.hasPermission();

    if (permission == PermissionStatus.denied) return await location.requestPermission();
  }
}
