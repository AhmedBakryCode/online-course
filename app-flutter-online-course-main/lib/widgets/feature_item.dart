import 'package:flutter/material.dart';
import 'package:online_course/theme/color.dart';
import 'custom_image.dart';

abstract class WidgetBuilder {
  Widget buildWidget();
  WidgetBuilder? nextBuilder;
  Widget build() {
    final widget = buildWidget();
    if (nextBuilder != null) {
      return nextBuilder!.build();
    }
    return widget;
  }
}

class ImageWidgetBuilder extends WidgetBuilder {
  ImageWidgetBuilder({
    required this.data,
    required this.width,
    required this.height,
  });

  final data;
  final double width;
  final double height;

  @override
  Widget buildWidget() {
    return CustomImage(
      data["image"],
      width: double.infinity,
      height: 190,
      radius: 15,
    );
  }
}

class PriceWidgetBuilder extends WidgetBuilder {
  PriceWidgetBuilder({required this.data});

  final data;

  @override
  Widget buildWidget() {
    return Positioned(
      top: 170,
      right: 15,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowColor.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Text(
          data["price"],
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class InfoWidgetBuilder extends WidgetBuilder {
  InfoWidgetBuilder({required this.data, required this.width});

  final data;
  final double width;

  @override
  Widget buildWidget() {
    return Container(
      width: width - 20,
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data["name"],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17,
              color: AppColor.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AttributeWidgetBuilder(
                icon: Icons.play_circle_outlined,
                color: AppColor.labelColor,
                info: data["session"],
              ),
              const SizedBox(
                width: 12,
              ),
              AttributeWidgetBuilder(
                icon: Icons.schedule_rounded,
                color: AppColor.labelColor,
                info: data["duration"],
              ),
              const SizedBox(
                width: 12,
              ),
              AttributeWidgetBuilder(
                icon: Icons.star,
                color: AppColor.yellow,
                info: data["review"],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AttributeWidgetBuilder extends StatelessWidget {
  AttributeWidgetBuilder({
    required this.icon,
    required this.color,
    required this.info,
  });

  final IconData icon;
  final Color color;
  final String info;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}