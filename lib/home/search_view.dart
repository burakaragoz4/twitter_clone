import 'package:flutter/material.dart';
import 'package:twitter_clone/model/trend_topic.dart';

import '../custom/refresh2.dart';

class SearchView extends StatefulWidget {
  const SearchView(this.scrollController, {super.key});
  final ScrollController scrollController;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final double _padding = 20;
  TrendTopic? _trendTopic;
  bool isRefresh = false;

  @override
  void initState() {
    super.initState();
    _trendTopic = TrendTopic(
        location: "Trending in Turkey ",
        hashtag: "#Fenerbahçe",
        tweets: "28.4K Tweets");
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator2(
      onRefresh: tempFuture,
      child: ListView(
        children: [
          _downIconWidget,
          _emptySpace,
          _trendTitleWidget,
          _listHashView,
        ],
      ),
    );
  }

  Future tempFuture() async {
    setState(() {
      isRefresh = !isRefresh;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      isRefresh = !isRefresh;
    });
  }

  Widget get _emptySpace => const SizedBox(height: 10);

  Widget get _downIconWidget => AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: isRefresh ? 60 : 30,
        child: isRefresh
            ? const Center(child: CircularProgressIndicator())
            : const Icon(
                Icons.arrow_downward,
                color: Colors.grey,
              ),
      );

  Widget get _trendTitleWidget => Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        margin: const EdgeInsets.all(0),
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: const BorderSide(color: Colors.grey, width: 0.5)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _padding),
          alignment: Alignment.centerLeft,
          height: 50,
          child: Text("Trends for you",
              style: Theme.of(context).textTheme.displayLarge),
        ),
      );

  Widget get _divider => const Divider(
        height: 0,
        color: Colors.grey,
      );

  Widget get _listHashView => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        separatorBuilder: (context, index) => _divider,
        itemBuilder: (context, index) => cardListMethod(context),
      );

  Card cardListMethod(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: const RoundedRectangleBorder(
          side: BorderSide(style: BorderStyle.none)),
      child: listPadding(context),
    );
  }

  Padding listPadding(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding, vertical: 5),
      child: row(context),
    );
  }

  Row row(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Wrap(
          direction: Axis.vertical,
          spacing: 5,
          children: [
            Text(_trendTopic!.location!,
                style: Theme.of(context).textTheme.bodySmall),
            Text(_trendTopic!.hashtag!,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 15)),
            Text(_trendTopic!.tweets!,
                style: Theme.of(context).textTheme.labelLarge)
          ],
        )),
        const Icon(Icons.arrow_downward, color: Colors.grey),
      ],
    );
  }
}
