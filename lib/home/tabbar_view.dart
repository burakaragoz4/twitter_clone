import 'package:flutter/material.dart';
import 'package:twitter_clone/home/home_view.dart';
import 'package:twitter_clone/home/search_view.dart';

class TwitterTabbarView extends StatefulWidget {
  const TwitterTabbarView({super.key});

  @override
  State<TwitterTabbarView> createState() => _TwitterTabbarViewState();
}

class _TwitterTabbarViewState extends State<TwitterTabbarView> {
  final String _photoUrl = "https://picsum.photos/200/300";
  int defaultTabLenght = 4;
  bool isHeaderClose = false;
  double lastOffset = 0;
  late ScrollController _scroolController = ScrollController();
  int? _currentIndex;

  @override
  void initState() {
    super.initState();
    _scroolController = ScrollController();
    _scroolController.addListener(() {
      if (_scroolController.offset <= 0) {
        isHeaderClose = false;
      } else if (_scroolController.offset >=
          _scroolController.position.maxScrollExtent) {
        isHeaderClose = true;
      } else {
        isHeaderClose = _scroolController.offset > lastOffset ? true : false;
      }

      setState(() {
        lastOffset = _scroolController.offset;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scroolController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: defaultTabLenght,
        child: Scaffold(
          floatingActionButton: _fabButton,
          bottomNavigationBar: _bottomAppBar,
          body: Column(
            children: [
              const SizedBox(height: 10),
              _containerAppbar,
              Expanded(
                  child: TabBarView(children: [
                HomeView(_scroolController),
                SearchView(_scroolController),
                const Center(child: Text("Notifications")),
                const Center(child: Text("Messages")),
              ])),
            ],
          ),
        ));
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.star_border_purple500),
      );

  Widget get _bottomAppBar => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: _tabbarItems,
      );

  Widget get _tabbarItems => TabBar(
        isScrollable: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        tabs: const [
          Tab(icon: Icon(Icons.home)),
          Tab(icon: Icon(Icons.search)),
          Tab(icon: Icon(Icons.notifications)),
          Tab(icon: Icon(Icons.mail))
        ],
      );

  Widget get _containerAppbar => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: isHeaderClose ? 0 : 100,
        child: _appbar,
      );

  Widget get _appbar => AppBar(
        elevation: 0,
        centerTitle: false,
        title: _appBarItems,
      );

  Widget get _appBarItems => Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(_photoUrl)),
          _emptyWidth,
          Expanded(child: _centerAppBarWidget),
          _emptyWidth,
          const Icon(
            Icons.star_border,
            color: Colors.blue,
          )
        ],
      );

  Widget get _emptyWidth => const SizedBox(width: 20);

  Widget get _centerAppBarWidget => _currentIndex == 1
      ? _searchTextField
      : const Text("Home", style: titleTextStyle);

  Widget get _searchTextField => TextField(
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        hintText: "Search Twitter",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
      ));

  OutlineInputBorder get outlineInputBorder => const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(20)));
}

const titleTextStyle = TextStyle(
    letterSpacing: 1,
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.bold);
