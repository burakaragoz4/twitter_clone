import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tabbar_view.dart';

class HomeView extends StatefulWidget {
  const HomeView(this.scroolController, {super.key});

  final ScrollController scroolController;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String _cardRandomImage = "https://picsum.photos/200/300";
  int defaultTabLenght = 4;
  final String _dummyTweet =
      "Bir sayfanın düzenine bakıldığında okunabilir içeriğin okuyucunun dikkatini dağıtacağı uzun zamandır bilinen bir gerçektir. Lorem Ipsum'u kullanmanın amacı, 'İçerik burada, içerik burada' seçeneğinin aksine, aşağı yukarı normal bir harf dağılımına sahip olması ve okunabilir bir İngilizce gibi görünmesidir.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listView,
    );
  }

  Widget get _listView => ListView.builder(
      itemCount: 10,
      controller: widget.scroolController,
      itemBuilder: (context, index) {
        return _listViewCard;
      });
  Widget get _listViewCard => Card(
        child: ListTile(
          leading:
              CircleAvatar(backgroundImage: NetworkImage(_cardRandomImage)),
          title: Wrap(
            direction: Axis.horizontal,
            runSpacing: 10,
            children: [
              _listCardTitle("Hello"),
              Text(_dummyTweet),
              _placeHolderField,
              _footerButtonRow
            ],
          ),
        ),
      );

  Widget _listCardTitle(String text) => Text(text, style: titleTextStyle);

  Widget get _placeHolderField => const SizedBox(
        height: 100,
        child: Placeholder(),
      );

  Widget get _footerButtonRow => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconLabelButton(_iconLabel("1")),
          _iconLabelButton(_iconLabel("1")),
          _iconLabelButton(_iconLabel("1")),
          _iconLabelButton(_iconLabel("1")),
        ],
      );

  Widget _iconLabel(String text) => Wrap(
        spacing: 5,
        children: [
          const Icon(Icons.comment, color: CupertinoColors.inactiveGray),
          Text(text)
        ],
      );
  Widget _iconLabelButton(Widget child) => InkWell(
        child: child,
        onTap: () {},
      );
}
