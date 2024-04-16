import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newbee_talk_mk2/common/constant/date.dart';
import 'package:newbee_talk_mk2/common/constant/gaps.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/features/favorite/models/favorite.dart';
import 'package:newbee_talk_mk2/features/main/controllers/search_controller.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';

class SearchItems extends StatelessWidget {
  const SearchItems({super.key});

  @override
  Widget build(BuildContext context) {
    final cont = SearchCont.to;

    return FutureBuilder(
      future: cont.favoriteStatus(),
      builder: (context, snapshot) {
        final like = snapshot.data;

        if (snapshot.hasError) {
          return const Center(
            child: CommonText(
              textContent: '찾으시는 검색 결과가 없네요... 😭',
              textColor: Colors.black87,
              textSize: Sizes.size24,
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return ListView.separated(
          itemBuilder: (context, index) {
            var data = cont.searchList[index];

            cont.setStoreId(data.id!);

            return _searchPageBody(
              context,
              data,
              like!,
            );
          },
          separatorBuilder: (context, index) => Gaps.v20,
          itemCount: cont.searchList.length,
        );
      },
    );
  }

  /// Search Page Body
  Widget _searchPageBody(
    BuildContext context,
    FoodStoreModel data,
    List<FavoriteModel> like,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size16,
        vertical: Sizes.size12,
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.size4),
          side: const BorderSide(
            color: Colors.black87,
            width: 2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                textContent: data.storeName,
                textColor: Colors.black87,
                textSize: Sizes.size20,
                textWeight: FontWeight.w700,
              ),
              _likeIndicator(like),
            ],
          ),
          Gaps.v12,
          CommonText(
            textContent: data.storeInfo,
            textColor: Colors.black87,
            textSize: Sizes.size14,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Gaps.v20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                textContent: data.storeAddress,
                textColor: Colors.black87,
                textSize: Sizes.size12,
              ),
              CommonText(
                textContent: date.format(data.createdAt!),
                textSize: Sizes.size12,
                textColor: Colors.black87,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Favorite Status Indicator
  Widget _likeIndicator(List<FavoriteModel> like) {
    return GestureDetector(
      onTap: () {},
      child: const FaIcon(
        FontAwesomeIcons.solidHeart,
        size: Sizes.size18,
        color: Colors.pinkAccent,
      ),
    );
  }
}
