
import 'package:akalsahae/app/apiCollection/api_client.dart';
import 'package:url_launcher/url_launcher.dart';
class CommonMethods{

  openUrl(Uri url)async
  {
        if (!await launchUrl(url,
        mode: LaunchMode.externalApplication,
      )) {
          // ApiClient.toAst("Invalid Link");
         throw Exception('Could not launch $url');
      }

  }


}