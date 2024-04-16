import 'package:flutter/material.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_app_bar.dart';
import 'package:newbee_talk_mk2/features/main/widgets/search_items.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  PreferredSizeWidget _buildAppBar() {
    return const CommonAppBar(
      title: '검색 결과',
      implyLeading: true,
      backgroundColor: Colors.white,
      iconColor: Colors.black87,
      fontColor: Colors.black87,
    );
  }

  Widget _buildPageBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size16,
        horizontal: Sizes.size20,
      ),
      child: const SearchItems(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildPageBody(context),
    );
  }
}
