package com.treegger.protobuf {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import com.treegger.protobuf.RosterItem;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Roster extends com.netease.protobuf.Message implements flash.utils.IExternalizable {
		[ArrayElementType("com.treegger.protobuf.RosterItem")]
		public var item:Array = [];
		protected override function writePostposeLength(output:PostposeLengthBuffer):void {
			for (var itemIndex:uint = 0; itemIndex < item.length; ++itemIndex) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, item[itemIndex]);
			}
		}
		public function readExternal(input:IDataInput):void {
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					item.push(ReadUtils.read_TYPE_MESSAGE(input, new com.treegger.protobuf.RosterItem));
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
