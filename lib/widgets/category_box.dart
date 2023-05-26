import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_course/theme/color.dart';
abstract class CategoryBoxHandler extends StatelessWidget{
  CategoryBoxHandler? _nextHandler;

  CategoryBoxHandler(CategoryBoxHandler? nextHandler) {
    _nextHandler = nextHandler;
  }

  void handleTap(GestureTapCallback? onTap) {
    if (onTap != null) {
      if (canHandle(onTap)) {
        handle();
      } else if (_nextHandler != null) {
        _nextHandler!.handleTap(onTap);
      }
    }
  }

  bool canHandle(GestureTapCallback onTap);

  void handle();
}
class CategoryBox extends CategoryBoxHandler {
  CategoryBox({
    Key? key,
    required this.data,
    this.isSelected = false,
    this.onTap,
    this.selectedColor = AppColor.actionColor,
    CategoryBoxHandler? nextHandler,
  }) : super(nextHandler);

  final data;
  final Color selectedColor;
  final bool isSelected;
  final GestureTapCallback? onTap;

  @override
  bool canHandle(GestureTapCallback onTap) {
    return this.onTap == onTap;
  }

  @override
  void handle() {
    // Handle the onTap event
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleTap(onTap),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isSelected ? AppColor.red : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColor.shadowColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              data["icon"],
              color: isSelected ? selectedColor : AppColor.textColor,
              width: 30,
              height: 30,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            data["name"],
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: TextStyle(
              color: AppColor.textColor,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
void setupCategoryBoxChain(List<CategoryBox> categoryBoxes) {
  for (int i = 0; i < categoryBoxes.length - 1; i++) {
    categoryBoxes[i]._nextHandler = categoryBoxes[i + 1];
  }
}