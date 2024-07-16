import 'package:consta_analytics/model/event_spa.dart';
import 'package:consta_analytics/spa_sdk.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late final TextEditingController textEditingControllerCounter;
  late final TextEditingController textEditingControllerUri;

  bool auth = false;

  @override
  void initState() {
    super.initState();

    textEditingControllerCounter = TextEditingController();
    textEditingControllerUri = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Builder(
            builder: (context) {
              if(!auth){
                return _auth();
              }
              return _test();
            }
          ),
        ),
      ),
    );
  }

  Widget _auth() {
    return Column(
      children: [
        TextField(
          controller: textEditingControllerCounter,
          decoration: const InputDecoration(
            hintText: "counterId",
          )
        ),
        TextField(
          controller: textEditingControllerUri,
          decoration: const InputDecoration(
            hintText: "uri",
          )
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              auth = true;
              SpaSdk.init(counterId: textEditingControllerCounter.text, uriServiceSpa: textEditingControllerUri.text);
            });
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: const Color.fromRGBO(46, 70, 96, 1),
          ),
          child: const Text(
            "auth",
          ),
        ),
      ],
    );
  }

  Widget _test() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            SpaSdk.instance.activateLocation();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: const Color.fromRGBO(46, 70, 96, 1),
          ),
          child: const Text(
            "location actiovete",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            SpaSdk.instance.sendEvent(EventSpa.error(error: "error", errorValue: "errorValue"));
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: const Color.fromRGBO(46, 123, 96, 1),
          ),
          child: const Text(
            "error",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            SpaSdk.instance.sendEvent(const EventSpa.appSessionStart());
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: const Color.fromRGBO(46, 123, 96, 1),
          ),
          child: const Text(
            "App Session Start",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            SpaSdk.instance.sendEvent(EventSpa.search(value: "value"));
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: const Color.fromRGBO(46, 123, 96, 1),
          ),
          child: const Text(
            "search",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            SpaSdk.instance.sendEvent(EventSpa.appException(fatal: 'fatal', engagementTimeMSec: 'engagementTimeMSec'));
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: const Color.fromRGBO(46, 123, 96, 1),
          ),
          child: const Text(
            "appException",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            SpaSdk.instance.sendEvent(const EventSpa.appSessionEnd());
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: const Color.fromRGBO(46, 123, 96, 1),
          ),
          child: const Text(
            "appSessionEnd",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            SpaSdk.instance.sendEvent(EventSpa.appUpdate(previousAppVersion: "previousAppVersion"));
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: const Color.fromRGBO(46, 123, 96, 1),
          ),
          child: const Text(
            "appUpdate",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            SpaSdk.instance.sendEvent(EventSpa.fileOpenedInLink(linkUri: 'linkUri', linkId: 'linkId', linkText: 'linkText', linkDomain: 'linkDomain', linkClassed: 'linkClassed', fileName: 'fileName', fileExtension: 'fileExtension'));
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: const Color.fromRGBO(46, 123, 96, 1),
          ),
          child: const Text(
            "fileOpenedInLink",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            SpaSdk.instance.sendEvent(EventSpa.firstOpen(previousGmpAppId: "previousGmpAppId", updatedWithAnalytics: "updatedWithAnalytics", previousFirstOpenCount: "previousFirstOpenCount", systemApp: "systemApp", systemAppUpdate: "systemAppUpdate", deferredAnalyticsCollection: "deferredAnalyticsCollection", resetAnalyticsCause: "resetAnalyticsCause", engagementTimeMSec: "engagementTimeMSec"));
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: const Color.fromRGBO(46, 123, 96, 1),
          ),
          child: const Text(
            "firstOpen",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            SpaSdk.instance.sendEvent(EventSpa.linkOpened(linkUri: "linkUri"));
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: const Color.fromRGBO(46, 123, 96, 1),
          ),
          child: const Text(
            "linkOpened",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            SpaSdk.instance.sendEvent(EventSpa.screenView(pageLocation: "pageLocation", pageReferrer: "pageReferrer"));
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: const Color.fromRGBO(46, 123, 96, 1),
          ),
          child: const Text(
            "screenView",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            SpaSdk.instance.sendEvent(EventSpa.custom(eventType: "eventType", customParam: {
              "customParam1": "valueCustomParam1",
              "customParam2": "valueCustomParam2",
            }));
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: const Color.fromRGBO(46, 123, 96, 1),
          ),
          child: const Text(
            "custom",
          ),
        ),
      ],
    );
  }



}
