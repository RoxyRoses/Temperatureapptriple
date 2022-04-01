import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:temperatureapp/triple/forecastStore.dart';
import '../bloc/bloc_forecast_bloc.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final controllerCity = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final store = Modular.get<ForecastStore>();

    return Scaffold(
      appBar: null,
      body:
          
          TripleBuilder(
            store: store,
            builder: (context, triple) {
              if (triple.error != null) {
            showDialog<String>(
              // alertbox
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('Something went wrong'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
          if (triple.isLoading) {
            return const CircularProgressIndicator();
          }
          
            
          
              return Container(
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/rain.gif'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: size.height * 300 / size.height),
                                child: Text(
                                  "Type the City",
                                  style: TextStyle(
                                      fontSize: size.height * 35 / size.height,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 20 / size.width,
                                  right: size.width * 20 / size.width),
                              child: TextFormField(
                                controller: controllerCity,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter a valid city';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'City',
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 23, 130, 231),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 23, 130, 231),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 55,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 25 / size.width,
                                  right: size.width * 25 / size.width),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: size.height * 40 / size.height,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(255, 23, 130, 231),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 23, 130, 231),
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                            Modular.to.navigate('/forecast', arguments: triple.state);
                                          }
                                        },
                                        child: const Text('Confirm'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              
                    
                  );
            }
          ));
    
  }
}
