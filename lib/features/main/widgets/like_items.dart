import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/app_router.dart';
import 'package:newbee_talk_mk2/common/constant/date.dart';
import 'package:newbee_talk_mk2/common/constant/gaps.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/features/main/controllers/like_controller.dart';
import 'package:newbee_talk_mk2/features/store/controllers/detail_controller.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';

class LikeItems extends StatefulWidget {
  const LikeItems({super.key});

  @override
  State<LikeItems> createState() => _LikeItemsState();
}

class _LikeItemsState extends State<LikeItems> {
  final cont = LikeCont.to;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cont.asyncFoodStoreBuilder(),
      builder: (context, snapshot) {
        var items = snapshot.data ?? [];

        if (snapshot.hasError) {
          return Center(
            child: CommonText(
              textContent: snapshot.error.toString(),
              textColor: Colors.black87,
              textSize: Sizes.size16,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (cont.items.isEmpty) {
          return const Center(
            child: CommonText(
              textContent: '아직 찜한 플레이스가 없네요... 😭',
              textColor: Colors.black87,
              textSize: Sizes.size16,
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            var model = items[index];

            return _buildFavoriteList(model);
          },
          separatorBuilder: (context, index) => Gaps.v20,
          itemCount: cont.items.length,
        );
      },
    );
  }

  /// Build Favorite Store List UI
  Widget _buildFavoriteList(FoodStoreModel model) {
    return GestureDetector(
      onTap: () {
        final detail = DetailCont.to;

        detail.setStoreData(model);

        AppRouter.detail().to();
      },
      child: Container(
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
                  textContent: model.storeName,
                  textColor: Colors.black87,
                  textSize: Sizes.size20,
                  textWeight: FontWeight.w700,
                ),
                _favoriteStatus(model),
              ],
            ),
            Gaps.v12,
            CommonText(
              textContent: model.storeInfo,
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
                  textContent: model.storeAddress,
                  textColor: Colors.black87,
                  textSize: Sizes.size12,
                ),
                CommonText(
                  textContent: date.format(model.createdAt!),
                  textSize: Sizes.size12,
                  textColor: Colors.black87,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Favorite Status Indicator UI
  Widget _favoriteStatus(FoodStoreModel model) {
    for (var item in cont.items) {
      if (item.id == model.id) {
        cont.setFavorite(
          item.id!,
          true,
        );

        break;
      }
    }

    return Obx(
      () => FaIcon(
        cont.isFavorite(model.id!) == true
            ? FontAwesomeIcons.solidHeart
            : FontAwesomeIcons.heart,
        color: Colors.pinkAccent,
        size: Sizes.size18,
      ),
    );
  }
}
