import 'package:bookstore_app/resources/authmethods.dart';
import 'package:bookstore_app/screens/home_screen.dart';
import 'package:bookstore_app/utils/colors.dart';
import 'package:bookstore_app/utils/snackbar.dart';
import 'package:bookstore_app/utils/validator.dart';
import 'package:bookstore_app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _signUpNameEditingController = TextEditingController();
  final _signUpEmailEditingController = TextEditingController();
  final _signUpPasswordEditingController = TextEditingController();
  final _loginEmailEditingController = TextEditingController();
  final _loginPasswordEditingController = TextEditingController();

  bool _isMale = true;
  bool _isSignupScreen = true;
  bool _isRememberMe = false;
  bool _isLoading = false;
  late String gender;

  final _formKeyForSignUp = GlobalKey<FormState>();
  final _formKeyForLogin = GlobalKey<FormState>();

  signUp() async {
    if (_formKeyForSignUp.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String res = await AuthMethods().signUpUser(
          email: _signUpEmailEditingController.text,
          password: _signUpPasswordEditingController.text,
          name: _signUpNameEditingController.text,
          gender: gender);
      setState(() {
        _isLoading = false;
      });
      if (res == "success") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {}
    }
  }

  logInUser() async {
    if (_formKeyForLogin.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String res = await AuthMethods().loginUser(
        email: _loginEmailEditingController.text,
        password: _loginPasswordEditingController.text,
      );
      if (res == "success") {
        SharedPreferences sharedPreference =
            await SharedPreferences.getInstance();
        sharedPreference.setBool("isLoggedIn", true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        showSnackBar(context, res);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfUserIsAlreadyLoggedIn();
  }

  checkIfUserIsAlreadyLoggedIn() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    if (sharedPreference.getBool("isLoggedIn") ?? false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorsPalette.backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              // bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/background_image.jpg'),
                        fit: BoxFit.fill)),
                child: Container(
                  padding: const EdgeInsets.only(top: 90, left: 20),
                  color: const Color(0xFF3b5999).withOpacity(.85),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "Welcome to",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.yellow[700],
                                letterSpacing: 2),
                            children: [
                              TextSpan(
                                  text: _isSignupScreen
                                      ? " BookStore,"
                                      : " Back,",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow[700]))
                            ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        _isSignupScreen
                            ? "SignUp to Continue"
                            : "Sign in to Continue",
                        style: const TextStyle(
                            letterSpacing: 1, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                bottomhalfwidget(true),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.bounceInOut,
                  top: _isSignupScreen ? 200 : 230,
                  right: 0,
                  left: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.bounceInOut,
                    height: _isSignupScreen ? 320 : 270,
                    padding: const EdgeInsets.all(20),
                    width: width < 600
                        ? MediaQuery.of(context).size.width - 40
                        : 500,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5)
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSignupScreen = false;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      "LOGIN",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: _isSignupScreen
                                              ? ColorsPalette.textColor1
                                              : ColorsPalette.activeColor),
                                    ),
                                    if (!_isSignupScreen)
                                      Container(
                                        padding: const EdgeInsets.only(top: 3),
                                        height: 2,
                                        width: 55,
                                        color: Colors.orange,
                                      )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSignupScreen = true;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      "SIGNUP",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: _isSignupScreen
                                              ? ColorsPalette.activeColor
                                              : ColorsPalette.textColor1),
                                    ),
                                    if (_isSignupScreen)
                                      Container(
                                        padding: const EdgeInsets.only(top: 3),
                                        height: 2,
                                        width: 55,
                                        color: Colors.orange,
                                      )
                                  ],
                                ),
                              )
                            ],
                          ),
                          if (_isSignupScreen) signUpSection(),
                          if (!_isSignupScreen) signInScreen()
                        ],
                      ),
                    ),
                  ),
                ),
                bottomhalfwidget(false),
                Positioned(
                    top: MediaQuery.of(context).size.height - 100,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [
                        Text(_isSignupScreen
                            ? "Or SignUp with"
                            : "Or Signin with"),
                        Container(
                          width: width < 600
                              ? MediaQuery.of(context).size.width - 40
                              : 500,
                          margin: const EdgeInsets.only(
                              right: 20, left: 20, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textButtonWidget(MaterialCommunityIcons.facebook,
                                  "Facebook", ColorsPalette.facebookColor),
                              textButtonWidget(MaterialCommunityIcons.google,
                                  "Google", ColorsPalette.googleColor)
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Container signInScreen() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Form(
        key: _formKeyForLogin,
        child: Column(
          children: [
            InputTextField(
              icon: Icons.mail_outline,
              hintText: "info@gmail.com",
              isPassword: false,
              isEmail: true,
              textEditingController: _loginEmailEditingController,
              validation: Validator.validateEmail,
            ),
            InputTextField(
              icon: MaterialCommunityIcons.lock_outline,
              hintText: "************",
              isPassword: true,
              isEmail: false,
              textEditingController: _loginPasswordEditingController,
              validation: Validator.validatePassword,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: _isRememberMe,
                        activeColor: ColorsPalette.textColor2,
                        onChanged: (value) {
                          setState(() {
                            _isRememberMe = !_isRememberMe;
                          });
                        }),
                    const Text(
                      "Remember Me",
                      style: TextStyle(
                          fontSize: 12, color: ColorsPalette.textColor1),
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forget Password",
                      style: TextStyle(
                          fontSize: 12, color: ColorsPalette.textColor1),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Container signUpSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Form(
        key: _formKeyForSignUp,
        child: Column(
          children: [
            InputTextField(
              icon: MaterialCommunityIcons.account_outline,
              hintText: "User Name",
              isPassword: false,
              isEmail: false,
              textEditingController: _signUpNameEditingController,
              validation: Validator.validateName,
            ),
            InputTextField(
              icon: MaterialCommunityIcons.email_outline,
              hintText: "Email",
              isPassword: false,
              isEmail: true,
              textEditingController: _signUpEmailEditingController,
              validation: Validator.validateEmail,
            ),
            InputTextField(
              icon: MaterialCommunityIcons.lock_outline,
              hintText: "Password",
              isPassword: true,
              isEmail: false,
              textEditingController: _signUpPasswordEditingController,
              validation: Validator.validatePassword,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isMale = true;
                        gender = _isMale ? "Male" : "Female";
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              color: _isMale
                                  ? ColorsPalette.textColor2
                                  : Colors.transparent,
                              border: Border.all(
                                  width: 1,
                                  color: _isMale
                                      ? Colors.transparent
                                      : ColorsPalette.textColor1),
                              borderRadius: BorderRadius.circular(15)),
                          child: Icon(
                            MaterialCommunityIcons.account_outline,
                            color: _isMale
                                ? Colors.white
                                : ColorsPalette.iconColor,
                          ),
                        ),
                        const Text(
                          "Male",
                          style: TextStyle(color: ColorsPalette.textColor1),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isMale = false;
                        gender = _isMale ? "Male" : "Female";
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              color: _isMale
                                  ? Colors.transparent
                                  : ColorsPalette.textColor2,
                              border: Border.all(
                                  width: 1,
                                  color: _isMale
                                      ? ColorsPalette.textColor1
                                      : Colors.transparent),
                              borderRadius: BorderRadius.circular(15)),
                          child: Icon(
                            MaterialCommunityIcons.account_outline,
                            color: _isMale
                                ? ColorsPalette.iconColor
                                : Colors.white,
                          ),
                        ),
                        const Text(
                          "Female",
                          style: TextStyle(color: ColorsPalette.textColor1),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextButton textButtonWidget(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          side: const BorderSide(width: 1, color: Colors.grey),
          minimumSize: const Size(145, 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(title)
        ],
      ),
    );
  }

  Widget bottomhalfwidget(bool showShadow) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: _isSignupScreen ? 490 : 470,
      left: (MediaQuery.of(context).size.width - 40) / 2,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.red.shade200, Colors.red.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1))
                      ]),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                          ),
                          color: Colors.white,
                          onPressed: _isSignupScreen ? signUp : logInUser),
                )
              : const Center(),
        ),
      ),
    );
  }
}
