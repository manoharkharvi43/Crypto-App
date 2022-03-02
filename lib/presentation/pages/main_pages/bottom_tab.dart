import 'package:flutter/material.dart';
import 'package:simple_flutter_app/data/routes/dash_screens.dart';
import 'package:simple_flutter_app/data/stream/bottom_tab_index_stream.dart';

class BottomTabNav extends StatefulWidget {
  const BottomTabNav({Key? key}) : super(key: key);

  @override
  _BottomTabNavState createState() => _BottomTabNavState();
}

class _BottomTabNavState extends State<BottomTabNav> {
  int _selectedIndex = 0; //New
  var bottomTabInstance = BottomTabIndexStream();
  final PageStorageBucket bucket = PageStorageBucket();

  Widget _bottomNavigationBar(int selectedIndex) => Container(
        child: BottomNavigationBar(
          backgroundColor: Colors.blue,
          elevation: 0.5,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) => {
            setState(() {
              bottomTabInstance.setCurrentTabIndexToStream(index);
            })
          },
          selectedItemColor: Colors.white,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        width: 250,
      );

  @override
  void initState() {
    bottomTabInstance.bottomTabIndexStream.listen((event) {
      print("event===================> $event");
      _selectedIndex = event;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
        body: PageStorage(
          child: SafeArea(
            child: Center(
              child: MainAuthPages.main_auth_pages[_selectedIndex],
            ),
          ),
          bucket: bucket,
        ));
  }
}
