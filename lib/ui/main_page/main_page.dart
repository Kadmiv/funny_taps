import 'package:flutter/material.dart';
import 'package:funny_taps/ui/custom_widgets/circle_widget.dart';

import 'main_page_presenter.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class IMainPageView {
  void setBackgroundColor(Color color) {}

  void setCirclePosition(newXPosition, newYPosition) {}

  void updateScoreInfo(int score) {}

  void changeScoreVisibility(bool isVisible) {}
}

class _MainPageState extends State<MainPage> implements IMainPageView {
  final IMainPagePresenter _presenter = MainPagePresenter();
  Color backgroundColor = Colors.white;

  //May be need put this parameters to some data objects for easy change data
  // But I didn't this
  var _scoreCount = 0;
  var _scoreVisibility = false;

  var _circleXPosition = -100.0;
  var _circleYPosition = -100.0;
  var _circleRadius = 50.0;

  @override
  void initState() {
    super.initState();
    _presenter.attachView(this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var circleWidget = createCircleWidget(_circleRadius);
    _presenter.setCircleGenerationData(_circleRadius, width, height);

    var helloText = createHelloTextWidget();
    var scoreText = crateScoreTextWidget();

    return Scaffold(
      body: Ink(
        width: width,
        height: height,
        child: InkWell(
          onTap: () {
            _presenter.onTap();
          },
          child: Container(
            decoration: new BoxDecoration(color: backgroundColor),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                circleWidget,
                helloText,
                Container(
                  alignment: Alignment.bottomRight,
                  child: scoreText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void setBackgroundColor(Color color) {

    setState(() {
      backgroundColor = color;
    });
  }

  createCircleWidget(double circleRadius) {
    return Container(
      alignment: Alignment(_circleXPosition, _circleYPosition),
      child: Ink(
        width: circleRadius * 2,
        height: circleRadius * 2,
        child: InkWell(
          onTap: () {
            print("onCircleTap");
            _presenter.onCircleTap();
          },
          child: Center(
            child: CustomPaint(
              painter: CirclePainter(circleRadius),
            ),
          ),
        ),
      ),
    );
  }

  createHelloTextWidget() {
    return Center(
      child: Text(
        'Hey there',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  crateScoreTextWidget() {
    return Visibility(
      child: Text(
        'Your score: $_scoreCount',
        style: TextStyle(fontSize: 18,color: Colors.white),
      ),
      visible: _scoreVisibility,
    );
  }

  void setCirclePosition(newXPosition, newYPosition) {
    setState(() {
      _circleXPosition = newXPosition;
      _circleYPosition = newYPosition;
    });
  }

  @override
  void updateScoreInfo(int score) {
    setState(() {
      _scoreCount = score;
    });
  }

  @override
  void changeScoreVisibility(bool isVisible) {
    setState(() {
      _scoreVisibility = isVisible;
    });
  }
}
