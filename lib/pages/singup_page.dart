import 'package:flutter/material.dart';
import 'package:myapp/pages/login_page.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  bool _obscureText = true, _senhaIsFocused = false, _emailIsFocused = false, _nomeIsFocused = false;
  FocusNode _senhaFocusNode = FocusNode(), _emailFocusNode = FocusNode(), _nomeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _senhaFocusNode.addListener(() {
      setState(() {
        _senhaIsFocused = _senhaFocusNode.hasFocus;
      });
    });

    _emailFocusNode.addListener(() {
      setState(() {
        _emailIsFocused = _emailFocusNode.hasFocus;
      });
    });

    _nomeFocusNode.addListener(() {
      setState(() {
        _nomeIsFocused = _nomeFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _senhaFocusNode.dispose();
    _emailFocusNode.dispose();
    _nomeFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: "Bem vindo ao ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                children: [
                  TextSpan(
                    text: "Cadastro",
                    style: TextStyle(
                      color: Colors.purple[800],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Preencha os campos abaixo para criar sua conta!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),

              Container(
                margin: EdgeInsets.only(top: 30, left: 30, right: 30),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nome Completo",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      height: 35,
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        focusNode: _nomeFocusNode,
                        decoration: InputDecoration(
                          hintText: _nomeIsFocused ? "" : "Nome do Usuário",
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          suffixIcon: Icon(
                            Icons.person, 
                            color: Colors.grey, 
                            size: 18
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 30),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "E-mail",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      height: 35,
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        focusNode: _emailFocusNode,
                        decoration: InputDecoration(
                          hintText: _emailIsFocused ? "" : "user@email.com",
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          suffixIcon: Icon(
                            Icons.email, 
                            color: Colors.grey, 
                            size: 18
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              Container(
                margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Senha",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                
                    Container(
                      width: double.infinity,
                      height: 35,
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        focusNode: _senhaFocusNode,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                        hintText: _senhaIsFocused ? "" : "********",
                        isDense: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                            size: 18,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30),

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => LoginPage())
                    );
                  },
                    style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.infinity,  50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    backgroundColor: Colors.purple[800], 
                    foregroundColor: Colors.white, 
                  ),
                  child: Text('Criar Conta'),
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30),

                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => LoginPage())
                    );
                  },
                  child: Text(
                    "Já possui uma conta? Entre aqui!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ) 
          )
          
        )
      )
    )
    );
  }
}