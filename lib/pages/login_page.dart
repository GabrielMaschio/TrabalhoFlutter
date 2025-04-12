import 'package:flutter/material.dart';
import 'package:myapp/pages/main_page.dart';
import 'package:myapp/pages/singup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true, _senhaIsFocused = false, _emailIsFocused = false;
  FocusNode _senhaFocusNode = FocusNode(), _emailFocusNode = FocusNode();
  TextEditingController _emailController = TextEditingController(), _senhaController = TextEditingController();

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
  }

  @override
  void dispose() {
    _senhaFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Container(
          width: double.infinity,
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                      text: "Login",
                      style: TextStyle(
                        color: Colors.purple[800], // Altere para a cor desejada
                      ),
                    ),
                  ],
                ),
            ),

            Text(
                "Preencha os campos abaixo para acessar sua conta!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                )
            ),

              Container(
                margin: EdgeInsets.only(top: 30, left: 30, right: 30),

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
                        controller: _emailController,
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
                margin: EdgeInsets.only(bottom: 20, left: 30, right: 30),
                
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
                        controller: _senhaController,
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
                    if(_emailController.text.trim() == "gabriel@gmail.com" && _senhaController.text.trim() == "123456") {
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(builder: (context) => MainPage())
                          );
                      } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text(
                                "Erro ao efetuar o login",
                                
                              )
                            ),
                          );
                      }
                    
                  },
                    style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.infinity,  50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    backgroundColor: Colors.purple[800], 
                    foregroundColor: Colors.white, 
                  ),
                  child: Text('Entrar'),
                ),
              ),
              
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30),

                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => SingupPage())
                    );
                  },
                  child: Text(
                    "Não possui uma conta? Cadastre-se",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ) 
        ),
      ),
    );
  }
}

class SignUpPage {
}