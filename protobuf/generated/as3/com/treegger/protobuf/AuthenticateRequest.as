package com.treegger.protobuf {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class AuthenticateRequest extends com.netease.protobuf.Message implements flash.utils.IExternalizable {
		public var username:String;
		public var password:String;
		public var resource:String;
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
		/**
		 *  @private
		 */
		public override function writeToBuffer(output:WritingBuffer):void {
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
			WriteUtils.write_TYPE_STRING(output, username);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
			WriteUtils.write_TYPE_STRING(output, password);
			WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
			WriteUtils.write_TYPE_STRING(output, resource);
			if (hasSessionId) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, sessionId);
			}
		}
		public function readExternal(input:IDataInput):void {
			var usernameCount:uint = 0;
			var passwordCount:uint = 0;
			var resourceCount:uint = 0;
			var sessionIdCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (usernameCount != 0) {
						throw new IOError('Bad data format: AuthenticateRequest.username cannot be set twice.');
					}
					++usernameCount;
					username = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (passwordCount != 0) {
						throw new IOError('Bad data format: AuthenticateRequest.password cannot be set twice.');
					}
					++passwordCount;
					password = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (resourceCount != 0) {
						throw new IOError('Bad data format: AuthenticateRequest.resource cannot be set twice.');
					}
					++resourceCount;
					resource = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (sessionIdCount != 0) {
						throw new IOError('Bad data format: AuthenticateRequest.sessionId cannot be set twice.');
					}
					++sessionIdCount;
					sessionId = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
			if (usernameCount != 1) {
				throw new IOError('Bad data format: AuthenticateRequest.username must be set.');
			}
			if (passwordCount != 1) {
				throw new IOError('Bad data format: AuthenticateRequest.password must be set.');
			}
			if (resourceCount != 1) {
				throw new IOError('Bad data format: AuthenticateRequest.resource must be set.');
			}
		}
	}
}
