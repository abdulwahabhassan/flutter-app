import 'package:flutter/cupertino.dart';
import 'package:flutter_app/route_navigation/note_route_path.dart';

class NoteRouterInformationParser
    extends RouteInformationParser<NoteRoutePath> {
  @override
  Future<NoteRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(
        routeInformation.location != null ? routeInformation.location! : '/');
    // handle '/'
    if (uri.pathSegments.isEmpty) {
      return NoteRoutePath.notes();
    }

    // handle '/note/:id'
    if (uri.pathSegments.length == 2) {
      int? id = int.tryParse(uri.pathSegments[1]);
      return id != null ? NoteRoutePath.details(id) : NoteRoutePath.notes();
    }

    //default to notes page
    return NoteRoutePath.notes();
  }

  @override
  RouteInformation restoreRouteInformation(NoteRoutePath configuration) {
    if (configuration.isNotesPage) {
      return const RouteInformation(location: '/');
    }
    if (configuration.isDetailsPage) {
      return RouteInformation(location: '/note/${configuration.id}');
    }
    //default to notes route
    return const RouteInformation(location: '/');
  }
}
