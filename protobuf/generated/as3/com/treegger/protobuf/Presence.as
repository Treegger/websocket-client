package com.treegger.protobuf {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Presence extends com.netease.protobuf.Message implements flash.utils.IExternalizable {
		public var from:String;
		private var type_:String;
		public function get hasType():Boolean {
			return null != type_;
		}
		public function set type(value:String):void {
			type_ = value;
		}
		public function get type():String {
			return type_;
		}
		private var show_:String;
		public function get hasShow():Boolean {
			return null != show_;
		}
		public function set show(value:String):void {
			show_ = value;
		}
		public function get show():String {
			return show_;
		}
		private var status_:String;
		public function get hasStatus():Boolean {
			return null != status_;
		}
		public function set status(value:String):void {
			status_ = value;
		}
		public function get status():String {
			return status_;
		}
		protected override function writePostposeLength(output:PostposeLengthBuffer):void {
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
			WriteUtils.write_TYPE_STRING(output, from);
			if (hasType) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, type);
			}
			if (hasShow) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, show);
			}
			if (hasStatus) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, status);
			}
		}
		public function readExternal(input:IDataInput):void {
			var fromCount:uint = 0;
			var typeCount:uint = 0;
			var showCount:uint = 0;
			var statusCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (fromCount != 0) {
						throw new IOError('Bad data format: Presence.from cannot be set twice.');
					}
					++fromCount;
					from = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (typeCount != 0) {
						throw new IOError('Bad data format: Presence.type cannot be set twice.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (showCount != 0) {
						throw new IOError('Bad data format: Presence.show cannot be set twice.');
					}
					++showCount;
					show = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (statusCount != 0) {
						throw new IOError('Bad data format: Presence.status cannot be set twice.');
					}
					++statusCount;
					status = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (fromCount != 1) {
				throw new IOError('Bad data format: Presence.from must be set.');
			}
		}
	}
}
