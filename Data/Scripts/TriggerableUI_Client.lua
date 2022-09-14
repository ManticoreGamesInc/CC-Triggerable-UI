local COMPONENT_ROOT = script:GetCustomProperty("ComponentRoot"):WaitForObject()
local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
local UICONTAINER = script:GetCustomProperty("UIContainer"):WaitForObject()
local CLOSE_BUTTON = script:GetCustomProperty("CloseButton"):WaitForObject()

local DISPLAY_ON_OVERLAP = COMPONENT_ROOT:GetCustomProperty("DisplayOnOverlap")
local LOCK_PLAYER = COMPONENT_ROOT:GetCustomProperty("LockPlayer")

local LOCAL_PLAYER = Game.GetLocalPlayer()

local function SetUIVisibility(isVisible)
	UICONTAINER.visibility = isVisible and Visibility.FORCE_ON or Visibility.FORCE_OFF
	UI.SetCursorVisible(isVisible)
	UI.SetCanCursorInteractWithUI(isVisible)
	if LOCK_PLAYER then
		Events.BroadcastToServer(isVisible and "LockPlayer" or "UnlockPlayer")
	end
	if not DISPLAY_ON_OVERLAP and not isVisible and TRIGGER:IsOverlapping(LOCAL_PLAYER) then
		TRIGGER.isInteractable = true
	end
end

local function OnBeginOverlap(trigger, other)
	if other == LOCAL_PLAYER then
		if DISPLAY_ON_OVERLAP then
			SetUIVisibility(true)
		else
			TRIGGER.isInteractable = true
		end
	end
end

local function OnEndOverlap(trigger, other)
	if other == LOCAL_PLAYER then
		SetUIVisibility(false)
	end
end

local function OnInteracted(trigger, other)
	if other == LOCAL_PLAYER then
		SetUIVisibility(true)
		TRIGGER.isInteractable = false
	end
end

local function OnCloseClicked(button)
	SetUIVisibility(false)
end

TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)
TRIGGER.endOverlapEvent:Connect(OnEndOverlap)

if not DISPLAY_ON_OVERLAP then
	TRIGGER.interactedEvent:Connect(OnInteracted)
end

CLOSE_BUTTON.clickedEvent:Connect(OnCloseClicked)

Events.Connect(COMPONENT_ROOT.id .. ".SetUIVisibility", SetUIVisibility)
