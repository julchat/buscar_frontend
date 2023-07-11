import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

Widget privacyPolicyLinkAndTermsOfService() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(10),
    child: Center(
        child: Text.rich(TextSpan(
            text: 'Al presionar "CREAR USUARIO" usted acepta nuestros  ',
            children: <TextSpan>[
          TextSpan(
              text: 'Términos y Condiciones',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Abrir ventana');
                }),        
        ]
        ),
        textAlign : TextAlign.center,
        style: TextStyle(fontSize: 20),
        )),
  );
}
