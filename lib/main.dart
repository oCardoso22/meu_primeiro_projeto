import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation com TabBar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Module1Screen(),
    Module2Screen(), // Este terá a TabBar
    Module3Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Módulo 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Módulo 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Módulo 3',
          ),
        ],
      ),
    );
  }
}

// Módulo 1 - Tela simples
class Module1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Módulo 1',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// Módulo 2 - Com TabBar aninhada
class Module2Screen extends StatefulWidget {
  @override
  _Module2ScreenState createState() => _Module2ScreenState();
}

class _Module2ScreenState extends State<Module2Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo 2'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.list),
              text: 'Lista',
            ),
            Tab(
              icon: Icon(Icons.grid_view),
              text: 'Grid',
            ),
            Tab(
              icon: Icon(Icons.info),
              text: 'Info',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Tab1Content(),
          Tab2Content(),
          Tab3Content(),
        ],
      ),
    );
  }
}

// Conteúdo da Tab 1
class Tab1Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.list_alt),
          title: Text('Item da Lista ${index + 1}'),
          subtitle: Text('Descrição do item ${index + 1}'),
          trailing: Icon(Icons.arrow_forward_ios),
        );
      },
    );
  }
}

// Conteúdo da Tab 2
class Tab2Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.grid_view,
                size: 50,
                color: Colors.blue,
              ),
              SizedBox(height: 8),
              Text(
                'Item ${index + 1}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Conteúdo da Tab 3
class Tab3Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'Informações Gerais',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Esta é a aba de informações do Módulo 2.'),
                  SizedBox(height: 8),
                  Text('Aqui você pode exibir detalhes importantes.'),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: Icon(Icons.star, color: Colors.amber),
              title: Text('Funcionalidade Premium'),
              subtitle: Text('Acesso a recursos avançados'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.notifications, color: Colors.green),
              title: Text('Notificações'),
              subtitle: Text('Receber alertas importantes'),
              trailing: Switch(
                value: false,
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Módulo 3 - Tela simples
class Module3Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo 3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              'Módulo 3',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('Configurações e ajustes'),
          ],
        ),
      ),
    );
  }
}