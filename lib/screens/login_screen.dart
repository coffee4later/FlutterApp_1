import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/email_auth.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final EmailAuth emailAuth = EmailAuth();

  @override
  Widget build(BuildContext context) {
    final txtUser = TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Usuario',
        border: OutlineInputBorder(),
      ),
    );

    final txtPwd = TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        border: OutlineInputBorder(),
      ),
    );

    final btnLogin = InkWell(
      onTap: () async {
        setState(() => isLoading = true);

        try {
          final user = await emailAuth.signIn(
            _emailController.text.trim(),
            _passwordController.text,
          );

          if (user != null) {
            Navigator.pushReplacementNamed(context, "/dashboard");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error al iniciar sesión. Verifica tus credenciales y asegúrate de haber verificado tu correo electrónico.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al iniciar sesión: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        } finally {
          setState(() => isLoading = false);
        }

        print('Login button tapped');
      },
      child: Lottie.asset('assets/submit-button.json', width: 55, height: 55),
    );

    final btnSignup = TextButton(
      onPressed: () {
        Navigator.pushNamed(context, "/signup");
      },
      child: Text('¿No tienes cuenta? Regístrate'),
    );

    final imgLoading = isLoading
        ? Positioned(
            top: 350,
            child: Image.asset('assets/loading.gif', width: 35, height: 35),
          )
        : Container();

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
                    btnSignup,
                  ],
                ),
              ),
            ),
            imgLoading,
          ],
        ),
      ),
    );
  }
}
