import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/modules/home/controllers/form_controller.dart';
import '../app/modules/home/controllers/home_controller.dart';
import '../app/modules/home/model/form.dart';

class linput extends StatefulWidget {
  const linput({Key? key}) : super(key: key);

  @override
  _linputState createState() => _linputState();
}

class _linputState extends State<linput> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final user = Get.find<HomeController>();
  late final isLoggedin = user.email.isNotEmpty;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController kesulitanController = TextEditingController();
  final TextEditingController nilaiController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, proceed.
      FeedbackForm feedbackForm = FeedbackForm(
        DateTime.now(), // Timestamp saat ini
        emailController.text,
        nameController.text,
        nimController.text,
        linkController.text,
        kesulitanController.text,
        nilaiController.text,
      );

      FormController formController = FormController();

      _showSnackbar("Submitting Feedback");

      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          _showSnackbar("Feedback Submitted");
        } else {
          _showSnackbar("Error Occurred!");
        }
      });
    }
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Silahkan input'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (!(value?.contains("@") ?? false)) {
                          return 'Enter Valid Email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter Valid Name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    TextFormField(
                      controller: nimController,
                      validator: (value) {
                        if ((value?.trim().length ?? 0) != 13) {
                          return 'Enter 13 Digit NIM';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nomor Induk Mahasiswa (NIM)',
                      ),
                    ),
                    TextFormField(
                      controller: linkController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter Valid Alamat';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      decoration:
                          const InputDecoration(labelText: 'Alamat'),
                    ),
                    TextFormField(
                      controller: kesulitanController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter Valid No Telepon';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(labelText: 'No Telepon'),
                    ),
                    TextFormField(
                      controller: nilaiController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter Valid Jurusan';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(labelText: 'Jurusan'),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed: _submitForm,
              child: const Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}

class scroll extends StatelessWidget {
  const scroll({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 350 * 0.7,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.title,
    required this.path,
    required this.status,
  });

  final String title;
  final String path;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: Image.asset(
            "assets/icons/$path.png",
            fit: BoxFit.contain,
          ),
        ),
        Text(
          title,
          style:
              TextStyle(color: (status == true) ? Colors.black : Colors.grey),
        ),
      ],
    );
  }
}

class StatusCard extends StatelessWidget {
  const StatusCard({
    Key? key,
    required this.title,
    required this.data,
    required this.satuan,
  }) : super(key: key);
  final String title;
  final String data;
  final String satuan;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 350 * 0.3,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            title,
            style: const TextStyle(fontSize: 10),
          ),
          RichText(
            text: TextSpan(
              text: data,
              style: const TextStyle(
                  color: Color(0xFFF37335),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: satuan,
                    style: const TextStyle(fontSize: 10, color: Colors.grey))
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class ClipInfoClass extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);

    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);

    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}