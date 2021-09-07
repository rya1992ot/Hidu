// @dart=2.9
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:face_hidden/editScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'AddExtra.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: SelectBottomPanel()));
  }
}

class SelectBottomPanel extends StatefulWidget {
  const SelectBottomPanel({
    Key key,
  }) : super(key: key);

  @override
  _SelectBottomPanelState createState() => _SelectBottomPanelState();
}

class _SelectBottomPanelState extends State<SelectBottomPanel> {
  File _image;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Future.delayed(Duration(seconds: 0)).then(
            (value) => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => EditPhotoScreen(
              arguments: [_image],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.only(top: 25, bottom: 70),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //   color: Colors.white,
        // ),
        child: Column(
          children: <Widget>[
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async { extra.clear();
                          await getImage();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          height:
                          MediaQuery.of(context).size.width / 2 / 0.6625,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                width:
                                MediaQuery.of(context).size.width / 2 - 14,
                                height: MediaQuery.of(context).size.width /
                                    2 /
                                    0.6625,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2),
                                  border: Border.all(
                                      color:
                                      Color(0xffF9FBFB).withOpacity(0.64),
                                      width: 3),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Opacity(
                                      opacity: 1,
                                      child: Image.asset(
                                        "assets/back6.jpg",
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "اختر صورة",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff101D44).withOpacity(0.55),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "  اختر صورة واضف ستيكر يخفي الوجه او اي جزء بشكل مرتب وجميل ثم احفظها بجهازك او شاركها مع اي شخص واي برنامج بكل سهولة",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff101D44).withOpacity(0.55),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }}