--[[

  _______   _                            _     _        _    _ _____ 
 |__   __| (_)                          | |   | |      | |  | |_   _|
    | |_ __ _  __ _  __ _  ___ _ __ __ _| |__ | | ___  | |  | | | |  
    | | '__| |/ _` |/ _` |/ _ \ '__/ _` | '_ \| |/ _ \ | |  | | | |  
    | | |  | | (_| | (_| |  __/ | | (_| | |_) | |  __/ | |__| |_| |_ 
    |_|_|  |_|\__, |\__, |\___|_|  \__,_|_.__/|_|\___|  \____/|_____|
               __/ | __/ |                                           
              |___/ |___/                                            
              
Triggerable UI is a component that implements logic on a trigger to
display a UI Container. 

The goal is to open and close a UI Container using a Trigger's events.
The template can be switched from using a trigger's beginOverlapEvent
or interactedEvent to open the UI. It also has the option to lock the 
player from crouching, moving, or jumping when the UI is open.

=====
Setup
=====

Drag the Triggerable UI template into the Hierarchy.

The template has a Trigger object that can be transformed to the specific
area that needs to activate the UI.

The template has a UI Container object. Edit the children of this container
so it contains the desired UI components. Make sure to not delete the Close Button.

==========
How to use
==========

The root of the template contains 2 custom properties.

- DisplayOnOverlap

If active, the UI will be displayed when the player enters the trigger.
If inactive, the UI will be displayed when the player interacts with the trigger.

- LockPlayer

If true, the player will be unable to move, crouch, or jump when the UI is displayed.


======
Events
======

The client script has an Event connected so another script can show or hide the UI.

The syntax for broadcasting the event is as follows:

Events.Broadcast(COMPONENT_ROOT.id .. ".SetUIVisibility", isVisible))

See below an example on how to close the UI with the ESC key.

=============
Example Usage
=============

--Seperate client script
--Reference to Triggerable UI root object
local TRIGGERABLE_UI = script:GetCustomProperty("TriggerableUI"):WaitForObject()

function OnEscape(localPlayer, params)
    -- Prevents Core's default pause from appearing
    params.openPauseMenu = false
	--Hide the Triggerable UI
    Events.Broadcast(TRIGGERABLE_UI.id .. ".SetUIVisibility", false)
end

-- Intercept the ESC key being pressed
Input.escapeHook:Connect(OnEscape)

]]--