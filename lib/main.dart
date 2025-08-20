import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Rotas Privadas',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/perfil': (context) => PerfilScreen(),
        '/detalhes': (context) => DetalhesScreen(),
      },
    );
  }
}

bool isLoggedIn = false;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      return LoginScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              isLoggedIn = false;
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bem-vindo à Home!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/perfil'),
              child: Text('Ir para Perfil'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/detalhes', arguments: {
                  'nome': 'Rodrigo Silva Santos',
                  'nascimento': '18/10/2004',
                  'telefone': '(55) 99999-9999'
                });
              },
              child: Text('Ver Detalhes do Usuário'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Login com credenciais específicas OU qualquer coisa preenchida
                if (emailController.text.isNotEmpty && senhaController.text.isNotEmpty) {
                  isLoggedIn = true;
                  Navigator.pushNamed(context, '/');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencha email e senha')),
                  );
                }
              },
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      return LoginScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              isLoggedIn = false;
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100),
            Text('Meu Perfil', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Email: usuario@exemplo.com'),
            Text('Telefone: (55) 99999-9999'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/'),
              child: Text('Voltar para Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetalhesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      return LoginScreen();
    }

    final Map<String, String> dados =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>? ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Usuário'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              isLoggedIn = false;
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Detalhes do Usuário', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Nome: ${dados['nome'] ?? 'Não informado'}'),
            Text('Data de Nascimento: ${dados['nascimento'] ?? 'Não informado'}'),
            Text('Telefone: ${dados['telefone'] ?? 'Não informado'}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}