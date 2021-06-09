part of 'widgets.dart';

class SelectableBox extends StatelessWidget {
  final bool isSelected;
  final bool isEnabled;
  final double width;
  final double height;
  final String text;
  final Function onTap;
  final TextStyle textStyle;

  const SelectableBox(
      {Key key,
      this.isSelected = false,
      this.isEnabled = true,
      this.width = 144,
      this.height = 56,
      this.text = "none",
      this.onTap,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: !(isEnabled)
                      ? accentColor3
                      : (isSelected)
                          ? accentColor2
                          : accentColor3),
              color: !(isEnabled)
                  ? accentColor3
                  : (isSelected)
                      ? accentColor2
                      : Colors.transparent),
          child: Center(
            child: Text(
              text ?? "None",
              style: textStyle ??
                  blackTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ));
  }
}
