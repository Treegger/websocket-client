package com.treegger.protobuf {
	import com.netease.protobuf.*;
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.errors.IOError;
	import com.treegger.protobuf.BindRequest;
	import com.treegger.protobuf.VCardRequest;
	import com.treegger.protobuf.BindResponse;
	import com.treegger.protobuf.AuthenticateResponse;
	import com.treegger.protobuf.TextMessage;
	import com.treegger.protobuf.Presence;
	import com.treegger.protobuf.Roster;
	import com.treegger.protobuf.AuthenticateRequest;
	import com.treegger.protobuf.Ping;
	// @@protoc_insertion_point(imports)
	// @@protoc_insertion_point(class_metadata)
	public final class WebSocketMessage extends com.netease.protobuf.Message implements flash.utils.IExternalizable {
		private var ping_:com.treegger.protobuf.Ping;
		public function get hasPing():Boolean {
			return null != ping_;
		}
		public function set ping(value:com.treegger.protobuf.Ping):void {
			ping_ = value;
		}
		public function get ping():com.treegger.protobuf.Ping {
			return ping_;
		}
		private var authenticateRequest_:com.treegger.protobuf.AuthenticateRequest;
		public function get hasAuthenticateRequest():Boolean {
			return null != authenticateRequest_;
		}
		public function set authenticateRequest(value:com.treegger.protobuf.AuthenticateRequest):void {
			authenticateRequest_ = value;
		}
		public function get authenticateRequest():com.treegger.protobuf.AuthenticateRequest {
			return authenticateRequest_;
		}
		private var authenticateResponse_:com.treegger.protobuf.AuthenticateResponse;
		public function get hasAuthenticateResponse():Boolean {
			return null != authenticateResponse_;
		}
		public function set authenticateResponse(value:com.treegger.protobuf.AuthenticateResponse):void {
			authenticateResponse_ = value;
		}
		public function get authenticateResponse():com.treegger.protobuf.AuthenticateResponse {
			return authenticateResponse_;
		}
		private var bindRequest_:com.treegger.protobuf.BindRequest;
		public function get hasBindRequest():Boolean {
			return null != bindRequest_;
		}
		public function set bindRequest(value:com.treegger.protobuf.BindRequest):void {
			bindRequest_ = value;
		}
		public function get bindRequest():com.treegger.protobuf.BindRequest {
			return bindRequest_;
		}
		private var bindResponse_:com.treegger.protobuf.BindResponse;
		public function get hasBindResponse():Boolean {
			return null != bindResponse_;
		}
		public function set bindResponse(value:com.treegger.protobuf.BindResponse):void {
			bindResponse_ = value;
		}
		public function get bindResponse():com.treegger.protobuf.BindResponse {
			return bindResponse_;
		}
		private var roster_:com.treegger.protobuf.Roster;
		public function get hasRoster():Boolean {
			return null != roster_;
		}
		public function set roster(value:com.treegger.protobuf.Roster):void {
			roster_ = value;
		}
		public function get roster():com.treegger.protobuf.Roster {
			return roster_;
		}
		private var presence_:com.treegger.protobuf.Presence;
		public function get hasPresence():Boolean {
			return null != presence_;
		}
		public function set presence(value:com.treegger.protobuf.Presence):void {
			presence_ = value;
		}
		public function get presence():com.treegger.protobuf.Presence {
			return presence_;
		}
		private var textMessage_:com.treegger.protobuf.TextMessage;
		public function get hasTextMessage():Boolean {
			return null != textMessage_;
		}
		public function set textMessage(value:com.treegger.protobuf.TextMessage):void {
			textMessage_ = value;
		}
		public function get textMessage():com.treegger.protobuf.TextMessage {
			return textMessage_;
		}
		private var vcardRequest_:com.treegger.protobuf.VCardRequest;
		public function get hasVcardRequest():Boolean {
			return null != vcardRequest_;
		}
		public function set vcardRequest(value:com.treegger.protobuf.VCardRequest):void {
			vcardRequest_ = value;
		}
		public function get vcardRequest():com.treegger.protobuf.VCardRequest {
			return vcardRequest_;
		}
		private var vcardResponse_:com.treegger.protobuf.VCardRequest;
		public function get hasVcardResponse():Boolean {
			return null != vcardResponse_;
		}
		public function set vcardResponse(value:com.treegger.protobuf.VCardRequest):void {
			vcardResponse_ = value;
		}
		public function get vcardResponse():com.treegger.protobuf.VCardRequest {
			return vcardResponse_;
		}
		/**
		 *  @private
		 */
		public override function writeToBuffer(output:WritingBuffer):void {
			if (hasPing) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 1);
				WriteUtils.write_TYPE_MESSAGE(output, ping);
			}
			if (hasAuthenticateRequest) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 2);
				WriteUtils.write_TYPE_MESSAGE(output, authenticateRequest);
			}
			if (hasAuthenticateResponse) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 3);
				WriteUtils.write_TYPE_MESSAGE(output, authenticateResponse);
			}
			if (hasBindRequest) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 4);
				WriteUtils.write_TYPE_MESSAGE(output, bindRequest);
			}
			if (hasBindResponse) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 5);
				WriteUtils.write_TYPE_MESSAGE(output, bindResponse);
			}
			if (hasRoster) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 6);
				WriteUtils.write_TYPE_MESSAGE(output, roster);
			}
			if (hasPresence) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 7);
				WriteUtils.write_TYPE_MESSAGE(output, presence);
			}
			if (hasTextMessage) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 8);
				WriteUtils.write_TYPE_MESSAGE(output, textMessage);
			}
			if (hasVcardRequest) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 9);
				WriteUtils.write_TYPE_MESSAGE(output, vcardRequest);
			}
			if (hasVcardResponse) {
				WriteUtils.writeTag(output, WireType.LENGTH_DELIMITED, 10);
				WriteUtils.write_TYPE_MESSAGE(output, vcardResponse);
			}
		}
		public function readExternal(input:IDataInput):void {
			var pingCount:uint = 0;
			var authenticateRequestCount:uint = 0;
			var authenticateResponseCount:uint = 0;
			var bindRequestCount:uint = 0;
			var bindResponseCount:uint = 0;
			var rosterCount:uint = 0;
			var presenceCount:uint = 0;
			var textMessageCount:uint = 0;
			var vcardRequestCount:uint = 0;
			var vcardResponseCount:uint = 0;
			while (input.bytesAvailable != 0) {
				var tag:Tag = ReadUtils.readTag(input);
				switch (tag.number) {
				case 1:
					if (pingCount != 0) {
						throw new IOError('Bad data format: WebSocketMessage.ping cannot be set twice.');
					}
					++pingCount;
					ping = new com.treegger.protobuf.Ping;
					ReadUtils.read_TYPE_MESSAGE(input, ping);
					break;
				case 2:
					if (authenticateRequestCount != 0) {
						throw new IOError('Bad data format: WebSocketMessage.authenticateRequest cannot be set twice.');
					}
					++authenticateRequestCount;
					authenticateRequest = new com.treegger.protobuf.AuthenticateRequest;
					ReadUtils.read_TYPE_MESSAGE(input, authenticateRequest);
					break;
				case 3:
					if (authenticateResponseCount != 0) {
						throw new IOError('Bad data format: WebSocketMessage.authenticateResponse cannot be set twice.');
					}
					++authenticateResponseCount;
					authenticateResponse = new com.treegger.protobuf.AuthenticateResponse;
					ReadUtils.read_TYPE_MESSAGE(input, authenticateResponse);
					break;
				case 4:
					if (bindRequestCount != 0) {
						throw new IOError('Bad data format: WebSocketMessage.bindRequest cannot be set twice.');
					}
					++bindRequestCount;
					bindRequest = new com.treegger.protobuf.BindRequest;
					ReadUtils.read_TYPE_MESSAGE(input, bindRequest);
					break;
				case 5:
					if (bindResponseCount != 0) {
						throw new IOError('Bad data format: WebSocketMessage.bindResponse cannot be set twice.');
					}
					++bindResponseCount;
					bindResponse = new com.treegger.protobuf.BindResponse;
					ReadUtils.read_TYPE_MESSAGE(input, bindResponse);
					break;
				case 6:
					if (rosterCount != 0) {
						throw new IOError('Bad data format: WebSocketMessage.roster cannot be set twice.');
					}
					++rosterCount;
					roster = new com.treegger.protobuf.Roster;
					ReadUtils.read_TYPE_MESSAGE(input, roster);
					break;
				case 7:
					if (presenceCount != 0) {
						throw new IOError('Bad data format: WebSocketMessage.presence cannot be set twice.');
					}
					++presenceCount;
					presence = new com.treegger.protobuf.Presence;
					ReadUtils.read_TYPE_MESSAGE(input, presence);
					break;
				case 8:
					if (textMessageCount != 0) {
						throw new IOError('Bad data format: WebSocketMessage.textMessage cannot be set twice.');
					}
					++textMessageCount;
					textMessage = new com.treegger.protobuf.TextMessage;
					ReadUtils.read_TYPE_MESSAGE(input, textMessage);
					break;
				case 9:
					if (vcardRequestCount != 0) {
						throw new IOError('Bad data format: WebSocketMessage.vcardRequest cannot be set twice.');
					}
					++vcardRequestCount;
					vcardRequest = new com.treegger.protobuf.VCardRequest;
					ReadUtils.read_TYPE_MESSAGE(input, vcardRequest);
					break;
				case 10:
					if (vcardResponseCount != 0) {
						throw new IOError('Bad data format: WebSocketMessage.vcardResponse cannot be set twice.');
					}
					++vcardResponseCount;
					vcardResponse = new com.treegger.protobuf.VCardRequest;
					ReadUtils.read_TYPE_MESSAGE(input, vcardResponse);
					break;
				default:
					ReadUtils.skip(input, tag.wireType);
				}
			}
		}
	}
}
