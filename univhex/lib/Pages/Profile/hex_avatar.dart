import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Pages/Profile/ProfileScreen.dart';

class HexAvatar extends StatelessWidget {
  HexAvatar({
    super.key,
    required bool isUploading,
    required this.imgUrl,
    required this.width,
    this.borderColor,
  }) : _isUploading = isUploading;

  final bool _isUploading;
  final String imgUrl;
  final double width;
  Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return HexagonWidget.flat(
      width: borderColor != null ? width * 1.13 : width,
      color: borderColor,
      child: HexagonWidget.flat(
        width: width,
        color: AppColors.myLightBlue,
        child: !_isUploading
            ? AspectRatio(
                aspectRatio: HexagonType.FLAT.ratio,
                child: HexagonWidget.flat(
                  width: width * 0.07 / 0.08,
                  child: AspectRatio(
                    aspectRatio: HexagonType.FLAT.ratio,
                    child: imgUrl == 'assets/images/icon.png'
                        ? Image.asset(
                            'assets/images/icon.png',
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            imgUrl,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              )
            : const CircularProgressIndicator(
                backgroundColor: AppColors.myPurple, color: AppColors.myBlue),
      ),
    );
  }
}
