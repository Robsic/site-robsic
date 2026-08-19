import 'dart:ui_web' as ui_web;
import 'dart:html' as html;
import 'package:flutter/material.dart';

Widget getYouTubePlayer(String videoId) {
  final viewId = 'youtube-$videoId';
  
  ui_web.platformViewRegistry.registerViewFactory(viewId, (int viewId) {
    return html.IFrameElement()
      ..src = 'https://www.youtube.com/embed/$videoId?autoplay=1'
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture'
      ..allowFullscreen = true;
  });

  return HtmlElementView(viewType: viewId);
}
