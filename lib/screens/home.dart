import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child:ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Text(
                'Nosso Drawer',
                style: TextStyle(
                  color: const Color.fromARGB(255, 70, 4, 128),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Adivinhar o Número',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,                 
                  color: Color.fromARGB(255, 2, 2, 2),
                )),
              onTap: () {
                Navigator.pushNamed(context, '/adivinhar');
              },
            ),
            ListTile(
              title: const Text('Calculadora',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,                 
                  color: Color.fromARGB(255, 2, 2, 2),
                )),
              onTap: () {
                Navigator.pushNamed(context, '/calculadora');
              },
            ),
            ListTile(
              title: const Text('Converter Moeda',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,                 
                  color: Color.fromARGB(255, 2, 2, 2),
                )),
              onTap: () {
                Navigator.pushNamed(context, '/converter-moeda');
              },
            ),
            ListTile(
              title: const Text('Converter Temperatura',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,                 
                  color: Color.fromARGB(255, 2, 2, 2),
                )),
              onTap: () {
                Navigator.pushNamed(context, '/converter-temperatura');
              },
            ),
            ListTile(
              title: const Text('Converter Temperatura End Point',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,                 
                  color: Color.fromARGB(255, 2, 2, 2),
                )),
              onTap: () {
                Navigator.pushNamed(context, '/converter-temperatura-ep');
              },
            ),
            ListTile(
              title: const Text('Lista Telefônica',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,                 
                  color: Color.fromARGB(255, 2, 2, 2),
                )),
              onTap: () {
                Navigator.pushNamed(context, '/lista-telefonica');
              },
            ),
            ListTile(
              title: const Text('Cadastro Pessoa',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,                 
                  color: Color.fromARGB(255, 2, 2, 2),
                )),
              onTap: () {
                Navigator.pushNamed(context, '/cadastro-pessoa');
              },
            ),

            //2025-08-07-Manipulação de banco de dados Local SQLite 
            ListTile(
              title: const Text('Salvar Pessoa SQLite',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,                 
                  color: Color.fromARGB(255, 2, 2, 2),
                )),
              onTap: () {
                Navigator.pushNamed(context, '/menu-sqlite');
              },
            ),





          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
