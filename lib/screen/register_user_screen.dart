import 'package:flutter/material.dart';
import 'package:marketplace/providers/login_form_provider.dart';
import 'package:marketplace/services/auth_service.dart';
import 'package:marketplace/ui/input_decortions.dart';
import 'package:marketplace/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 150),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text('Registra una cuenta'),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (context) => LoginFormProvider(),
                      child: const RegisterForm(),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.transparent),
                        overlayColor: WidgetStateProperty.all(Colors.indigo.withOpacity(0.1)),
                        shape: WidgetStateProperty.all(const StadiumBorder())
                      ),
                      child: const Text('Si ya tienes una cuenta, ingresa!'),
                    ),
                  ]
                )
              )
            ],
          ),
        )
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: LoginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecortions.authInputDecoration(
              hinText: 'Ingrese su correo',
              labelText: 'Email',
              prefixIcon: Icons.people,
            ),
            onChanged: (value) => LoginForm.email = value,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'El usuario no puede estar vacio';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecortions.authInputDecoration(
              hinText: '************',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => LoginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'La contraseña no puede estar vacio';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: Colors.indigo.shade400,
            elevation: 0,
            onPressed: LoginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!LoginForm.isValidForm()) return;
                    LoginForm.isLoading = true;
                    final String? errorMessage = await authService.createUser(
                        LoginForm.email, LoginForm.password);
                    if (errorMessage == null) {
                      Navigator.pushNamed(context, 'login');
                    } else {
                      print(errorMessage);
                    }
                    LoginForm.isLoading = false;
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: const Text(
                'Registrar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ]),
      ),
    );
  }
}