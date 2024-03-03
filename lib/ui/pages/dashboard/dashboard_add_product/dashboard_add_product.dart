// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:prueba/domain/entities/image.dart';
import 'package:prueba/domain/entities/product.dart';

class DashboardAddProduct extends StatefulWidget {
  const DashboardAddProduct({super.key});

  @override
  State<DashboardAddProduct> createState() => _DashboardAddProductState();
}

class _DashboardAddProductState extends State<DashboardAddProduct> {
  File? _file;
  late dynamic result;
  var product = Product.empty();
  bool _isButtonDisabled = false;

  final formKey = GlobalKey<FormState>();
  initState() {
   super.initState();
  _isButtonDisabled = false;
   }

  pickImage(ImageSource source) {
    MyImage(source: source).pick(onPick: (File? file) {
      setState(() {
        _file = file;
        print("estado:");
        print(_file!.path);
      });
    });
  }

  Future<void> fetchData2() async {
    print("hola");
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(
        Uri.parse('http://192.168.12.156:3001/api/auth/login'),
        headers: headers,
        body: jsonEncode(
            {"email": "naya.sports@gmail.com", "password": "Admin2023!"}));
    print(response);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> fetchData() async {
    print("hola fetch");
   
     if (_file == null) {
    print("No hay foto seleccionada");
    return;
  }

    var headers = {'Content-Type': 'multipart/form-data'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://192.168.12.156:3001/api/productos'));
    request.fields.addAll({
    'referencia': product.ref ?? '', // Asegúrate de que los valores no sean nulos
    'precio_int': product.cost?.toString() ?? '',
    'precio_venta': product.sellingPrice?.toString() ?? '',
    'dimensiones': product.size ?? '',
    'nombre': product.productName ?? '',
    'descripcion': product.description ?? '',
    'marca': product.brand ?? '',
    'Categoria_idCategoria': product.category?.toString() ?? ''
  });
  request.files.add(await http.MultipartFile.fromPath('imagen', _file!.path));
  request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("res");
    print(response);

    if (response.statusCode == 201) {
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Producto creado'),
          content: const Text('El producto se ha creado con éxito.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
      print(await response.stream.bytesToString());
      print("exito");
     
    } else {
      print(response.reasonPhrase);
      print("error");
      
    }
    setState(() {
      _isButtonDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/BackgroundWhite.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text("NayaSport - Dashboard"),
            ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            const Text("Añadir Nuevo Producto",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 0, 116, 131))),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Nombre Producto",
                              ),
                              onSaved: (value) {
                                product.productName = value.toString();
                                print('Valor guardado en product.name: ${product.productName}');
                              },
                              // ignore: body_might_complete_normally_nullable
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Complete la información";
                                }
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Ref",
                              ),
                              onSaved: (value) {
                                product.ref = value.toString();
                                print('Valor guardado en product.ref: ${product.ref}');
                              },
                              // ignore: body_might_complete_normally_nullable
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Complete la información";
                                }
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Costo",
                              ),
                              onSaved: (value) {
                                product.cost = int.parse(value.toString());
                                print('Valor guardado en product.cost: ${product.cost}');
                              },
                              // ignore: body_might_complete_normally_nullable
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Complete la información";
                                }
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Precio",
                              ),
                              onSaved: (value) {
                                product.sellingPrice =
                                    int.parse(value.toString());
                                    print('Valor guardado en product.sellingprice: ${product.sellingPrice}');
                              },
                              // ignore: body_might_complete_normally_nullable
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Complete la información";
                                }
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Categoria",
                              ),
                              onSaved: (value) {
                                product.category =
                                    int.parse(value.toString());
                                    print('Valor guardado en product.category: ${product.category}');
                                
                              },
                              // ignore: body_might_complete_normally_nullable
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Complete la información";
                                }
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Tamaño",
                              ),
                              onSaved: (value) {
                                product.size = value.toString();
                                print('Valor guardado en product.size: ${product.size}');
                              },
                              // ignore: body_might_complete_normally_nullable
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Complete la información";
                                }
                              },
                            ),
                            const Row(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(top: 15, bottom: 5),
                                  child: Text("Imagen",
                                      textAlign: TextAlign.right))
                            ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                      flex: 3,
                                      child: ElevatedButton(
                                        child: const Text("Tomar Foto"),
                                        onPressed: () {
                                          pickImage(ImageSource.camera);
                                        },
                                      )),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: OutlinedButton(
                                        child: const Text("Galeria"),
                                        onPressed: () {
                                          pickImage(ImageSource.gallery);
                                        },
                                      ))
                                ]),
                            ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.amber),
                              ),
                              child: const Text("Enviar"),
                              onPressed : _isButtonDisabled || _file == null ? null : () {
                                setState(() {
                                  _isButtonDisabled = true;
                                });
                                _showData(context);
                                fetchData();
                                 
                              },
                            ),
                            if (_file != null) Image.file(_file!)
                          ],
                        ))))));
  }

  void _showData(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();

      // ignore: avoid_print
      print(product.cost);
      // ignore: avoid_print
      print(product.productName);
    }
  }
}
