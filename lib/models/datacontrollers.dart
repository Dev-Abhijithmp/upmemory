class Memorydata {
  int? updateCount;
  List<String>? memorytext;
  List<String>? memoryImageUrls;
  List<String>? memoryVoiceurls;
  DateTime? memoryDate;
  Memorydata({
    required this.updateCount,
    required this.memoryDate,
    this.memoryImageUrls,
    this.memoryVoiceurls,
    this.memorytext,
  });
}
