part of google_maps_flutter;

/// Uniquely identifies a [Polyline] among [GoogleMap] polylines.
///
/// This does not have to be globally unique, only unique among the list.
@immutable
class PolylineId {
  PolylineId(this.value) : assert(value != null);

  /// value of the [PolylineId].
  final String value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final PolylineId typedOther = other;
    return value == typedOther.value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'PolylineId{value: $value}';
  }
}

/// Draws a line through geographical locations on the map.
@immutable
class Polyline {
  const Polyline({
    @required this.polylineId,
    this.consumeTapEvents = false,
    this.color = Colors.black,
    this.endCap = Cap.buttCap,
    this.geodesic = false,
    this.jointType = JointType.mitered,
    this.points = const <LatLng>[],
    this.pattern = const <PatternItem> [],
    this.startCap = Cap.buttCap,
    this.visible = true,
    this.width = 1,
    this.zIndex = 0,
    this.onTap,
  });

  /// Uniquely identifies a [Polyline].
  final PolylineId polylineId;

  /// True if the polyline consumes tap events. If not, the map will not trigger polylineTapped callback.
  final bool consumeTapEvents;

  /// Line segment color in ARGB format, the same format used by Color. The default value is black (0xff000000).
  final Color color;

  /// Indicates whether the segments of the polyline should be drawn as geodesics, as opposed to straight lines
  /// on the Mercator projection.
  ///
  /// A geodesic is the shortest path between two points on the Earth's surface.
  /// The geodesic curve is constructed assuming the Earth is a sphere
  final bool geodesic;

  /// Joint type of the polyline line segments.
  ///
  /// The joint type defines the shape to be used when joining adjacent line segments at all vertices of the
  /// polyline except the start and end vertices. See JointType for supported joint types. The default value is
  /// mitered.
  final int jointType;

  /// The stroke pattern for the polyline.
  ///
  /// Solid or a sequence of PatternItem objects to be repeated along the line.
  /// Available PatternItem types: Gap (defined by gap length in pixels), Dash (defined by line width and dash
  /// length in pixels) and Dot (circular, centered on the line, diameter defined by line width in pixels).
  final List<PatternItem> pattern;

  /// The vertices of the polyline to be drawn.
  ///
  /// Line segments are drawn between consecutive points. A polyline is not closed by
  /// default; to form a closed polyline, the start and end points must be the same.
  final List<LatLng> points;

  /// The cap at the start vertex of the polyline.
  ///
  /// The default start cap is ButtCap.
  final Cap startCap;

  /// The cap at the end vertex of the polyline.
  ///
  /// The default end cap is ButtCap.
  final Cap endCap;

  /// True if the marker is visible.
  final bool visible;

  /// Width of the polyline, used to define the width of the line segment to be drawn.
  ///
  /// The width is constant and independent of the camera's zoom level.
  /// The default value is 10.
  final int width;

  /// The z-index of the polyline, used to determine relative drawing order of
  /// map overlays.
  ///
  /// Overlays are drawn in order of z-index, so that lower values means drawn
  /// earlier, and thus appearing to be closer to the surface of the Earth.
  final int zIndex;

  /// Callbacks to receive tap events for polyline placed on this map.
  final VoidCallback onTap;

  /// Creates a new options object whose values are the same as this instance,
  /// unless overwritten by the specified [changes].
  ///
  /// Returns this instance, if [changes] is null.
  Polyline copyWith({
    Color colorParam,
    bool consumeTapEventsParam,
    Cap endCapParam,
    bool geodesicParam,
    int jointTypeParam,
    List<PatternItem> patternParam,
    List<LatLng> pointsParam,
    Cap startCapParam,
    bool visibleParam,
    int widthParam,
    int zIndexParam,
    VoidCallback onTapParam,
  }) {
    return Polyline(
      polylineId: polylineId,
      color: colorParam ?? color,
      consumeTapEvents: consumeTapEventsParam ?? consumeTapEvents,
      endCap: endCapParam ?? endCap,
      geodesic: geodesicParam ?? geodesic,
      jointType: jointTypeParam ?? jointType,
      pattern: patternParam ?? pattern,
      points: pointsParam ?? points,
      startCap: startCapParam ?? startCap,
      visible: visibleParam ?? visible,
      width: widthParam ?? width,
      onTap: onTapParam ?? onTap,
      zIndex: zIndexParam ?? zIndex,
    );
  }

  dynamic _toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};

    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('polylineId', polylineId.value);
    addIfPresent('consumeTapEvents', consumeTapEvents);
    addIfPresent('color', color.value);
    addIfPresent('endCap', endCap?._toJson());
    addIfPresent('geodesic', geodesic);
    addIfPresent('jointType', jointType);
    addIfPresent('startCap', startCap?._toJson());
    addIfPresent('visible', visible);
    addIfPresent('width', width);
    addIfPresent('zIndex', zIndex);

    if (points != null) {
      json['points'] = _pointsToJson();
    }

    if (pattern != null) {
      json['pattern'] = _patternToJson();
    }

    return json;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final Polyline typedOther = other;
    return polylineId == typedOther.polylineId;
  }

  @override
  int get hashCode => polylineId.hashCode;

  dynamic _pointsToJson() {
    final List<dynamic> result = <dynamic>[];
    for (final LatLng point in points) {
      result.add(point._toJson());
    }
    return result;
  }

  dynamic _patternToJson() {
    final List<dynamic> result = <dynamic>[];
    for (final PatternItem patternItem in pattern) {
      if (patternItem != null) {
        result.add(patternItem._toJson());
      }
    }
    return result;
  }
}

Map<PolylineId, Polyline> _keyByPolylineId(Iterable<Polyline> polylines) {
  if (polylines == null) {
    return <PolylineId, Polyline>{};
  }
  return Map<PolylineId, Polyline>.fromEntries(polylines.map(
      (Polyline polyline) =>
          MapEntry<PolylineId, Polyline>(polyline.polylineId, polyline)));
}

List<Map<String, dynamic>> _serializePolylineSet(Set<Polyline> polylines) {
  if (polylines == null) {
    return null;
  }
  return polylines
      .map<Map<String, dynamic>>((Polyline p) => p._toJson())
      .toList();
}
