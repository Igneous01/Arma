BIS_convMenu = [];

switch (_sentenceId) do {
	
	case "InfFriendTalk01": {
		 BIS_convMenu = [["Talk To Him", _topic, "SniperTalk01", []]]
	};
	
	// once i have talked to him, he responds with a second statement, i will have to respond again
	case "InfFriendTalk02": {
	       BIS_convMenu = [["Respond", _topic, "SniperTalk02", []]];
	};
	
	// when he finishes talking, choices appear to accept or decline mission
	case "InfFriendTalk03": {
		 BIS_convMenu = [["Accept.", _topic, "SniperTalkAccept", []]];
		 BIS_convMenu = BIS_convMenu + [["Refuse.", _topic, "SniperTalkRefuse", []]];
	};
	
	case "InfFriendTalkDestination": {
		BIS_convMenu = [["Fine, thank you.", _topic, "SniperTalkLetGo", []]];
		BIS_convMenu = BIS_convMenu + [["Your not going anywhere.", _topic, "SniperTalkStayHere", []]];
      };
};

BIS_convMenu