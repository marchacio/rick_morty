import 'package:rxdart/rxdart.dart';

class ScreenData {

  BehaviorSubject<double> _screenHeight = BehaviorSubject<double>();
  double get screenHeight => _screenHeight.value;
  void updateHeight(double _new) => _screenHeight.add(_new);


  BehaviorSubject<double> _screenWidth = BehaviorSubject<double>();
  double get screenWidth => _screenWidth.value;
  void updateWidth(double _new) => _screenWidth.add(_new);

}