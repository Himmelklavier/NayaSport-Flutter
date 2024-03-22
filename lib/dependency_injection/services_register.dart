import 'package:get_it/get_it.dart';
import 'package:prueba/data/services/login/auth_service_impl.dart';
import 'package:prueba/data/services/products/products_service_impl.dart';
import 'package:prueba/data/services/shop/shop_service_impl.dart';

void injectorServices() {
  GetIt.I.registerSingleton<ShopServiceImpl>(ShopServiceImpl());
  GetIt.I.registerSingleton<ProductsServiceImpl>(ProductsServiceImpl());
  GetIt.I.registerSingleton<AuthServiceImpl>(AuthServiceImpl());
}
