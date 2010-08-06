package com.treegger.protobuf {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class VCardResponse extends com.netease.protobuf.Message implements flash.utils.IExternalizable {
		private var fn_:String;
		public function get hasFn():Boolean {
			return null != fn_;
		}
		public function set fn(value:String):void {
			fn_ = value;
		}
		public function get fn():String {
			return fn_;
		}
		private var nickname_:String;
		public function get hasNickname():Boolean {
			return null != nickname_;
		}
		public function set nickname(value:String):void {
			nickname_ = value;
		}
		public function get nickname():String {
			return nickname_;
		}
		private var photoExternal_:String;
		public function get hasPhotoExternal():Boolean {
			return null != photoExternal_;
		}
		public function set photoExternal(value:String):void {
			photoExternal_ = value;
		}
		public function get photoExternal():String {
			return photoExternal_;
		}
		/**
		 *  @private
		 */
		public override function writeToBuffer(output:WritingBuffer):void {
			if (hasFn) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, fn);
			}
			if (hasNickname) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, nickname);
			}
			if (hasPhotoExternal) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, photoExternal);
			}
		}
		public function readExternal(input:IDataInput):void {
			var fnCount:uint = 0;
			var nicknameCount:uint = 0;
			var photoExternalCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (fnCount != 0) {
						throw new IOError('Bad data format: VCardResponse.fn cannot be set twice.');
					}
					++fnCount;
					fn = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (nicknameCount != 0) {
						throw new IOError('Bad data format: VCardResponse.nickname cannot be set twice.');
					}
					++nicknameCount;
					nickname = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (photoExternalCount != 0) {
						throw new IOError('Bad data format: VCardResponse.photoExternal cannot be set twice.');
					}
					++photoExternalCount;
					photoExternal = ReadUtils.read_TYPE_STRING(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
