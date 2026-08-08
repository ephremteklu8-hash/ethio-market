import 'package:flutter/material.dart';

void main() {
  runApp(const EthioMarketApp());
}

class EthioMarketApp extends StatelessWidget {
  const EthioMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ethio Market',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ethio Market'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Welcome to Ethio Market!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
