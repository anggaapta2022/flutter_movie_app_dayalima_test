part of './pages.dart';

class ShowCaseView extends StatelessWidget {
  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;
  final ShapeBorder shapeBorder;
  const ShowCaseView(
      {Key? key,
      required this.globalKey,
      required this.title,
      required this.description,
      required this.child,
      this.shapeBorder = const CircleBorder()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalKey,
      title: title,
      description: description,
      targetPadding: const EdgeInsets.all(5),
      targetShapeBorder: shapeBorder,
      overlayColor: cGrey.withOpacity(0.7),
      child: child,
    );
  }
}
