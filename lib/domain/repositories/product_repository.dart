import 'package:prueba/domain/entities/uniforme.dart';

abstract class ProductRepository {
 Future<List<Uniforme>> getAllProducts();
}
