import 'package:dev_community/model/article.dart';
import 'package:dev_community/provider/user_data_provider.dart';
import 'package:dev_community/screen/article/article_create_screen.dart';
import 'package:dev_community/screen/article/article_detail_screen.dart';
import 'package:dev_community/screen/root_screen.dart';
import 'package:dev_community/screen/article/article_root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dev_community/firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

import 'const/firebase_query.dart';
import 'noti/notification_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      ChangeNotifierProvider(
        create: (context) => UserDataProvider(),
        child: MaterialApp(
          routes: {
            '/home': (context) => const ArticleRootScreen(),
            '/root': (context) => RootScreen(),
            '/detail': (context) {
              Article article = ModalRoute.of(context)?.settings.arguments as Article;
              return ArticleDetailScreen(article: article);
            },
            '/create': (context) => ArticleCreateScreen(),
          },
          builder: FToastBuilder(),
          debugShowCheckedModeBanner: false,
          home: RootScreen(),
        ),
      ),
    );
  });

}


