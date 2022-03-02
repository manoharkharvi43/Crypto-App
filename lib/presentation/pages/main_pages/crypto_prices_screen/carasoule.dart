import 'package:flutter/cupertino.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<String> images = [
    "assets/images/Ada.jpg",
    "assets/images/Dot.jpg",
    "assets/images/Axs.jpg",
    "assets/images/Luna.jpg",
    "assets/images/Mana.jpg",
    "assets/images/Sand.jpg",
  ];

  var pageController = PageController(viewportFraction: 0.8);

  int activePage= 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: images.length,
        controller: pageController,
        // onPageChanged: (page) {
        //   setState(() {
        //     activePage = page;
        //   });
        // },
        itemBuilder: (context, pagePosition) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Image.asset(images[pagePosition] , fit: BoxFit.fitHeight,),
          );
        });
  }
}
