import 'package:flutter/widgets.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      child: child,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 0.651, 1.000],
        colors: [Color(0XFF5551FF), Color(0XFF716EFD), Color(0XFFF5F4F6)],
      )),
      padding: EdgeInsets.fromLTRB(20, 65, 20, 20),
    );
  }
}
