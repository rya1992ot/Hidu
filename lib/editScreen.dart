import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;
import 'package:google_mobile_ads/google_mobile_ads.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:ext_storage/ext_storage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'main.dart';
import 'package:face_hidden/MoreSticker.dart';
import 'AddExtra.dart';

double scale = 0.0;

// ignore: must_be_immutable
class EditPhotoScreen extends StatefulWidget {
  final List arguments;

  EditPhotoScreen({required this.arguments});

  @override
  _EditPhotoScreenState createState() => _EditPhotoScreenState();
}

class _EditPhotoScreenState extends State<EditPhotoScreen> {
  AddExtra addMany = AddExtra();
  AddExtra addManyBuild = AddExtra();

  late File _image;
  final picker = ImagePicker();
  final GlobalKey globalKey = GlobalKey();
  late InterstitialAd myInterstitial;
  bool hasFailed = true;
  late File ima;
  late File imageFile;
  List stickers = [
    "assets/filters/cloud1.png",
    "assets/filters/cloud4.png",
    "assets/filters/cloud6.png",
  ];

  Random rng = new Random();
  //late String data1;
  // double height = 60;
  // double width = 60;

  @override
  void initState() {
    super.initState();
    ima = widget.arguments[0];
    myInterstitial = InterstitialAd(
      adUnitId: 'ca-app-pub-2888332208631573/2830387671',
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (ad) {
          setState(() {
            hasFailed = false;
          });
        },
        onAdClosed: (ad) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SelectBottomPanel(), // Navigate to second page
            ),
          );
          ad.dispose(); // dispose of ad
        },
        onAdFailedToLoad: (ad, error) {
          setState(() {
            hasFailed = true;
          });
          ad.dispose(); // dispose of ad
          print('Ad exited with error: $error');
        },
      ),
    );
    myInterstitial.load();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: RepaintBoundary(
                  key: globalKey,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: queryData.size.height,
                        width: queryData.size.width,
                        child: ExtendedImage(
                          image: ExtendedFileImageProvider(ima),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Stack(
                        children: [...addManyBuild.buildOneByOne(context)],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  left: 0.0, right: 0.0, top: 0.0, child: buildStickers()),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff101D44).withOpacity(0.55),
        foregroundColor: Color(0xffF9FBFB).withOpacity(0.64),
        elevation: 8,
        onPressed: ()async {

         await Future.delayed(Duration(seconds: 3),
                 ()
         {
            takeScreenshot();
          });
          hasFailed
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SelectBottomPanel(), // Navigate to second page
                  ),
                )
              : myInterstitial.show();

        },
        tooltip: 'حفظ',
        child: Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildStickers() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffF9FBFB),
                Color(0xff101D44).withOpacity(0.55),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            color: Color(0xff101D44).withOpacity(0.70),
          ),
          alignment: Alignment.center,
          height: 60,
          // margin: EdgeInsets.all(80),
          margin: EdgeInsets.all(80),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stickers.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    child: Image.asset(stickers[index], height: 60, width: 60),
                    onTap: () {
                      setState(() {
                        AddExtra addMany = AddExtra();
                        addMany.accepted = true;
                        addMany.data1 = stickers[index];
                        addMany.addExtra();

                        //    addMany.matrix=Matrix4.identity();
                      });

                      //   for (int index = 0; index<=3;index++){
                      //   AddExtra addMany[index] = AddExtra();
                      //   setState(() {
                      //     addMany[index].accepted = true;
                      //     addMany[index].data1 = stickers[index];
                      //     addMany[index].addExtra();
                      //     //    addMany.matrix=Matrix4.identity();
                      //   });
                      //   return addMany[index];
                      //
                      // }
                    },
                  ),
                ],
              );
            },
          ),
        ),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffF9FBFB),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
            height: 60,
            width: 60,
            margin: EdgeInsets.only(top: 80, right: 50),
            child: IconButton(
                icon: Icon(
                  Icons.read_more_rounded,
                  color: Color(0xff101D44).withOpacity(0.55),
                ),
                iconSize: 24.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MoreStickers(
                              arguments: widget.arguments,
                            )),
                  );
                }),
          ),
        ),
        Positioned(
          top: 80.0,
          left: 40.0,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 10,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Color(0xffF9FBFB),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            height: 60,
            width: 60,
          //  margin: EdgeInsets.only(top: 80, right: 295),
            child: IconButton(
                icon: Icon(
                  Icons.refresh_sharp,
                  color: Color(0xff101D44).withOpacity(0.55),
                ),
                iconSize: 24.0,
                onPressed: () async {
                  {
                    extra.clear();
                    await getImage();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPhotoScreen(
                          arguments: [ima],
                        ),
                      ),
                    );
                  }
                }),
          ),
        )
      ],
    );

    // })
  }

// path provider for ios
  // ext path for android
  takeScreenshot() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage();

    String directory = "";
    if (Platform.isAndroid) {
      directory = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_DOWNLOADS);
    } else if (Platform.isIOS) {
      // directory = (await getDownloadsDirectory()).path;
      directory = (await getApplicationDocumentsDirectory()).path;
    }
    // print(directory);
    await Directory(directory).create();
    // print("your dic is---------- $directory");
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
    File imgFile = File('$directory/screenshot${rng.nextInt(200)}.png');
    imgFile.writeAsBytes(pngBytes);

    setState(() {
      imageFile = imgFile;
    });
    _savefile(imageFile);
  }

  _savefile(File file) async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(await file.readAsBytes()));

      print(result);
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      setState(() {
        ima = _image;
      });
    }
  }
}
