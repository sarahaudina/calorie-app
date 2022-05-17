class GetEntriesResponse {
  final List map;
  final int totalItems;
  final int totalPages;
  final int itemsPerPage;

  const GetEntriesResponse(this.map, this.totalItems, this.totalPages, this.itemsPerPage);

  factory GetEntriesResponse.fromMap(Map<String, dynamic> map) {
    return GetEntriesResponse(
      map['users'],
      map['totalItems'],
      map['totalPages'],
      map['itemsPerPage']
    );
  }
}

class CreateEntryResponse {

  const CreateEntryResponse();

  factory CreateEntryResponse.fromMap(Map<String, dynamic> map) {
    return CreateEntryResponse();
  }
}