import 'package:drowsiness_detector/camera_scree.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'dart:async';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;
Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(DrowsinessDetector());
}

class DrowsinessDetector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Drowsiness Detector',
        home: HomePage(cameras: cameras),
        routes: {
          CameraScreen.routename: (context) => CameraScreen(cameras),
        });
  }
}

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  HomePage({this.cameras});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void launchPhone(command) async {
    if (await UrlLauncher.canLaunch(command)) {
      await UrlLauncher.launch(command);
    } else
      print('Could not launch $command');
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0xff32B8BB),
                  Colors.black,
                ])),
            child: Center(
                child: Text(
              'Drowsiness Detector',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
          ),
          /* Positioned(
            child: CircleAvatar(
              radius: 1000,
              backgroundColor: Color.fromRGBO(31, 63, 88, 0.2),
              child: Container(),
            ),
            right: -1920,
            top: -500,
          ), */
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(CameraScreen.routename);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xff32B8BB),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
                height: width * 0.3,
                width: width * 0.45,
                child: Center(
                  child: Text(
                    'LAUNCH',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: Icon(Icons.emoji_food_beverage),
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff32B8BB),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 5)
                      ]),
                  height: width * 0.2,
                  width: width * 0.2,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => launchPhone('tel: 8765247103'),
                  child: Container(
                    child: Center(
                      child: Icon(Icons.phone),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff32B8BB),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 5)
                        ]),
                    height: width * 0.2,
                    width: width * 0.2,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Center(
                    child: Icon(Icons.location_on),
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff32B8BB),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 5)
                      ]),
                  height: width * 0.2,
                  width: width * 0.2,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
