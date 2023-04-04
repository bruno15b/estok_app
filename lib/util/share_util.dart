import 'package:flutter_share/flutter_share.dart';

class ShareUtil {
  static shareLink( String url,
      {String title = "Compartilhando",
      String subtitle = "Compartilhar com",
      String chooserTitle = "Compartilhar com",
    }) async {
    await FlutterShare.share(
        title: title, text: subtitle, chooserTitle: chooserTitle, linkUrl: url);
  }
}
