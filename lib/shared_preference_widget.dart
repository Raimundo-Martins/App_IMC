import 'package:app_imc/shared_preference_api.dart';
import 'package:flutter/material.dart';

class SharedPreferencesWidget extends StatefulWidget {
  @override
  _SharedPreferencesWidgetState createState() =>
      _SharedPreferencesWidgetState();
}

class _SharedPreferencesWidgetState extends State<SharedPreferencesWidget> {
  TextEditingController _controllerPeso = TextEditingController();
  TextEditingController _controllerAltura = TextEditingController();
  TextEditingController _controllerTexto = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Resultado";

  @override
  void initState() {    
    super.initState();
    _pegaDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16,50,16,16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("IMC", style: TextStyle(fontSize: 60),),
            Divider(),
            TextFormField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
              controller: _controllerPeso,
              validator: (value){
                if(value.isEmpty){
                  return "Insira o peso!";
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Peso (Kg)",
              ),
            ),
            Divider(),
            TextFormField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
              controller: _controllerAltura,
              validator: (value){
                if(value.isEmpty){
                  return "Insira a altura!";
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Altura (Cm)",
              ),
              
            ),
            Divider(),
            RaisedButton(
              child: Text("CALCULAR", style: TextStyle(fontSize: 30),),
              onPressed: () {
                if(_formKey.currentState.validate()){
                  _calcular();
                  _armazenaDados();
                }
              },
            ),
            Divider(),
            Text(_infoText, textAlign: TextAlign.center, style: TextStyle(fontSize: 25),),
          ],   
        ) 
      ),
    );
  }

  void _calcular(){
    setState(() {
      double peso = double.parse(_controllerPeso.text);
      double altura = double.parse(_controllerAltura.text) / 100;
      double imc = peso / (altura * altura);

      if(imc < 18.5){
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 18.5 && imc < 25){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 25 && imc < 30){
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 30 && imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 34.9 && imc < 40){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      }else if(imc >= 40.0){
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  void _armazenaDados() {
    String valorPeso = _controllerPeso.text;
    String valorAltura = _controllerAltura.text;
    String valorTexto = _infoText;
    SharedPreferenceApi.setValorString("valor1", valorPeso);
    SharedPreferenceApi.setValorString("valor2", valorAltura);
    SharedPreferenceApi.setValorString("valor3", valorTexto);
  }

  void _pegaDados() async {
    _controllerPeso.text = await SharedPreferenceApi.getValorString("valor1");
    _controllerAltura.text = await SharedPreferenceApi.getValorString("valor2");
    _controllerTexto.text = await SharedPreferenceApi.getValorString("valor3");
  }
}
