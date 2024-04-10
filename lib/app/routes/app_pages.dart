import 'package:akalsahae/app/modules/Accessory_Product_detail/product_binding.dart';
import 'package:akalsahae/app/modules/Accessory_Product_detail/product_screen.dart';
import 'package:akalsahae/app/modules/Edit%20Profile%20Module/edit_profile_binding.dart';
import 'package:akalsahae/app/modules/My%20Profile%20Module/profile_binding.dart';
import 'package:akalsahae/app/modules/My%20Profile%20Module/profile_screen.dart';

import 'package:akalsahae/app/modules/Order_Confirm_Module/OrderConfirmScreenBinding.dart';
import 'package:akalsahae/app/modules/accessories/accessories_binding.dart';
import 'package:akalsahae/app/modules/accessories/accessories_screen.dart';
import 'package:akalsahae/app/modules/bottom_screen_module/bottom_screen_bindings.dart';
import 'package:akalsahae/app/modules/bottom_screen_module/bottom_screen_page.dart';
import 'package:akalsahae/app/modules/shop_screen_module/shop_screen_bindings.dart';
import 'package:akalsahae/app/modules/shop_screen_module/shop_screen_page.dart';

import 'package:akalsahae/app/modules/try_now_screen_module/try_now_screen_bindings.dart';
import 'package:akalsahae/app/modules/try_now_screen_module/try_now_screen_page.dart';

import '../../app/modules/favorite_screen_module/favorite_screen_page.dart';
import '../../app/modules/favorite_screen_module/favorite_screen_bindings.dart';
import '../../app/modules/save_address_screen_module/save_address_screen_page.dart';
import '../../app/modules/save_address_screen_module/save_address_screen_bindings.dart';

import 'package:akalsahae/app/modules/check_out_screen_module/check_out_screen_bindings.dart';
import 'package:akalsahae/app/modules/check_out_screen_module/check_out_screen_page.dart';
import 'package:akalsahae/app/modules/my_order_screen_module/my_order_screen_bindings.dart';
import 'package:akalsahae/app/modules/my_order_screen_module/my_order_screen_page.dart';
import '../../app/modules/home_screen_module/home_screen_page.dart';
import '../../app/modules/home_screen_module/home_screen_bindings.dart';

import '../../app/modules/login_screen_module/login_screen_page.dart';
import '../../app/modules/login_screen_module/login_screen_bindings.dart';
import '../../app/modules/splash_screen_module/splash_screen_page.dart';
import '../../app/modules/splash_screen_module/splash_screen_bindings.dart';
import '../../app/modules/fullvoile_turban_screen_module/fullvoile_turban_screen_page.dart';
import '../../app/modules/fullvoile_turban_screen_module/fullvoile_turban_screen_bindings.dart';
import '../../app/modules/add_address_screen_module/add_address_screen_page.dart';
import '../../app/modules/add_address_screen_module/add_address_screen_bindings.dart';
import '../../app/modules/more_screen_module/more_screen_page.dart';
import '../../app/modules/more_screen_module/more_screen_bindings.dart';
import '../../app/modules/my_account_screen_module/my_account_screen_page.dart';
import '../../app/modules/my_account_screen_module/my_account_screen_bindings.dart';
import '../../app/modules/verification_screen_module/verification_screen_bindings.dart';
import '../../app/modules/verification_screen_module/verification_screen_page.dart';
import 'package:get/get.dart';

import '../modules/Edit Profile Module/edit_profile_screen.dart';
import '../modules/Order_Confirm_Module/OrderConfirmScreen.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.VERIFICATION_SCREEN,
      page: () => VerificationScreenPage(),
      binding: VerificationScreenBinding(),
    ),
    GetPage(
      name: Routes.MY_ACCOUNT_SCREEN,
      page: () => const MyAccountScreenPage(),
      binding: MyAccountScreenBinding(),
    ),
    GetPage(
      name: Routes.MORE_SCREEN,
      page: () => MoreScreenPage(),
      binding: MoreScreenBinding(),
    ),
    GetPage(
      name: Routes.ADD_ADDRESS_SCREEN,
      page: () => AddAddressScreenPage(),
      binding: AddAddressScreenBinding(),
    ),
    GetPage(
      name: Routes.FULLVOILE_TURBAN_SCREEN,
      page: () => const FullvoileTurbanScreenPage(),
      bindings: [FullvoileTurbanScreenBinding(), ShopScreenBinding()],
    ),
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => SplashScreenPage(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.LOGIN_SCREEN,
      page: () => LoginScreenPage(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: Routes.BOTTOM_SCREEN,
      page: () => BottomScreenPage(),
      binding: BottomScreenBinding(),
    ),
    GetPage(
      name: Routes.TRY_NOW_SCREEN,
      page: () => TryNowScreenPage(),
      binding: TryNowScreenBinding(),
    ),
    GetPage(
      name: Routes.HOME_SCREEN,
      page: () => HomeScreenPage(),
      bindings: [HomeScreenBinding(), CheckOutScreenBinding(), SaveAddressScreenBinding()],
    ),
    GetPage(
      name: Routes.CHECK_OUT_SCREEN,
      page: () => const CheckOutScreenPage(),
      binding: CheckOutScreenBinding(),
    ),
    GetPage(
      name: Routes.MY_ORDER_SCREEN,
      page: () => const MyOrderScreenPage(),
      binding: MyOrderScreenBinding(),
    ),
    GetPage(
      name: Routes.SHOP_SCREEN,
      page: () => ShopScreenPage(),
      binding: ShopScreenBinding(),
    ),
    GetPage(
      name: Routes.SAVE_ADDRESS_SCREEN,
      page: () => const SaveAddressScreenPage(),
      binding: SaveAddressScreenBinding(),
    ),
    GetPage(
      name: Routes.FAVORITE_SCREEN,
      page: () => const FavoriteScreenPage(),
      binding: FavoriteScreenBinding(),
    ),
    GetPage(
      name: Routes.ACCESSORY_SCREEN,
      page: () => AccessoriesScreen(),
      binding: AccessoriesBinding(),
    ),
    GetPage(
      name: Routes.ACCESSORY_PRODUCT,
      page: () => ProductScreen(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.CONFIRM_ORDER,
      page: () => OrderConfirmScreenPage(),
      binding: OrderConfirmScreenBinding(),
    ),
    GetPage(
      name: Routes.PROFILE_SCREEN,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE_SCREEN,
      page: () => const EditProfileScreen(),
      binding: EditProfileBinding(),
    ),
  ];
}
