import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:new LoginPage(),
      theme: ThemeData(
        primarySwatch:Colors.blue,
        brightness: Brightness.dark,
      ),
    );
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String equation="0";
  String result="0";
  String expression="";

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText=='C'){
        equation="0";
        result="0";
      }

      else if(buttonText=="AC"){
        equation="0";
        result="0";
      }

      else if(buttonText=='⌫'){
        equation=equation.substring(0,equation.length-1);
        if(equation==""){equation="0";}
      }

      else if(buttonText=='='){
        try{
          expression=equation;
          expression=expression.replaceAll("÷", "/");
          expression=expression.replaceAll("×", "*");

          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result="${exp.evaluate(EvaluationType.REAL, cm)}";
        }
        catch(e){
          result="error";
        }
      }

      else if(buttonText=='AC'){}

      else{
        if(equation=='0'){
          equation=buttonText;
        }else{
        equation=equation+buttonText;}
      }
    });
  }


  Widget buttonBuild(String buttonText){
    return Expanded(
        child: MaterialButton(
          padding: EdgeInsets.all(24),
          child: Text(buttonText,style:
            TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold
            )
            ,),
          shape: OutlineInputBorder(),
          color: Colors.teal,

          onPressed: ()=> buttonPressed(buttonText),

        ),
    );
  }

  Widget functionbutton(String buttonText){
    return Expanded(
      child: MaterialButton(
        padding: EdgeInsets.all(24),
        child: Text(buttonText,style:
        TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold
        )
          ,),
        shape: OutlineInputBorder(),
        color: Colors.orange,

        onPressed: ()=> buttonPressed(buttonText),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),

    body: SafeArea(
      child: Column(
        children: [
          new Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
                vertical: 30.0,
                horizontal: 15
            ),

            child: Column(
              children: [

                new Text(equation,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),new Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(
                vertical: 25.0,
                horizontal: 15
            ),

            child: Column(
              children: [

                new Text(result,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          ),

          new Expanded(
            child: new Divider(),
          ),


          new Column(

           children: [
             new Row(
               children: [
                 functionbutton("C"),
                 functionbutton("⌫"),
                 functionbutton("%"),
                 functionbutton("÷"),
               ],

             ),
             new Row(
               children: [
                 buttonBuild("7"),
                 buttonBuild("8"),
                 buttonBuild("9"),
                 functionbutton("×"),
               ],
             ),
             new Row(
               children: [
                 buttonBuild("4"),
                 buttonBuild("5"),
                 buttonBuild("6"),
                 functionbutton("-"),
               ],
             ),
             new Row(
               children: [
                 buttonBuild("1"),
                 buttonBuild("2"),
                 buttonBuild("3"),
                 functionbutton("+"),
               ],
             ),
             new Row(
               children: [
                 functionbutton("AC"),
                 buttonBuild("0"),
                 buttonBuild("."),
                 functionbutton("="),

               ],
             )
           ],
          )//buttons
        ],//main column
      )

    ),
    );
  }
}

