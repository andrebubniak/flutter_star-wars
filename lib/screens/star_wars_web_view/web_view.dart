import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../commom/widget_view.dart';

class WebView extends StatelessWidget 
{
  final String _siteUrl = "https://www.starwars.com/community";
  const WebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _WebViewView(this);
}

class _WebViewView extends StatelessView<WebView> 
{
  const _WebViewView(super.widget);

  @override
  Widget build(BuildContext context) 
  {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(widget._siteUrl),
        ),
      ),
    );
  }
}