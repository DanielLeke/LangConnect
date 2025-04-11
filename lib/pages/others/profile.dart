import 'package:flutter/material.dart';
import 'package:langconnect/pages/auth_pages/login.dart';
import 'package:langconnect/pages/auth_pages/signup.dart';
import 'package:langconnect/utilities/users_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getUsername(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '''
👋 Hi,
${snapshot.data ?? 'Unknown User'}.
                    ''',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: (){}, 
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Change password",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 1.2
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.blue[900],
                              )
                            ],
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: (){}, 
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Change email",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 1.2
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.blue[900],
                              )
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

Future<String> getUsername() async {
  UsersService _usersService = UsersService();
  String username = await _usersService.getUserInformation(
      email: emailController.text.isNotEmpty
          ? emailController.text
          : loginEmailController.text,
      field: "username");
  return username;
}
