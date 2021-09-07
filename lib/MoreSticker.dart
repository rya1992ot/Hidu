import 'package:face_hidden/editScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'AddExtra.dart';

class MoreStickers extends StatefulWidget {
  final List arguments;

  const MoreStickers({Key? key, required this.arguments}) : super(key: key);

  @override
  _MoreStickersState createState() => _MoreStickersState();
}

class _MoreStickersState extends State<MoreStickers> {
  List moreStickers = [
    "assets/Stickers/1.png",
    "assets/Stickers/2.png",
    "assets/Stickers/3.png",
    "assets/Stickers/4.png",
    "assets/Stickers/5.png",
    "assets/Stickers/6.png",
    "assets/Stickers/7.png",
    "assets/Stickers/8.png",
    "assets/Stickers/9.png",
    "assets/Stickers/10.png",
    "assets/Stickers/11.png",
    "assets/Stickers/12.png",
    "assets/Stickers/13.png",
    "assets/Stickers/14.png",
    "assets/Stickers/16.png",
    "assets/Stickers/17.png",
    "assets/Stickers/18.png",
    "assets/Stickers/19.png",
    "assets/Stickers/20.png",
    "assets/Stickers/21.png",
    "assets/Stickers/22.png",
    "assets/Stickers/23.png",
    "assets/Stickers/24.png",
    "assets/Stickers/25.png",
    "assets/Stickers/26.png",
    "assets/Stickers/27.png",
    "assets/Stickers/28.png",
    "assets/Stickers/29.png",
    "assets/Stickers/30.png",
    "assets/Stickers/31.png",
    "assets/Stickers/32.png",
    "assets/Stickers/33.png",
    "assets/Stickers/34.png",
    "assets/Stickers/35.png",
    "assets/Stickers/36.png",
    "assets/Stickers/37.png",
    "assets/Stickers/38.png",
    "assets/Stickers/39.png",
    "assets/Stickers/40.png",
    "assets/Stickers/41.png",
    "assets/Stickers/42.png",
    "assets/Stickers/43.png",
    "assets/Stickers/44.png",
    "assets/Stickers/45.png",
    "assets/Stickers/46.png",
    "assets/Stickers/47.png",
    "assets/Stickers/48.png",
    "assets/Stickers/49.png",
    "assets/Stickers/50.png",
    "assets/Stickers/51.png",
    "assets/Stickers/52.png",
    "assets/Stickers/53.png",
    "assets/Stickers/54.png",
    "assets/Stickers/55.png",
    "assets/Stickers/56.png",
    "assets/Stickers/57.png",
    "assets/Stickers/58.png",
    "assets/Stickers/59.png",
    "assets/Stickers/60.png",
    "assets/Stickers/61.png",
    "assets/Stickers/62.png",
    "assets/Stickers/63.png",
    "assets/Stickers/64.png",
    "assets/Stickers/65.png",
    "assets/Stickers/66.png",
    "assets/Stickers/67.png",
    "assets/Stickers/68.png",
    "assets/Stickers/69.png",
    "assets/Stickers/70.png",
    "assets/Stickers/71.png",
    "assets/Stickers/72.png",
    "assets/Stickers/73.png",
    "assets/Stickers/74.png",
    "assets/Stickers/75.png",
    "assets/Stickers/76.png",
    "assets/Stickers/77.png",
    "assets/Stickers/78.png",





  ];
  AddExtra addMany = AddExtra();

  late BannerAd _ad;

  @override
  void initState() {
    super.initState();
    _ad = BannerAd(
      adUnitId: "ca-app-pub-2888332208631573/3117307990",
      size: AdSize.banner,
      request: AdRequest(),
      listener: AdListener(onAdClosed: (ad) => ad.dispose()),
    );

    _ad.load();
  }

  Widget bannerAdWidget() {
    return StatefulBuilder(
      builder: (context, setState) => Container(
        child: AdWidget(ad: _ad),
        width: _ad.size.width.toDouble(),
        height: 100.0,
        alignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الملصقات',
          style: TextStyle(
              fontSize: 16,
              color: Color(0xff101D44).withOpacity(0.55),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffF9FBFB),
        iconTheme: IconThemeData(
          color: Color(0xff101D44).withOpacity(0.55), //change your color here
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:Column(
          children: [
            bannerAdWidget(),
            Expanded(
              // padding: EdgeInsets.only(top: 30.0),
              child: GridView.count(
                crossAxisCount: 4,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: List.generate(moreStickers.length, (index) {
                  final file = moreStickers[index];
                  return Card(
                      color: Color(0xffF9FBFB).withOpacity(0.70),
                      child: buildFile(context, file));
                }),
              ),
            ),
          ],
        ),

      ),
    );
  }

  Widget buildFile(BuildContext context, String file) => InkWell(
      child: Image.asset(
        file,
        width: 52,
        height: 52,

        //  fit: BoxFit.cover,
      ),
      onTap: () {
        setState(() {
          AddExtra addMany = AddExtra();

          addMany.file = file;
          addMany.moreSticker = true;
          // addMany.accepted=false;
          addMany.addExtra();
        });

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditPhotoScreen(
            arguments: widget.arguments,
          ),
        ));
      });
}