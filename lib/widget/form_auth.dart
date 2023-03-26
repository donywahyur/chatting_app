import 'package:flutter/material.dart';

class FormAuth extends StatefulWidget {
  const FormAuth({super.key, required this.submitForm});

  final Function(String username, String email, String password, bool isLogin)
      submitForm;

  @override
  State<FormAuth> createState() => _FormAuthState();
}

class _FormAuthState extends State<FormAuth> {
  final _form = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  bool _isLogin = true;

  void _trySubmit() {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      widget.submitForm(username, email, password, _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      onSaved: (newValue) {
                        username = newValue!;
                      },
                      decoration: const InputDecoration(labelText: "Username"),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return "Required and at least 4 characters";
                        }
                        return null;
                      },
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: ValueKey('email'),
                    onSaved: (newValue) {
                      email = newValue!;
                    },
                    decoration: const InputDecoration(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return "Invalid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    onSaved: (newValue) {
                      password = newValue!;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Password"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _trySubmit();
                      },
                      child: _isLogin
                          ? const Text("Login")
                          : const Text("Register")),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: _isLogin
                          ? const Text("Create Account")
                          : const Text("Login"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
