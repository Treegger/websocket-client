package com.treegger.protobuf {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class AuthenticateResponse extends com.netease.protobuf.Message implements flash.utils.IExternalizable {
		public var username:String;
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
		private var errorMessage_:String;
		public function get hasErrorMessage():Boolean {
			return null != errorMessage_;
		}
		public function set errorMessage(value:String):void {
			errorMessage_ = value;
		}
		public function get errorMessage():String {
			return errorMessage_;
		}
		protected override function writePostposeLength(output:PostposeLengthBuffer):void {
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
			WriteUtils.write_TYPE_STRING(output, username);
			if (hasSessionId) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, sessionId);
			}
			if (hasErrorMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, errorMessage);
			}
		}
		public function readExternal(input:IDataInput):void {
			var usernameCount:uint = 0;
			var sessionIdCount:uint = 0;
			var errorMessageCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (usernameCount != 0) {
						throw new IOError('Bad data format: AuthenticateResponse.username cannot be set twice.');
					}
					++usernameCount;
					username = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (sessionIdCount != 0) {
						throw new IOError('Bad data format: AuthenticateResponse.sessionId cannot be set twice.');
					}
					++sessionIdCount;
					sessionId = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (errorMessageCount != 0) {
						throw new IOError('Bad data format: AuthenticateResponse.errorMessage cannot be set twice.');
					}
					++errorMessageCount;
					errorMessage = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (usernameCount != 1) {
				throw new IOError('Bad data format: AuthenticateResponse.username must be set.');
			}
		}
	}
}
