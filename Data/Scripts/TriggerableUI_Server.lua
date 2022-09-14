local players = {}

local function LockPlayer(player)
	players[player.id] = player.maxJumpCount
	player.maxJumpCount = 0
	player.isMovementEnabled = false
	player.isCrouchEnabled = false
end

local function UnlockPlayer(player)
	player.maxJumpCount = players[player.id] or 1
	player.isMovementEnabled = true
	player.isCrouchEnabled = true
end

local function OnPlayerJoined(player)
	players[player.id] = 1
end

local function OnPlayerLeft(player)
	players[player.id] = nil
end

Events.ConnectForPlayer("LockPlayer", LockPlayer)
Events.ConnectForPlayer("UnlockPlayer", UnlockPlayer)

Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)