// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_feed.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageFeedAdapter extends TypeAdapter<ImageFeed> {
  @override
  final int typeId = 1;

  @override
  ImageFeed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageFeed(
      imageName: fields[0] as String,
      title: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ImageFeed obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imageName)
      ..writeByte(1)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageFeedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
