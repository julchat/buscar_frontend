import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyLinkAndTermsOfService extends StatelessWidget{
  const PrivacyPolicyLinkAndTermsOfService({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(10),
    child: Center(
        child: Text.rich(TextSpan(
            text: 'Al presionar "CREAR USUARIO" usted acepta nuestros  ',
            children: <TextSpan>[
          TextSpan(
              text: 'Términos y Condiciones',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                    context: context,
                    builder: ((context) => AlertDialog(
                    scrollable: true,
                    title: const Text('TÉRMINOS Y CONDICIONES'),
                    content: const Column(
                        children: [
                          Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            '1. Aceptación de los Términos y Condiciones',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'Bienvenido a "BuscAR", una aplicación móvil desarrollada por BuscAR, la cual le permite a los usuarios crear cuentas, cargar objetos a través de fotografías y entrenar redes neuronales personalizadas. Al acceder y utilizar nuestra aplicación, usted acepta cumplir y estar sujeto a los siguientes Términos y Condiciones de Uso ("Términos"). Si no está de acuerdo con estos Términos, por favor, absténgase de utilizar nuestra aplicación.',
                        ),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            '2. Registro de Cuenta',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'Para utilizar "BuscAR", usted debe registrarse creando una cuenta. Debe proporcionar información precisa y completa al registrarse, incluyendo un correo electrónico válido y una contraseña segura. Usted es el único responsable de mantener la confidencialidad de su contraseña y de todas las actividades que ocurran en su cuenta. En caso de acceso no autorizado a su cuenta, es su responsabilidad notificar a BuscAR de inmediato.',
                        ),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            '3. Uso del Servicio',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          ' - "BuscAR" permite a los usuarios cargar imágenes de objetos y entrenar redes neuronales personalizadas. El uso de esta funcionalidad está sujeto a las restricciones legales vigentes en la República Argentina.\n'
                          ' - Usted acepta que no cargará contenido que infrinja los derechos de autor, patentes, marcas registradas, secretos comerciales u otros derechos de propiedad intelectual de terceros.\n'
                          ' - Se prohíbe el uso de "BuscAR" para fines ilegales, difamatorios, ofensivos, o que violen la privacidad de otros usuarios.\n'
                          ' - Usted es el único responsable de las imágenes y datos que carga en la aplicación.',
                        ),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            '4. Propiedad Intelectual',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '"BuscAR" y todos los derechos de propiedad intelectual asociados con la aplicación (incluyendo derechos de autor, marcas registradas y patentes) son propiedad exclusiva de BuscAR. Usted no tiene derecho a copiar, modificar, distribuir, transmitir, exhibir, vender, o realizar cualquier otra acción que vulnere estos derechos sin el consentimiento expreso de BuscAR.',
                        ),
                        SizedBox(height: 20.0),
                            SizedBox(height: 20.0),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                '6. Privacidad y Protección de Datos',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Su uso de "BuscAR" está sujeto a nuestra Política de Privacidad, la cual regula la recopilación y el uso de sus datos personales. Al utilizar la aplicación, usted acepta nuestras prácticas de privacidad y el procesamiento de sus datos personales de acuerdo a esta política.',
                            ),

                            SizedBox(height: 20.0),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                '7. Limitación de Responsabilidad',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '"BuscAR" se proporciona "tal cual" y BuscAR no garantiza la precisión, fiabilidad o disponibilidad continua de la aplicación. BuscAR no será responsable por daños directos, indirectos, incidentales, especiales o consecuentes resultantes del uso de la aplicación.',
                            ),

                            SizedBox(height: 20.0),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                '8. Modificaciones y Terminación',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'BuscAR se reserva el derecho de modificar o terminar el servicio "BuscAR" en cualquier momento sin previo aviso. Usted puede dejar de utilizar la aplicación en cualquier momento y eliminar su cuenta.',
                            ),

                            SizedBox(height: 20.0),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                '9. Legislación Aplicable',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Estos Términos se rigen por las leyes de la República Argentina. Cualquier disputa relacionada con estos Términos se resolverá en los tribunales competentes de la República Argentina.',
                            ),

                            SizedBox(height: 20.0),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                '10. Contacto',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Si tiene alguna pregunta o inquietud con respecto a estos Términos y Condiciones de Uso, por favor contáctenos a través de la dirección de correo electrónico: crcali@frba.utn.edu.ar',
                            ),
                          ],
                        ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text('CERRAR VENTANA'))
                      ],)
                    ));
                }),        
        ]
        ),
        textAlign : TextAlign.center,
        style: const TextStyle(fontSize: 20),
        )),
  );
  }
}
