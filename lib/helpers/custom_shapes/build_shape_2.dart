
import 'package:acwadcom/acwadcom_packges.dart';
import 'dart:math' as math;


class BuildItem extends StatefulWidget {
  final Widget child;
  const BuildItem({super.key, required this.child});

  @override
  State<BuildItem> createState() => _BuildItemState();
}

class _BuildItemState extends State<BuildItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10)
      ),
        
        height: 100.h,
        // width: 200,
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Positioned(
                left: -15,
                bottom: 35,
                child: Container(
                  height: 30,
                  width: 30,
                  child: CustomPaint(
                    painter: MyPainter(),
                  ),
                )),
            Positioned(
              right: -15,
              bottom: 30.5,
              child: Container(
                height: 30,
                width: 35,
                child: CustomPaint(
                  painter: MyPainter(),
                ),
              ),
            ),
            Positioned.fill(child: widget.child)
          ],
        ));
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi * 2,
      math.pi * 2,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
