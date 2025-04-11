import 'package:flutter/material.dart';
import 'package:flutter_ssl_pinning/network/user_repository.dart';

import 'model/user_response_dm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SSL Pinning Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;

  late final UserRepository userRepository;

  List<UserResponseDm> userResponse = [];

  @override
  void initState() {
    super.initState();
    userRepository = UserRepository(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      certPath: 'assets/typicode.com.pem',
    );
  }

  void getUsers() async {
    setState(() {
      isLoading = true;
    });

    final result = await userRepository.getUserData(
      endpoint: '/users',
    );
    if (result != null) {
      for (final user in result) {
        userResponse.add(UserResponseDm.fromJson(user));
      }
    } else {
      debugPrint('No data found');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemCount: userResponse.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(userResponse[index].name),
                    subtitle: Text(userResponse[index].email),
                    contentPadding: const EdgeInsets.all(8.0),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: getUsers,
          child: const Icon(Icons.get_app),
        ),
      ),
    );
  }
}
