if (typeof(com)=="undefined") {com = {};}
if (typeof(com.treegger)=="undefined") {com.treegger = {};}
if (typeof(com.treegger.protobuf)=="undefined") {com.treegger.protobuf = {};}

com.treegger.protobuf.WebSocketMessage = PROTO.Message("com.treegger.protobuf.WebSocketMessage",{
	ping: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return com.treegger.protobuf.Ping;},
		id: 1
	},
	authenticateRequest: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return com.treegger.protobuf.AuthenticateRequest;},
		id: 2
	},
	authenticateResponse: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return com.treegger.protobuf.AuthenticateResponse;},
		id: 3
	},
	bindRequest: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return com.treegger.protobuf.BindRequest;},
		id: 4
	},
	bindResponse: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return com.treegger.protobuf.BindResponse;},
		id: 5
	},
	roster: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return com.treegger.protobuf.Roster;},
		id: 6
	},
	presence: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return com.treegger.protobuf.Presence;},
		id: 7
	},
	textMessage: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return com.treegger.protobuf.TextMessage;},
		id: 8
	}});
com.treegger.protobuf.Error = PROTO.Message("com.treegger.protobuf.Error",{
	code: {
		options: {},
		multiplicity: PROTO.required,
		type: function(){return PROTO.uint32;},
		id: 1
	},
	description: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 2
	}});
com.treegger.protobuf.Ping = PROTO.Message("com.treegger.protobuf.Ping",{
	id: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 1
	}});
com.treegger.protobuf.AuthenticateRequest = PROTO.Message("com.treegger.protobuf.AuthenticateRequest",{
	username: {
		options: {},
		multiplicity: PROTO.required,
		type: function(){return PROTO.string;},
		id: 1
	},
	password: {
		options: {},
		multiplicity: PROTO.required,
		type: function(){return PROTO.string;},
		id: 2
	},
	resource: {
		options: {},
		multiplicity: PROTO.required,
		type: function(){return PROTO.string;},
		id: 3
	}});
com.treegger.protobuf.AuthenticateResponse = PROTO.Message("com.treegger.protobuf.AuthenticateResponse",{
	username: {
		options: {},
		multiplicity: PROTO.required,
		type: function(){return PROTO.string;},
		id: 1
	},
	sessionId: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 2
	},
	errorMessage: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 3
	}});
com.treegger.protobuf.BindRequest = PROTO.Message("com.treegger.protobuf.BindRequest",{
	sessionId: {
		options: {},
		multiplicity: PROTO.required,
		type: function(){return PROTO.string;},
		id: 1
	}});
com.treegger.protobuf.BindResponse = PROTO.Message("com.treegger.protobuf.BindResponse",{
	sessionId: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 1
	}});
com.treegger.protobuf.Roster = PROTO.Message("com.treegger.protobuf.Roster",{
	item: {
		options: {},
		multiplicity: PROTO.repeated,
		type: function(){return com.treegger.protobuf.RosterItem;},
		id: 1
	}});
com.treegger.protobuf.RosterItem = PROTO.Message("com.treegger.protobuf.RosterItem",{
	name: {
		options: {},
		multiplicity: PROTO.required,
		type: function(){return PROTO.string;},
		id: 1
	},
	jid: {
		options: {},
		multiplicity: PROTO.required,
		type: function(){return PROTO.string;},
		id: 2
	},
	subscription: {
		options: {},
		multiplicity: PROTO.required,
		type: function(){return PROTO.string;},
		id: 3
	},
	itemGroup: {
		options: {},
		multiplicity: PROTO.required,
		type: function(){return PROTO.string;},
		id: 4
	}});
com.treegger.protobuf.Presence = PROTO.Message("com.treegger.protobuf.Presence",{
	from: {
		options: {},
		multiplicity: PROTO.required,
		type: function(){return PROTO.string;},
		id: 1
	},
	type: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 2
	},
	show: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 3
	},
	status: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 4
	}});
com.treegger.protobuf.TextMessage = PROTO.Message("com.treegger.protobuf.TextMessage",{
	id: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 1
	},
	toUser: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 2
	},
	fromUser: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 3
	},
	type: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 4
	},
	subject: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 5
	},
	body: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 6
	},
	thread: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.string;},
		id: 7
	},
	active: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.bool;},
		id: 8
	},
	composing: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.bool;},
		id: 9
	},
	paused: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.bool;},
		id: 10
	},
	inactive: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.bool;},
		id: 11
	},
	gone: {
		options: {},
		multiplicity: PROTO.optional,
		type: function(){return PROTO.bool;},
		id: 12
	}});
