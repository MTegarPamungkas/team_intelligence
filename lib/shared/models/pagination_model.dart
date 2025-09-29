class PaginationModel<T> {
  final List<T> items;
  final int total;
  final int page;
  final int perPage;

  PaginationModel({
    required this.items,
    required this.total,
    required this.page,
    required this.perPage,
  });
}
