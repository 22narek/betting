import 'package:betting/provider/bet_logic.dart';
import 'package:betting/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeProvider(),
    ),
  );
}

class ChangeProvider extends StatelessWidget {
  const ChangeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => BetLogic()),
        ),
      ],
      child: const HomePage(),
    );
  }
}
