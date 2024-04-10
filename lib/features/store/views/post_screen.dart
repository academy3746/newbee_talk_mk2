import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:newbee_talk_mk2/common/widgets/common_app_bar.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  static const String routeName = '/post';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildPageBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return const CommonAppBar(
      title: '주소 검색',
      implyLeading: true,
      backgroundColor: Colors.white,
      iconColor: Colors.black,
      fontColor: Colors.black,
    );
  }

  Widget _buildPageBody(BuildContext context) {
    return DaumPostcodeSearch(
      webPageTitle: '주소 검색',
      initialOption: InAppWebViewGroupOptions(),
      androidOnPermissionRequest: (webViewCont, origin, resources) async {
        return PermissionRequestResponse(
          resources: resources,
          action: PermissionRequestResponseAction.GRANT,
        );
      },
    );
  }
}
