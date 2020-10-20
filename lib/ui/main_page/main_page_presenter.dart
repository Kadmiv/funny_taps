import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:funny_taps/ui/basic/base_presenter.dart';

import 'main_page.dart';

abstract class IMainPagePresenter<IView> extends AbstractPresenter<IView> {
  void onTap();

  void onCircleTap();

  void setCircleGenerationData(double radius, double width, double height);
}

class MainPagePresenter extends IMainPagePresenter<IMainPageView> {
  double _radius = 0.0;
  double _width = 0.0;
  double _height = 0.0;

  double _xRelatedPos = 0.0;
  double _yRelatedPos = 0.0;
  bool _isFirsTap = false;

  int score = 0;

  @override
  void onTap() {
    changeBackgroundColor();
  }

  /*
  * On this function we send generated random color, for change background color
  * on View
  * */
  void changeBackgroundColor() {
    var randomColor = generateRandomColor();
    mView.setBackgroundColor(randomColor);

    //Check is a first tap after start program. If true, then show circle
    if (!_isFirsTap) {
      changeCirclePosition(0.0, 0.0);
      mView.changeScoreVisibility(true);
      _isFirsTap = !_isFirsTap;
    }
  }

  Color generateRandomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  @override
  void setCircleGenerationData(double radius, double width, double height) {
    _height = height;
    _width = width;
    _radius = radius;
    if (_isFirsTap) {
      changeCirclePosition(_xRelatedPos, _yRelatedPos);
    }
  }

  @override
  void onCircleTap() {
    calculateCirclePosition();
    changeBackgroundColor();
    changeScoreData();
  }

  /**
   * On this function we generate random position on x and y coordinates
   * and after then, send new position to View for changing position of Circle
   */
  void calculateCirclePosition() {
    _xRelatedPos = generateRandomRelativePosition(_width, _radius);
    _yRelatedPos = generateRandomRelativePosition(_height, _radius);
    changeCirclePosition(_xRelatedPos, _yRelatedPos);
  }

  void changeCirclePosition(double xRelatedPos, double yRelatedPos) {
    mView.setCirclePosition(xRelatedPos, yRelatedPos);
  }

  double generateRandomRelativePosition(double metric, double radius) {
    final _random = new Random();

    var min = _radius / metric;
    var max = (metric - _radius) / metric;

    //Verification value in range
    var value = _random.nextDouble();
    value = value > min
        ? value < max
            ? value
            : max
        : min;

    value = _random.nextBool() ? value : value * -1;
    return value;
  }

  void changeScoreData() {
    score++;
    mView.updateScoreInfo(score);
  }
}
