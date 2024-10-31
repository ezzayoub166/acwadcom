import 'package:acwadcom/acwadcom_packges.dart';

class DiscountSlider extends StatefulWidget {
  @override
  _DiscountSliderState createState() => _DiscountSliderState();
}

class _DiscountSliderState extends State<DiscountSlider> {
  // The value index corresponds to a list of percentage options.
  int _currentIndex = 1; // 1 corresponds to 15%

  // List of discount options
  final List<int> _discountOptions = [5,10, 15, 30];

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        myText(
          AText.discontrate.tr(context),
          fontSize: 20, 
          color: ManagerColors.kCustomColor,
          
          fontWeight: FontWeight.bold,
        ),
        buildSpacerH(5.0),
               Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _discountOptions.map((option) {
            return Text(
              '$option%',
              style: TextStyle(
                fontSize: 16,
                
                fontWeight: _discountOptions[_currentIndex] == option
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: _discountOptions[_currentIndex] == option
                    ?ManagerColors.kCustomColor

                    : Colors.grey,
              ),
            );
          }).toList(),
        ),
      buildSpacerH(5.0),

        Slider(
          value: _currentIndex.toDouble(),
          min: 0,
          max: 2,
          divisions: 2,
          activeColor: Colors.orange,
          inactiveColor: Colors.grey.shade300,
          onChanged: (double value) {
            setState(() {
              _currentIndex = value.toInt();
            });
          },
        ),
 
      ],
    );
  }
}