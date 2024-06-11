import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final String username;
  const ForgetPasswordScreen({super.key, required this.username});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController usernameController;
  late TextEditingController dateController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController = TextEditingController();

    usernameController = TextEditingController(text: widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Username',
                )),
            TextFormField(
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              controller: dateController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.date_range_outlined),
                labelText: 'Date of Birth',
                suffixIcon: IconButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      dateController.text =
                          DateFormat('dd-MMM-yyyy').format(date);
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                ),
              ),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.edit_document),
                labelText: 'Pan Number',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              //title: Text('Verification'),
                              content: SizedBox(
                                height: 350,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Text('Verification'),

                                    Image.asset(
                                      'assets/done.png',
                                      width: 200,
                                      height: 200,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Congratulations!",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Center(
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          'An email has been sent to your registered email address. Please check your email and follow the instructions to reset your password.'),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'))
                              ],
                            );
                          });
                      // showAboutDialog(
                      //   context: context,
                      //   applicationIcon: Icon(Icons.person),
                      // );
                    },
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15.0)))),
                    child: const Text('Verify')))
          ])),
    );
  }
}
