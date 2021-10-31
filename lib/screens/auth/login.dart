import 'package:flutter/material.dart';
import 'package:e_commerce_app/services/global_method.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);
  static const routeName = '/LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _passwordFocusNode = FocusNode();
   final FirebaseAuth _auth = FirebaseAuth.instance;
   final GlobalMethods _globalMethods = GlobalMethods();
  bool _obscureText = true;

  bool _isLoading = false;

  String? _emailAddress = '';

  String? _password = '';

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _passwordFocusNode.dispose();
  }
   void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: _emailAddress!.toLowerCase().trim(),
                password: _password!.trim())
            .then((value) =>
                Navigator.pushNamedAndRemoveUntil(context, 'HomeScreen', (Route<dynamic> route) => false));
      } catch (error) {
        _globalMethods.authErrorHandle(error.toString(), context);
        print('error occured ${error.toString()}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
                  margin:const EdgeInsets.only(top: 80),
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    //  color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    
                    shape: BoxShape.rectangle,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: const ValueKey('email'),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: const Icon(Icons.email),
                                labelText: 'Email Address',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _emailAddress = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: const ValueKey('Password'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Please enter a valid Password';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _passwordFocusNode,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon:const Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                labelText: 'Password',
                                fillColor: Theme.of(context).backgroundColor),
                            onSaved: (value) {
                              _password = value!;
                            },
                            obscureText: _obscureText,
                            onEditingComplete: _submitForm,
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //         vertical: 2, horizontal: 20),
                        //     child: TextButton(
                        //         onPressed: () {
                        //           Navigator.pushNamed(
                        //               context, ForgetPassword.routeName);
                        //         },
                        //         child: Text(
                        //           'Forget password?',
                        //           style: TextStyle(
                        //               color: Colors.blue.shade900,
                        //               decoration: TextDecoration.underline),
                        //         )),
                        //   ),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                           const SizedBox(width: 10),
                            _isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: const BorderSide(
                                            color:Color(0xFFabcdef)),
                                      ),
                                    )),
                                    onPressed:_submitForm,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children:const [
                                        Text(
                                          'Login',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.verified_user,
                                          size: 18,
                                        )
                                      ],
                                    )),
                            const SizedBox(width: 20),
                            _isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: const BorderSide(
                                            color:Color(0xFFabcdef)),
                                      ),
                                    )),
                                    onPressed: (){},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children:const [
                                        Text(
                                          'Login as Guest',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.login,
                                          size: 18,
                                        )
                                      ],
                                    )),
                            const SizedBox(width: 20),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                    onPressed: (){
                                      Navigator.pushNamedAndRemoveUntil(context, 'SignUpScreen', (Route<dynamic>route) => false);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children:const [
                                        Text(
                                          'New here? Sign Up',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.app_registration_sharp,
                                          size: 18,
                                        )
                                      ],
                                    )),
                          ],
                        ),
                      ],
                    ))
        ],
      ),
      
    );
  }
}