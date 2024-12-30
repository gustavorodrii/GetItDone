import 'package:get/get.dart';
import 'package:getitdone/app/routes/routes.dart';
import '../bindings/home_bindings.dart';
import '../features/home/page/home_page.dart';
import '../bindings/login_binding.dart';
import '../features/login/page/login_page.dart';
import '../bindings/register_binding.dart';
import '../features/register/page/register_page.dart';
import '../bindings/splash_binding.dart';
import '../features/splash/page/splash_page.dart';
import '../features/welcome/page/welcome_page.dart';

class RoutesPages {
  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(name: Routes.welcome, page: () => WelcomePage()),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
  ];
}
