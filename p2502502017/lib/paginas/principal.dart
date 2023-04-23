import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const publicKey = '984073122b4918efca023d25bdcd5c68';
const privateKey = 'fefdc584ac98a2222b80633bb9dc5f66a98e4d18';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int menuActivo = 0;

  late List<dynamic> _characters;

  Future<void> _fetchCharacters() async {
    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateMd5('$timeStamp$privateKey$publicKey');

    final response = await http.get(Uri.parse(
        'https://gateway.marvel.com/v1/public/characters?apikey=$publicKey&ts=$timeStamp&hash=$hash'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _characters = jsonData['data']['results'];
      });
      print(jsonData);
    } else {
      try{
      throw Exception('Error al cargar los personajes');
      }
      catch(Exception)
      {
        
      }
    }
  }

  String generateMd5(String input) {
    return input;
    //Implementación de md5 en dart
  }

  @override
  void initState() {
    super.initState();
    _characters = []; // Inicializar la lista con una lista vacía
    _fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/1.jpg"),
      fit: BoxFit.cover,
    ),
  ),
        width: double.infinity,
        height: double.infinity,
        
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "PARCIAL III",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: 155,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.05),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            menuActivo = 0;
                          });
                        },
                        child: Container(
                          width: 75,
                          height: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: menuActivo == 0
                                ? Color.fromARGB(255, 255, 255, 255).withOpacity(0.3)
                                : Color.fromARGB(0, 255, 255, 255),
                          ),
                          child: Center(
                            child: Text(
                              "Nombres",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            menuActivo = 1; // Cambiar a menú de "Apellidos"
                          });
                        },
                        child: Container(
                          width: 75,
                          height: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: menuActivo == 1
                                ? Color.fromARGB(255, 255, 255, 255).withOpacity(0.3)
                                : Color.fromARGB(0, 255, 255, 255),
                          ),
                          child: Center(
                            child: Text(
                              "Apellidos", // Agregar texto de "Apellidos"
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            menuActivo = 2;
                          });
                        },
                        child: Container(
                          width: 75,
                          height: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: menuActivo == 2
                                ? Color.fromARGB(255, 255, 255, 255).withOpacity(0.3)
                                : Color.fromARGB(0, 255, 255, 255),
                          ),
                          child: Center(
                            child: Text(
                              "Personajes",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: menuActivo == 0
                  ? Container(
                      child: Center(
                        child: Text(
                          "Gonzalo Eduardo",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : menuActivo == 1
                      ? Container(
                          child: Center(
                            child: Text(
                              "Chavez Benitez",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : _characters.isEmpty // Verificación agregada
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: _characters.length,
                              itemBuilder: (context, index) {
                                final character = _characters[index];
                                return ListTile(
                                  title: Text(character['name']),
                                  subtitle: Text(
                                    character['description'] != ''
                                        ? character['description']
                                        : 'Sin descripción',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Image.network(
                                    '${character['thumbnail']['path']}.${character['thumbnail']['extension']}',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
            )
          ],
        ),
      ),
    );
  }
}
