import 'package:acwadcom/acwadcom_packges.dart';

class TabItem extends StatelessWidget {
  final String title;
  final int count;

  const TabItem({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          myText(
            title,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 5),
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: ManagerColors.kCustomColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                count > 9 ? "9+" : count.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
