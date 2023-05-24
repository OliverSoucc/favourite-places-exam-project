import 'package:flutter/material.dart';
import 'package:native_device_features/screens/places.dart';

import '../services/app_services.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameCotroller = TextEditingController();
  bool createUser = false;

  void _logIn() {
    final enteredEmail = _emailController.text;
    final enteredPassword = _emailController.text;

    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      return;
    }

    AppServices.logIn(enteredPassword, enteredEmail).then(
      (userId) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PlacesScreen(
            signedUser: userId,
          ),
        ),
      ),
    );
  }

  void _createAccount() async {
    final enteredEmail = _emailController.text;
    final enteredPassword = _emailController.text;
    final enteredUserName = _userNameCotroller.text;

    if (enteredEmail.isEmpty ||
        enteredPassword.isEmpty ||
        enteredUserName.isEmpty) {
      return;
    }

    await AppServices.createAccount(
            enteredUserName, enteredPassword, enteredEmail)
        .then(
      (userId) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PlacesScreen(signedUser: userId),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameCotroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget userNameField = createUser
        ? TextField(
            decoration: const InputDecoration(labelText: 'User Name'),
            controller: _userNameCotroller,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          )
        : Container();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sing in'),
        actions: [
          TextButton(
            onPressed: () => setState(() {
              createUser = true;
            }),
            child: const Text('Create profile'),
          ),
          TextButton(
            onPressed: () => setState(() {
              createUser = false;
            }),
            child: const Text('Log in'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 35),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              controller: _emailController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              controller: _passwordController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            userNameField,
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: createUser ? _createAccount : _logIn,
              child: Text(createUser ? 'Create Profile' : 'Log in'),
            )
          ],
        ),
      ),
    );
  }
}
