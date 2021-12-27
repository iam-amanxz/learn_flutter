import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/auth_service.dart';
import 'package:learn_flutter/home_scree.dart';
import 'package:learn_flutter/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      Provider<AuthService>(
        create: (_) => AuthService(),
      ),
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: ('/'),
        routes: {
          '/': (context) => const AuthenticationGate(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        }),
  ));
}

class AuthenticationGate extends StatelessWidget {
  const AuthenticationGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
