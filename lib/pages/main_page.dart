import 'package:flutter/material.dart';
import 'package:myapp/data/user.dart';
import 'package:myapp/my_flutter_app_icons.dart';
import 'package:myapp/pages/busca_cep_page.dart';
import 'package:myapp/pages/dados_cadastrais_page.dart';
import 'package:myapp/pages/login_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Pagina Principal',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          centerTitle: true,
        ),

        drawer: Drawer(
          backgroundColor: Colors.grey[50],
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    buildHeader(
                      context,
                      name: name,
                      email: email,
                      urlImage: urlImage,
                    ),
                    SizedBox(height: 20),
                    Divider(height: 1),
                    SizedBox(height: 20),
                    buildMenuItem(
                      context,
                      page: (context) => MainPage(),
                      text: "Tela Inicial",
                      icon: Icons.home_rounded
                    ),
                    SizedBox(height: 10),
                    buildMenuItem(
                      context,
                      page: (context) => DadosCadastraisPage(),
                      text: "Dados Cadastrais",
                      icon: Icons.person
                    ),
                    SizedBox(height: 10),
                    buildMenuItem(
                      context,
                      page: (context) => BuscaCep(),
                      text: "Bucas CEP",
                      icon: Icons.map
                    ),
                    SizedBox(height: 10),
                    buildMenuItem(
                      context,
                      page: (context) => DadosCadastraisPage(),
                      text: "Configurações",
                      icon: Icons.settings
                    ),
                    SizedBox(height: 10),
                    buildMenuItem(
                      context,
                      page: (context) => DadosCadastraisPage(),
                      text: "Termos de Uso e Política de Privacidade",
                      icon: Icons.privacy_tip
                    ),
                  ],
                ),
                Column(
                  children: [
                    Divider(height: 1, thickness: 1),
                    buildMenuItem(
                      context,
                      page: (context) => LoginPage(),
                      text: "Sair",
                      icon: MyFlutterApp.logout,
                      alignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(
  BuildContext context, {
  required WidgetBuilder page,
  required String text,
  required IconData icon,
  MainAxisAlignment alignment = MainAxisAlignment.start,
}) {
  // Verifica se o alinhamento é central
  bool isCentered = alignment == MainAxisAlignment.center;
  
  return Material(
    color: Colors.transparent,
    child: Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page(context)),
          ),
          title: Row(
            mainAxisAlignment: alignment,
            children: [
              Icon(icon, color: Colors.black, size: 22),
              SizedBox(width: 12),
              isCentered
                  ? Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    )
                  : Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget buildHeader(
    BuildContext context, {
    required String urlImage,
    required String name,
    required String email,
  }) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 16)),
              CircleAvatar(
                radius: 24, 
                backgroundImage: NetworkImage(urlImage),
                backgroundColor: Colors.black12,
              ),
              SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Olá,",
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    name,
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}