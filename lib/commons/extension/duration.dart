extension ShortcutDuration on num{
  Duration get microseconds => Duration(microseconds: this.round());
  Duration get ms => (this * 1000).microseconds;
  Duration get seconds => (this *1000 * 1000).microseconds;
}