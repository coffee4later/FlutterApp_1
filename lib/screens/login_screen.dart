import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final txtUser = TextField(
      decoration: InputDecoration(
        labelText: 'Usuario',
        border: OutlineInputBorder(),
      ),
    );

    final txtPwd = TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        border: OutlineInputBorder(),
      ),
    );

    final btnLogin = InkWell(
      onTap: () {
        isLoading = true;
        setState(() {});
        Future.delayed(Duration(seconds:4), () {
          print('Login animation completed');
          Navigator.pushNamed(context, "/dashboard");
        });
        print('Login button tapped');
        
      },
      child: Lottie.asset('assets/submit-button.json', width: 55, height: 55),
    );

    final imgLoading = isLoading ? Positioned(
      top:350,
      child: Image.asset('assets/loading.gif', width: 35, height: 35)
      ) : Container();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 200,
              child: SizedBox(
                width: 300,
                child: Text(
                  'Bienvenido a la aplicación',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              child: Container(
                width: 300,
                height: 240,
                padding: EdgeInsets.all(12),
                color: const Color.fromARGB(164, 255, 255, 255),

                child: ListView(
                  shrinkWrap: true,
                  children: [
                    txtUser,
                    SizedBox(height: 16),
                    txtPwd,
                    Divider(color: Colors.blueAccent, thickness: 3, height: 16),
                    btnLogin,
                    
                  ],
                ),
              ),
            ),
            imgLoading
          ],
        ),
      ),
    );
  }
}
