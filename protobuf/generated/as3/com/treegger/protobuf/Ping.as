package com.treegger.protobuf {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Ping extends com.netease.protobuf.Message implements flash.utils.IExternalizable {
		private var id_:String;
		public function get hasId():Boolean {
			return null != id_;
		}
		public function set id(value:String):void {
			id_ = value;
		}
		public function get id():String {
			return id_;
		}
		/**
		 *  @private
		 */
		public override function writeToBuffer(output:WritingBuffer):void {
			if (hasId) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, id);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format: Ping.id cannot be set twice.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
