import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk_mk2/common/constant/date.dart';
import 'package:newbee_talk_mk2/common/constant/gaps.dart';
import 'package:newbee_talk_mk2/common/constant/sizes.dart';
import 'package:newbee_talk_mk2/common/widgets/common_text.dart';
import 'package:newbee_talk_mk2/features/main/controllers/search_controller.dart';
import 'package:newbee_talk_mk2/features/store/models/store.dart';

class SearchItems extends StatefulWidget {
  const SearchItems({super.key});

  @override
  State<SearchItems> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  final cont = SearchCont.to;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cont.asyncFavorite(),
      builder: (context, snapshot) {
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
            var model = cont.searchList[index];

            cont.setStoreId(model.id!);

            return _searchPageBody(
              context,
              model,
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
    FoodStoreModel model,
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
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  textContent: model.storeName,
                  textColor: Colors.black87,
                  textSize: Sizes.size20,
                  textWeight: FontWeight.w700,
                ),
                cont.favoriteIcon(),
              ],
            ),
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
    );
  }
}
