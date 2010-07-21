package com.treegger.protobuf {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class Error extends com.netease.protobuf.Message implements flash.utils.IExternalizable {
		public var code:uint;
		private var description_:String;
		public function get hasDescription():Boolean {
			return null != description_;
		}
		public function set description(value:String):void {
			description_ = value;
		}
		public function get description():String {
			return description_;
		}
		/**
		 *  @private
		 */
		public override function writeToBuffer(output:WritingBuffer):void {
			WriteUtils.writeTag(output, WireType.VARINT, 1);
			WriteUtils.write_TYPE_UINT32(output, code);
			if (hasDescription) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, description);
			}
		}
		public function readExternal(input:IDataInput):void {
			var codeCount:uint = 0;
			var descriptionCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (codeCount != 0) {
						throw new IOError('Bad data format: Error.code cannot be set twice.');
					}
					++codeCount;
					code = ReadUtils.read_TYPE_UINT32(input);
					break;
				case 2:
					if (descriptionCount != 0) {
						throw new IOError('Bad data format: Error.description cannot be set twice.');
					}
					++descriptionCount;
					description = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (codeCount != 1) {
				throw new IOError('Bad data format: Error.code must be set.');
			}
		}
	}
}
