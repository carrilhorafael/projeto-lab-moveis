class Interest {
  String userId;
  String petId;
  Status status;

  Interest({
    required this.userId,
    required this.petId,
    required this.status,
  });

  bool isActive() {
    switch (this.status) {
      case Status.pending:
      case Status.accepted:
        return true;

      case Status.refused:
        return false;
    }
  }
}

enum Status { pending, accepted, refused }
