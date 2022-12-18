import 'package:advanced_app/app/app_prefs.dart';
import 'package:advanced_app/app/di.dart';
import 'package:advanced_app/presentation/resourses/assets_manager.dart';
import 'package:advanced_app/presentation/resourses/color_manager.dart';
import 'package:advanced_app/presentation/resourses/routes_manager.dart';
import 'package:advanced_app/presentation/resourses/strings_manager.dart';
import 'package:advanced_app/presentation/resourses/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/data_source/local_data_source.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreference _appPreference = instance<AppPreference>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          listTileItem(
            SvgPicture.asset(ImageAssets.changeLangIc),
             Icon(Icons.arrow_forward_ios,color: ColorManager.primary,size: AppSize.s18,),
            () {
              _changeLanguage();
            },
            AppStrings.changeLanguage.tr(),
          ),
          listTileItem(
            SvgPicture.asset(ImageAssets.contactUsIc),
             Icon(Icons.arrow_forward_ios,color: ColorManager.primary,size: AppSize.s18,),
            () {
              _contactUs();
            },
            AppStrings.contactUs.tr(),
          ),
          listTileItem(
            SvgPicture.asset(ImageAssets.inviteFriendsIc),
             Icon(Icons.arrow_forward_ios,color: ColorManager.primary,size: AppSize.s18,),
            () {
              _inviteFriends();
            },
            AppStrings.inviteYourFriends.tr(),
          ),
          listTileItem(
            SvgPicture.asset(ImageAssets.logoutIc),
             Icon(Icons.arrow_forward_ios,color: ColorManager.primary,size: AppSize.s18,),
            () {
              _logOut();
            },
            AppStrings.logout.tr(),
          ),
        ],
      ),
    );
  }

  Widget listTileItem(
      Widget leading, Widget trailing, Function() onTap, String title) {
    return ListTile(
      leading: leading,
      trailing: trailing,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: onTap,
    );
  }

  void _changeLanguage() {
    _appPreference.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  void _contactUs() {}

  void _inviteFriends() {}

  void _logOut() {
    // app prefs make that user logged out
    _appPreference.makeUserLogout();

    // clear cache of logged out user
    _localDataSource.clearCache();

    // navigate to login screen
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
