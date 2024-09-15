import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iGenTech/generated/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iGenTech/core/utils/app_colors.dart';

void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.secondColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _launchURL('https://www.figma.com/design/rMP7SJUWS2g6NcldrTvHyp/iGenTech?node-id=0-1&t=jlWIRTlDFMAI97UO-1'),
                  icon: SvgPicture.asset(
                    Assets.icons.figma,
                    height: 50.h,
                    width: 50.h,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    width: 2.w,
                    height: 50.h,
                    color: AppColors.bgColor,
                  ),
                ),

                IconButton(
                  onPressed: () => _launchURL('https://github.com/zeyadtarek1999/iGenTech.git'),
                  icon: SvgPicture.asset(
                    Assets.icons.github,
                    height: 50.h,
                    width: 50.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
