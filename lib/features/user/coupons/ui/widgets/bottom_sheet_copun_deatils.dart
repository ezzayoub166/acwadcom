
// BottomSheetContent StatefulWidget
import 'package:acwadcom/acwadcom_packges.dart';

class BottomSheetContent extends StatefulWidget {
  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Draggable indicator
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Text(
            '${AText.saveMoney.tr(context)}\n STANDR 20',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              color: ManagerColors.kCustomColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Thumbs down
              Column(
                children: [
                  const Icon(
                    Icons.thumb_down,
                    color: Colors.red,
                    size: 36,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AText.nolbl.tr(context),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              // Thumbs up
              Column(
                children: [
                  Icon(
                    Icons.thumb_up,
                    color: Colors.green,
                    size: 36,
                  ),
                  SizedBox(height: 4),
                  Text(
                    AText.yeslbl.tr(context),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.share),
                color: Colors.grey[700],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.flag),
                color: Colors.grey[700],
              ),
              IconButton(
                onPressed: _toggleFavorite,
                icon: Icon(Icons.favorite),
                color: _isFavorited ? Colors.red : Colors.grey[700],
              ),
            ],
          ),
        ],
      ),
    );
  }
}