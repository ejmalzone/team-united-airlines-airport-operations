import 'package:airportops_frontend/admin/admin_profile.dart';
import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database.dart';
import 'login.dart';

class PortalRoute extends StatelessWidget {
  ElevatedButton makeButton(BuildContext context, String text, String img,
      [String? endRoute]) {
    const buttonTextStyle = TextStyle(
        color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold);

    var buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(180, 180),
      backgroundColor: Colors.grey,
      textStyle: buttonTextStyle,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.5)),
    );

    return ElevatedButton(
        style: buttonStyle,
        onPressed: () async {
          if (endRoute == '/admin') {
            Map<String, dynamic> eventMap = await eventRequest();
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            String? user = prefs.getString(ADMIN_KEY);
            if (user != null) {
              await usernameValidation(user)
              .then((data) async => {
                if (data["status"] == "success")
                  {
                    await Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) {
                      return AdminRoute(eventmap: eventMap);
                    })))
                  }
              });
            } else {
              await Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) {
              return LoginRoute();
            })));
            }
          } else if (endRoute == '/csrSelect' || endRoute == '/baggageSelect') {
            print("ENDROUTE: ${endRoute}");
            //Navigator.pushNamed(context, endRoute);
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      CompetitorSelectPage(source: endRoute!)),
            );
          } else {
            await Navigator.of(context).pushNamed(endRoute.toString());
          }

          // if (endRoute == '/admin') {
          //   Navigator.pushNamed(context, '/admin');
          //   Map<String, dynamic> eventMap = await eventRequest();
          //   if (eventMap['status'] == 'success') {
          //     await Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => AdminRoute(eventmap: eventMap)));
          //   }
          // }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Image.asset(img), Text(text, style: buttonTextStyle)]
              .withSpaceBetween(height: 8),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Portal Selection'),
        titleTextStyle: const TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        backgroundColor: Colors.black,
        toolbarHeight: 105,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // makeButton(context, 'Customer Service',
                //     'assets/icons8-airport-64.png', '/customerservice'),
                // makeButton(context, 'Ramp Service',
                //     'assets/icons8-luggage-64 (1).png', '/baggage'),
                makeButton(context, 'Customer Service',
                    'assets/icons8-airport-64.png', '/csrSelect'),
                makeButton(context, 'Ramp Service',
                    'assets/icons8-luggage-64 (1).png', '/baggageSelect'),
              ].withSpaceBetween(width: 36),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                makeButton(
                    context, 'Admin', 'assets/united-square-64.png', '/admin'),
                makeButton(
                    //TEMPORARY DEBUG BUTTON
                    context,
                    'Debug',
                    'assets/united-square-64.png',
                    '/home'),
              ].withSpaceBetween(
                width: 36,
              ),
            ),
          ].withSpaceBetween(height: 36),
        ),
      ),
    );
  }
}
