import 'model/event_spa.dart';

/// The network handler which will handle all the data related work.
abstract class NetworkHandler {

  /// Get IpAddress in map format.
  Future<Map<String, dynamic>> getIpAddress();

  /// Send spa massage to server.
  Future<Map<String, dynamic>> postSpaMessage(EventSpa event);
}
