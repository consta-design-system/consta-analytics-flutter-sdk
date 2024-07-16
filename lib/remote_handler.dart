
import 'package:dio/dio.dart';
import 'model/event_spa.dart';
import 'network_handler.dart';

/// A device handler which will handle all the remote related work like
/// saving or getting the data.
class RemoteHandler extends NetworkHandler {
  final Dio _dio = Dio();

  @override
  Future<Map<String, dynamic>> getIpAddress() async {
    try {
      Response<dynamic> response = await _dio.get(
        "https://api64.ipify.org",
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Not able to find the Ip Address.');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Not able to find the Ip Address.');
    }
  }


  @override
  Future<Map<String, dynamic>> postSpaMessage(EventSpa event) async {
    if(event.uriSand == null) throw Exception('Error uriSand not null.');
    try {
      print(event.toJson);
      Response<dynamic> response = await _dio.post(
        event.uriSand!,
        data: [event.toJson],
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Error while sending the message.');
      }
    } catch (_) {
      throw Exception('Error while sending the message.');
    }
  }
}
