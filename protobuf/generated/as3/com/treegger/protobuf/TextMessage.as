package com.treegger.protobuf {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class TextMessage extends com.netease.protobuf.Message implements flash.utils.IExternalizable {
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
		private var toUser_:String;
		public function get hasToUser():Boolean {
			return null != toUser_;
		}
		public function set toUser(value:String):void {
			toUser_ = value;
		}
		public function get toUser():String {
			return toUser_;
		}
		private var fromUser_:String;
		public function get hasFromUser():Boolean {
			return null != fromUser_;
		}
		public function set fromUser(value:String):void {
			fromUser_ = value;
		}
		public function get fromUser():String {
			return fromUser_;
		}
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
		private var subject_:String;
		public function get hasSubject():Boolean {
			return null != subject_;
		}
		public function set subject(value:String):void {
			subject_ = value;
		}
		public function get subject():String {
			return subject_;
		}
		private var body_:String;
		public function get hasBody():Boolean {
			return null != body_;
		}
		public function set body(value:String):void {
			body_ = value;
		}
		public function get body():String {
			return body_;
		}
		private var thread_:String;
		public function get hasThread():Boolean {
			return null != thread_;
		}
		public function set thread(value:String):void {
			thread_ = value;
		}
		public function get thread():String {
			return thread_;
		}
		private var active_:Boolean;
		private var hasActive_:Boolean = false;
		public function get hasActive():Boolean {
			return hasActive_;
		}
		public function set active(value:Boolean):void {
			hasActive_ = true;
			active_ = value;
		}
		public function get active():Boolean {
			return active_;
		}
		private var composing_:Boolean;
		private var hasComposing_:Boolean = false;
		public function get hasComposing():Boolean {
			return hasComposing_;
		}
		public function set composing(value:Boolean):void {
			hasComposing_ = true;
			composing_ = value;
		}
		public function get composing():Boolean {
			return composing_;
		}
		private var paused_:Boolean;
		private var hasPaused_:Boolean = false;
		public function get hasPaused():Boolean {
			return hasPaused_;
		}
		public function set paused(value:Boolean):void {
			hasPaused_ = true;
			paused_ = value;
		}
		public function get paused():Boolean {
			return paused_;
		}
		private var inactive_:Boolean;
		private var hasInactive_:Boolean = false;
		public function get hasInactive():Boolean {
			return hasInactive_;
		}
		public function set inactive(value:Boolean):void {
			hasInactive_ = true;
			inactive_ = value;
		}
		public function get inactive():Boolean {
			return inactive_;
		}
		private var gone_:Boolean;
		private var hasGone_:Boolean = false;
		public function get hasGone():Boolean {
			return hasGone_;
		}
		public function set gone(value:Boolean):void {
			hasGone_ = true;
			gone_ = value;
		}
		public function get gone():Boolean {
			return gone_;
		}
		protected override function writePostposeLength(output:PostposeLengthBuffer):void {
			if (hasId) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_STRING(output, id);
			}
			if (hasToUser) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_STRING(output, toUser);
			}
			if (hasFromUser) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_STRING(output, fromUser);
			}
			if (hasType) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_STRING(output, type);
			}
			if (hasSubject) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_STRING(output, subject);
			}
			if (hasBody) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_STRING(output, body);
			}
			if (hasThread) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_STRING(output, thread);
			}
			if (hasActive) {
				WriteUtils.writeTag(output, WireType.VARINT, 8);
				WriteUtils.write_TYPE_BOOL(output, active);
			}
			if (hasComposing) {
				WriteUtils.writeTag(output, WireType.VARINT, 9);
				WriteUtils.write_TYPE_BOOL(output, composing);
			}
			if (hasPaused) {
				WriteUtils.writeTag(output, WireType.VARINT, 10);
				WriteUtils.write_TYPE_BOOL(output, paused);
			}
			if (hasInactive) {
				WriteUtils.writeTag(output, WireType.VARINT, 11);
				WriteUtils.write_TYPE_BOOL(output, inactive);
			}
			if (hasGone) {
				WriteUtils.writeTag(output, WireType.VARINT, 12);
				WriteUtils.write_TYPE_BOOL(output, gone);
			}
		}
		public function readExternal(input:IDataInput):void {
			var idCount:uint = 0;
			var toUserCount:uint = 0;
			var fromUserCount:uint = 0;
			var typeCount:uint = 0;
			var subjectCount:uint = 0;
			var bodyCount:uint = 0;
			var threadCount:uint = 0;
			var activeCount:uint = 0;
			var composingCount:uint = 0;
			var pausedCount:uint = 0;
			var inactiveCount:uint = 0;
			var goneCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (idCount != 0) {
						throw new IOError('Bad data format: TextMessage.id cannot be set twice.');
					}
					++idCount;
					id = ReadUtils.read_TYPE_STRING(input);
					break;
				case 2:
					if (toUserCount != 0) {
						throw new IOError('Bad data format: TextMessage.toUser cannot be set twice.');
					}
					++toUserCount;
					toUser = ReadUtils.read_TYPE_STRING(input);
					break;
				case 3:
					if (fromUserCount != 0) {
						throw new IOError('Bad data format: TextMessage.fromUser cannot be set twice.');
					}
					++fromUserCount;
					fromUser = ReadUtils.read_TYPE_STRING(input);
					break;
				case 4:
					if (typeCount != 0) {
						throw new IOError('Bad data format: TextMessage.type cannot be set twice.');
					}
					++typeCount;
					type = ReadUtils.read_TYPE_STRING(input);
					break;
				case 5:
					if (subjectCount != 0) {
						throw new IOError('Bad data format: TextMessage.subject cannot be set twice.');
					}
					++subjectCount;
					subject = ReadUtils.read_TYPE_STRING(input);
					break;
				case 6:
					if (bodyCount != 0) {
						throw new IOError('Bad data format: TextMessage.body cannot be set twice.');
					}
					++bodyCount;
					body = ReadUtils.read_TYPE_STRING(input);
					break;
				case 7:
					if (threadCount != 0) {
						throw new IOError('Bad data format: TextMessage.thread cannot be set twice.');
					}
					++threadCount;
					thread = ReadUtils.read_TYPE_STRING(input);
					break;
				case 8:
					if (activeCount != 0) {
						throw new IOError('Bad data format: TextMessage.active cannot be set twice.');
					}
					++activeCount;
					active = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 9:
					if (composingCount != 0) {
						throw new IOError('Bad data format: TextMessage.composing cannot be set twice.');
					}
					++composingCount;
					composing = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 10:
					if (pausedCount != 0) {
						throw new IOError('Bad data format: TextMessage.paused cannot be set twice.');
					}
					++pausedCount;
					paused = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 11:
					if (inactiveCount != 0) {
						throw new IOError('Bad data format: TextMessage.inactive cannot be set twice.');
					}
					++inactiveCount;
					inactive = ReadUtils.read_TYPE_BOOL(input);
					break;
				case 12:
					if (goneCount != 0) {
						throw new IOError('Bad data format: TextMessage.gone cannot be set twice.');
					}
					++goneCount;
					gone = ReadUtils.read_TYPE_BOOL(input);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
