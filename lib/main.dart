import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'utils/utils.dart';
import 'view/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SDHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            onSecondary: Colors.indigoAccent,
            seedColor: NeumorphicColors.embossMaxWhiteColor),
        useMaterial3: true,
      ),
      home: auth.currentUser != null ? const HomeScreen() : const AuthScreen(),
    );
  }
}
