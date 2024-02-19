class User {
  final int id;
  final DateTime createdAt;
  final String name;
  final String avatar;

  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is User &&
            other.runtimeType == runtimeType &&
            other.id == id &&
            other.name == name &&
            other.avatar == avatar &&
            other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode;
}

void main() {
  final DateTime now = DateTime.now();
  final User user1 = User(
    id: 1,
    createdAt: now,
    name: 'name',
    avatar: 'avatar',
  );

  final User user2 = User(
    id: 1,
    createdAt: now,
    name: 'name',
    avatar: 'avatar',
  );

  print(user1 == user2);
}
