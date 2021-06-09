import 'package:bwa_flutix/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

part 'selectable_box.dart';

class LoadWidget extends StatelessWidget {
  final Color color;

  const LoadWidget({
    Key key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: color ?? Colors.white,
    );
  }
}

class CenterBackAndTitle extends StatelessWidget {
  final String text;
  final Function onTap;

  const CenterBackAndTitle({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 22),
      height: 56,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => onTap(),
              child: Icon(
                Icons.arrow_back,
                size: 28,
              ),
            ),
          ),
          Center(
              child: Text(
            text,
            textAlign: TextAlign.center,
            style: blackTextFont.copyWith(
                fontSize: 20, fontWeight: FontWeight.w500),
          ))
        ],
      ),
    );
  }
}
