import 'package:flutter/material.dart';
import 'home_page.dart';
import 'favorites_page.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Início"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagem com bordas arredondadas
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                'https://static.vecteezy.com/ti/vetor-gratis/p1/5919290-video-play-film-player-movie-solid-icon-vector-illustration-logo-template-suitable-for-many-purposes-gratis-vetor.jpg',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // Título
            const Text(
              "Bem Vindo, escolha sua opção",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Botão para Lista de Filmes
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text("Lista de Filmes"),
            ),
            const SizedBox(height: 10),
            // Botão para Favoritos
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritesPage()),
                );
              },
              child: const Text("Favoritos"),
            ),
          ],
        ),
      ),
    );
  }
}
