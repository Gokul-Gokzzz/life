import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lifelinekerala/service/api_service.dart';
import 'package:lifelinekerala/service/store_service.dart';
import 'package:lifelinekerala/view/bottom_bar/bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();
  final StoreService _storeService = StoreService();

  bool _isLoading = false;
  bool signInObscureText = true;

  void signInObscureChange() {
    setState(() {
      signInObscureText = !signInObscureText;
    });
  }

  Future<void> _attemptLogin() async {
    setState(() {
      _isLoading = true;
    });

    String username = usernameController.text;
    String password = passwordController.text;
    log('name${username}');
    log('pass${password}');
    final loginResponse = await _apiService.login(username, password);
    log('response${loginResponse}');
    setState(() {
      _isLoading = false;
    });

    if (loginResponse != null) {
      // Store user credentials
      await _storeService.setKeys('username', username);
      await _storeService.setKeys('password', password);

      // Update device token on login
      await _apiService.updateDeviceToken(username);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottombarScreens(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed, please try again')),
      );
    }
  }

  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms & Conditions'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1) ഈ പ്രസ്ഥാനം ഒരു പരസ്പര സഹായ കൂട്ടായ്മയാണ്. ഈ കൂട്ടായ്മ ബിസിനസ്സിനോ ഏതെങ്കിലും ജാതിയുടെയോ മതത്തിന്റെയോ രാഷ്ട്രീയത്തിന്റെയോ കീഴിൽ വരുന്ന സംരംഭമോ അല്ല.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '2) ട്രസ്റ്റിന്റെ ആസ്ഥാനം4/6 ചേലാട്ട് വീട്ടിൽ, ജനഹിത ബീച്ച് റോഡ്, പള്ളി പോർട്ട് പി.ഒ. വൈപ്പിൻ, കൊച്ചിൻ, എറണാകുളം, കേരള pin 683515 എന്ന മേൽവിലാസത്തിൽ ആയിരിക്കും. ട്രസ്റ്റിന്റെ പ്രവർത്തനപരിധി കേരളം മുഴുവനായിരിക്കും. Off phone no 9544554497',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '3) അംഗങ്ങളുടെ ഭവനങ്ങളിൽ ഉണ്ടാകുന്ന മരണം വിവാഹം ചികിത്സ എന്നീ ആവശ്യങ്ങൾക്ക് പരസ്പര സഹായത്തോടെ ധനസഹായം നൽകുക എന്ന ആശയമാണ് ഈ കൂട്ടായ്മ കൊണ്ട് ഉദ്ദേശിക്കുന്നത് ആയതിലേക്കാണ് എല്ലാ മാസവും അംഗങ്ങളിൽ നിന്നും 100 രൂപ മാസവരിയായി സ്വീകരിക്കുന്നത്. അംഗങ്ങളായി ചേർന്നു കഴിഞ്ഞ് ഓരോ കുടുംബങ്ങളും എല്ലാ മാസവും 100 രൂപ വച്ച് മാസവരി സംഖ്യ അടക്കേണ്ടതാണ് അംഗങ്ങൾ അടയ്ക്കുന്ന മാസവരി സംഖ്യകൾ മുഴുവനും തന്നെ ഈ കൂട്ടായ്മയിലെ എല്ലാ അംഗങ്ങളുടെ വീടുകളിൽ ഉണ്ടാകുന്ന മരണം വിവാഹം ചികിത്സാ എന്നീ ആവശ്യങ്ങൾക്കു തന്നെയാണ് നൽകുന്നത്തി ആയതിനാൽ അംഗങ്ങൾ അടയ്ക്കുന്ന മാസവരി സംഖ്യകൾ അംഗങ്ങൾക്ക് തിരികെ ലഭിക്കുന്നതല്ല.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '4) അംഗങ്ങളായി ചേർന്നുകഴിഞ്ഞ് ആറുമാസ കാലാവധിക്ക് ശേഷം മാത്രമേ അംഗങ്ങൾക്ക് ധനസഹായ ആനുകൂല്യങ്ങൾക്ക് അർഹത ഉണ്ടായിരിക്കുകയുള്ളൂ.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '5) അംഗങ്ങൾ മൂന്നുതവണ ( മൂന്നുമാസം ) തുടർച്ചയായി പ്രതിമാസം 100 രൂപ വച്ച് മാസവരി സംഖ്യ അടക്കാതെ വീഴ്ചവരുത്തിയാൽ ആ അംഗം സ്വയം ഒഴിഞ്ഞു പോയതായി കണക്കാക്കുകയും ആ അംഗത്തിന് അതിനാൽ തന്നെ അംഗത്വം നഷ്ടപ്പെടുന്നതും ട്രസ്റ്റിൽ നിന്നും യാതൊരുവിധ ധനസഹായവും പിന്നീട് ലഭിക്കുവാൻ അർഹത ഇല്ലാതാവുന്നതും ആകുന്നു തുടർന്ന് ആ അംഗത്തിന് വീണ്ടും അംഗത്വം എടുക്കുവാൻ ആഗ്രഹിക്കുന്നുവെങ്കിൽ ട്രസ്റ്റിന് വീണ്ടും അപേക്ഷ സമർപ്പിക്കേണ്ടതാണ് ട്രസ്റ്റ് കമ്മിറ്റി കൂടി തീരുമാനിച്ചശേഷം മാത്രമായിരിക്കും പ്രസ്തുത അംഗത്തിനെ വീണ്ടും ചേർക്കുന്നതിന് അംഗീകാരം നൽകുക. അങ്ങനെ വീണ്ടും അംഗത്വം എടുക്കുന്നവർക്ക് ഏതൊരു പുതിയ അംഗത്തെയും പോലെ തന്നെ ആറുമാസ കാലാവധിക്ക് ശേഷം മാത്രമേ ധന സഹായങ്ങൾക്ക് അർഹതയുണ്ടായിരിക്കുകയുള്ളൂ.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '6) അംഗങ്ങളുടെ കുടുംബങ്ങളിൽ വരുന്ന മരണം ചികിത്സ എന്നിവ ട്രസ്റ്റിന്റെ ഭരണസമിതിയെ യാഥാസമയം രേഖാമൂലം അറിയിക്കേണ്ടതും വിവാഹം ഒരു മാസം മുൻപേ അറിയിക്കേണ്ടതുമാണ്.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '7) ഈ കൂട്ടായ്മയിൽ അംഗങ്ങൾ കൂടുന്നതനുസരിച്ച് ചില മാസങ്ങളിൽ ആവശ്യങ്ങൾ കൂടുതൽ വരുവാൻ സാധ്യത ഉള്ളതാണ്, അങ്ങനെ ആവശ്യങ്ങൾ കൂടുതൽ വരുന്ന മാസങ്ങളിൽ ശേഖരിക്കപ്പെടുന്ന തുകയേക്കാൾ കൂടുതൽ ആയി ആവശ്യങ്ങൾ വന്നാൽ സീനിയോറിറ്റി ലിസ്റ്റ് പ്രകാരം ധനസഹായം ലഭിക്കുന്നതും ആയതിലേക്ക് വരുന്ന കാലതാമസങ്ങൾക്ക് അംഗങ്ങൾ സഹകരിക്കേണ്ടതുമാണ്.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '8) ഈ കൂട്ടായ്മയിലെ എല്ലാ അംഗങ്ങളുടെയും കുടുംബങ്ങളിലേക്ക് നൽകുന്ന ധനസഹായ തുകകൾ തുടക്കത്തിൽ മരണങ്ങൾക്ക് (10000) പതിനായിരവും, വിവാഹങ്ങൾക്ക് (15000) പതിനയ്യായിരവും, ചികിത്സയ്ക്ക് (മൂന്നു ലക്ഷത്തിൽ കൂടുതൽ ചിലവ് വരുന്ന ചികിത്സ ചിലവുകൾക്ക് മാത്രം (10000) പതിനായിരം രൂപയും ആയിരിക്കും. കാലക്രമേണ അംഗങ്ങൾ ആയിരം 1500 2000 200500 എന്ന് തോതിൽ കൂടുന്നതനുസരിച്ച് ഓരോ ആവശ്യങ്ങൾക്കും നൽകുന്ന ധനസഹായത്തുക ഓരോ മാസങ്ങളിലും ഉണ്ടാകുന്ന ആവശ്യങ്ങൾ എത്രയുണ്ടെന്നു (കൂടുതലോ, കുറവോ എന്ന് നോക്കി കണക്കാക്കി ബോർഡ് ഓഫ് ട്രസ്റ്റീസ് യോഗം ചേർന്ന് യഥാകാലം കൂട്ടിയോ,കുറച്ചോ പുതുക്കി നിശ്ചയിക്കുന്നതായിരിക്കും.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '9) എല്ലാ മാസവും, പദ്ധതിയിൽ ചേരുന്ന അംഗങ്ങളുടെ എണ്ണം, ലഭിക്കുന്നതും, നൽകുന്നതുമായ ധന സഹായ തുക വിവരങ്ങൾ, ബാങ്ക് അക്കൗണ്ട് വിവരങ്ങൾ, കൂടാതെ എല്ലാ കണക്കുകളും എല്ലാ വർഷവും ഓഡിറ്റ് നടത്തുന്നതും വിശദാംശങ്ങൾ എല്ലാം തന്നെ സുതാര്യമായി എല്ലാ അംഗങ്ങളും അടങ്ങിയ വാട്സപ്പ് കൂട്ടായ്മയിൽ പ്രസിദ്ധീകരിക്കുന്നതുമാണ്.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                '10) ഇതിലെ അംഗങ്ങൾ മരണപ്പെട്ടാൽ നോമിനി ആയി വെച്ചിരിക്കുന്നവർക്ക് അംഗത്വം തുടരാവുന്നതാണ്.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'സത്യവാങ്മൂലം ലൈഫ് ലൈൻ കേരള ട്രസ്റ്റ് നടപ്പാക്കുന്ന പദ്ധതിയിൽ അംഗത്വത്തിന് അപേക്ഷിക്കുന്ന ഞാൻ മേൽപ്പറഞ്ഞ നിബന്ധനകളും വ്യവസ്ഥകളും വായിച്ച് മനസ്സിലാക്കി അംഗീകരിക്കുന്നു ഇപ്പോൾ . നിലവിൽ ഇരിക്കുന്നതും മേലാൽ ബോർഡ് ഓഫ് ട്രസ്റ്റ് തീരുമാനിക്കുന്നതുമായ എല്ലാ നിബന്ധനകളും വ്യവസ്ഥകളും അനുസരിച്ച് വർത്തിക്കുന്നതിന് എനിക്ക് പൂർണ സമ്മതമാണ്.കുടുംബ ലിസ്റ്റിൽ ചേർത്തിട്ടുള്ള കാര്യങ്ങൾ എല്ലാം സത്യമാകുന്നു തീയതി പേര് ഒപ്പ്',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/logo.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    prefixIcon: Icon(Icons.email_outlined),
                    suffixIcon: Icon(Icons.check_circle_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter User Name";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: signInObscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: signInObscureChange,
                      icon: Icon(
                        signInObscureText
                            ? Icons.visibility_off
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Password";
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(300, 50),
                      ),
                      onPressed: () async {
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => BottombarScreens(),
                        //   ),
                        // );
                        if (formKey.currentState!.validate()) {
                          try {
                            await _attemptLogin();
                          } catch (e) {
                            log("validation error:${e}");
                          }
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don’t have an account? ',
                    style: TextStyle(fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                          'https://lifelinekeralatrust.com/member/auth/register');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                        log('URL opened: $url');
                      } else {
                        log('Could not launch URL');
                      }
                    },
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'By signing up, you agree with our ',
                    style: TextStyle(fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () => _showTermsAndConditions(context),
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
