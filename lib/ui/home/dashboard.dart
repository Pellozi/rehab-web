import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab_web/ui/home/patient_card.dart';
import 'package:rehab_web/ui/standard_widgets/search_widget.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.63,
          color: Color(0xFFF6F6F6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              TextFieldWidget('Pesquisar paciente'),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PatientCard(
                            color: Color(0xffFF4C60),
                            projectName: 'Marcos da silva',
                            percentComplete: '30%',
                            progressIndicatorColor: Colors.redAccent[100],
                            icon: Icons.person,
                          ),
                          PatientCard(
                            color: Color(0xffFAAA1E),
                            projectName: 'Manoel pereira',
                            percentComplete: '60%',
                            progressIndicatorColor: Colors.blue[200],
                            icon: Icons.person,
                            hasApp: false,
                          ),
                          PatientCard(
                            color: Color(0xffFAAA1E),
                            projectName: 'Manoel pereira',
                            percentComplete: '60%',
                            progressIndicatorColor: Colors.blue[200],
                            icon: Icons.person,
                            hasApp: false,
                          ),
                          PatientCard(
                            color: Color(0xff6C6CE5),
                            projectName: 'Amanda moura',
                            percentComplete: '80%',
                            progressIndicatorColor: Colors.amber[200],
                            icon: Icons.person,
                          ),
                          PatientCard(
                            color: Color(0xff37F142),
                            projectName: 'Tarcisio ramos',
                            percentComplete: '100%',
                            progressIndicatorColor: Colors.green[200],
                            icon: Icons.person,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PatientCard(
                            color: Color(0xffFF4C60),
                            projectName: 'Amelia rosario',
                            percentComplete: '34%',
                            progressIndicatorColor: Colors.redAccent[100],
                            icon: Icons.person,
                          ),
                          PatientCard(
                            color: Color(0xff6C6CE5),
                            projectName: 'Maria',
                            percentComplete: '78%',
                            progressIndicatorColor: Colors.blue[200],
                            icon: Icons.person,
                          ),
                          PatientCard(
                            color: Color(0xffFAAA1E),
                            projectName: 'Manoel pereira',
                            percentComplete: '60%',
                            progressIndicatorColor: Colors.blue[200],
                            icon: Icons.person,
                          ),
                          PatientCard(
                            color: Color(0xffFAAA1E),
                            projectName: 'Ana Paula',
                            percentComplete: '42%',
                            progressIndicatorColor: Colors.amber[200],
                            icon: Icons.person,
                          ),
                          PatientCard(
                            color: Color(0xff37F142),
                            projectName: 'João Victor',
                            percentComplete: '100%',
                            progressIndicatorColor: Colors.green[200],
                            icon: Icons.person,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
