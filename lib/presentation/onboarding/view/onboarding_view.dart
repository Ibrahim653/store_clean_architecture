import 'package:advanced_app/app/app_prefs.dart';
import 'package:advanced_app/app/di.dart';
import 'package:advanced_app/domain/model/models.dart';
import 'package:advanced_app/presentation/onboarding/view_model/onboarding_view_model.dart';
import 'package:advanced_app/presentation/resourses/color_manager.dart';
import 'package:advanced_app/presentation/resourses/constants_manager.dart';
import 'package:advanced_app/presentation/resourses/routes_manager.dart';
import 'package:advanced_app/presentation/resourses/strings_manager.dart';
import 'package:advanced_app/presentation/resourses/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();

  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final AppPreference _appPreference = instance<AppPreference>();

  _bind() {
    _appPreference.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    return sliderViewObject == null
        ? const SizedBox()
        : Scaffold(
            backgroundColor: ColorManager.white,
            bottomSheet: Container(
                color: ColorManager.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.loginRoute);
                        },
                        child: Text(AppStrings.skip.tr(),
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                    ),
                    _getBottomSheetWidget(sliderViewObject),
                  ],
                )),
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: AppSize.s0,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: ColorManager.white,
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.dark),
            ),
            body: PageView.builder(
              controller: _pageController,
              itemCount: sliderViewObject.numOfSlides,
              onPageChanged: (index) {
                _viewModel.onPageChanged(index);
              },
              itemBuilder: (context, index) {
                return OnBoardingPage(sliderViewObject.sliderObject);
              },
            ),
          );
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                _pageController.animateToPage(
                  _viewModel.goPrevious(),
                  duration: const Duration(
                      microseconds: AppConstants.sliderAnimationTime),
                  curve: Curves.bounceInOut,
                );
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: ColorManager.white,
              )),
          for (int i = 0; i < sliderViewObject.numOfSlides; i++)
            _getProperCircle(i, sliderViewObject.currentIndex),
          IconButton(
              onPressed: () {
                _pageController.animateToPage(
                  _viewModel.goNext(),
                  duration: const Duration(
                      microseconds: AppConstants.sliderAnimationTime),
                  curve: Curves.bounceInOut,
                );
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: ColorManager.white,
              )),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    return index == currentIndex
        ? Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: AppSize.s8,
                backgroundColor: ColorManager.white,
              ),
              CircleAvatar(
                radius: AppSize.s6,
                backgroundColor: ColorManager.primary,
              ),
            ],
          )
        : CircleAvatar(
            radius: AppSize.s7,
            backgroundColor: ColorManager.white,
          );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);
  final SliderObject _sliderObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Text(
            _sliderObject.subTitle,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSize.s60),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}
