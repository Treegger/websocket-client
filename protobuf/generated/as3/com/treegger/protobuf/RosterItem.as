package com.treegger.protobuf {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class RosterItem extends com.netease.protobuf.Message implements flash.utils.IExternalizable {
		public var name:String;
		public var jid:String;
		public var subscription:String;
		public var itemGroup:String;
		/**
		 *  @private
		 */
		public override function writeToBuffer(output:WritingBuffer):void {
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
			WriteUtils.write_TYPE_STRING(output, name);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, jid);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
			WriteUtils.write_TYPE_STRING(output, subscription);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
			WriteUtils.write_TYPE_STRING(output, itemGroup);
		}
		public function readExternal(input:IDataInput):void {
			var nameCount:uint = 0;
			var jidCount:uint = 0;
			var subscriptionCount:uint = 0;
			var itemGroupCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (nameCount != 0) {
						throw new IOError('Bad data format: RosterItem.name cannot be set twice.');
					}
					++nameCount;
					name = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (jidCount != 0) {
						throw new IOError('Bad data format: RosterItem.jid cannot be set twice.');
					}
					++jidCount;
					jid = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (subscriptionCount != 0) {
						throw new IOError('Bad data format: RosterItem.subscription cannot be set twice.');
					}
					++subscriptionCount;
					subscription = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (itemGroupCount != 0) {
						throw new IOError('Bad data format: RosterItem.itemGroup cannot be set twice.');
					}
					++itemGroupCount;
					itemGroup = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (nameCount != 1) {
				throw new IOError('Bad data format: RosterItem.name must be set.');
			}
			if (jidCount != 1) {
				throw new IOError('Bad data format: RosterItem.jid must be set.');
			}
			if (subscriptionCount != 1) {
				throw new IOError('Bad data format: RosterItem.subscription must be set.');
			}
			if (itemGroupCount != 1) {
				throw new IOError('Bad data format: RosterItem.itemGroup must be set.');
			}
		}
	}
}
