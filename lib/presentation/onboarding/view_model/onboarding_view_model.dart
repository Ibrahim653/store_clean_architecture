import 'dart:async';

import 'package:advanced_app/domain/model/models.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../base/base_view_model.dart';
import '../../resourses/assets_manager.dart';
import '../../resourses/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    implements OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //stream controller outputs
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  dispose() {
    _streamController.close();
  }

  @override
  start() {
    _list = getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

//onBoarding Private Functions

  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _currentIndex, _list.length));
  }

  List<SliderObject> getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1.tr(), ImageAssets.onBoardingLogo1,
            AppStrings.onBoardingSubTitle1.tr()),
        SliderObject(AppStrings.onBoardingTitle2.tr(), ImageAssets.onBoardingLogo2,
            AppStrings.onBoardingSubTitle2.tr()),
        SliderObject(AppStrings.onBoardingTitle3.tr(), ImageAssets.onBoardingLogo3,
            AppStrings.onBoardingSubTitle3.tr()),
        SliderObject(AppStrings.onBoardingTitle4.tr(), ImageAssets.onBoardingLogo4,
            AppStrings.onBoardingSubTitle4.tr())
      ];
}

abstract class OnBoardingViewModelInputs {
  int goNext();

  int goPrevious();

  void onPageChanged(int index);

  //stream controller input
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}
