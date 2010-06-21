package com.treegger.protobuf {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class BindResponse extends com.netease.protobuf.Message implements flash.utils.IExternalizable {
		private var sessionId_:String;
		public function get hasSessionId():Boolean {
			return null != sessionId_;
		}
		public function set sessionId(value:String):void {
			sessionId_ = value;
		}
		public function get sessionId():String {
			return sessionId_;
		}
		protected override function writePostposeLength(output:PostposeLengthBuffer):void {
			if (hasSessionId) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, sessionId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var sessionIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (sessionIdCount != 0) {
						throw new IOError('Bad data format: BindResponse.sessionId cannot be set twice.');
					}
					++sessionIdCount;
					sessionId = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
