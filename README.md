<div align="center">

# Triggerable UI

[![Build Status](https://github.com/ManticoreGamesInc/CC-Triggerable-UI/workflows/CI/badge.svg)](https://github.com/ManticoreGamesInc/CC-Triggerable-UI/actions/workflows/ci.yml?query=workflow%3ACI%29)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/ManticoreGamesInc/CC-Triggerable-UI?style=plastic)

![Preview](/Screenshots/Main.png)

</div>

## Finding the Component

This component can be found under the **CoreAcademy** account on Community Content.

## Overview

Triggerable UI is a component that implements logic on a trigger to display a UI Container.

The goal is to open and close a UI Container using a Trigger's events. The template can be switched from using a trigger's beginOverlapEvent or interactedEvent to open the UI. It also has the option to lock the player when the UI is open.

## Setup

Drag the Triggerable UI template into the Hierarchy.

The template has a Trigger object that can be transformed to the specific
area that needs to activate the UI.

The template has a UI Container object. Edit the children of this container
so it contains the desired UI components. Make sure to not delete the Close Button.

## How to use this Template

### Custom Properties

The root of the template contains 2 custom properties.

- DisplayOnOverlap

If active, the UI will be displayed when the player enters the trigger.
If inactive, the UI will be displayed when the player interacts with the trigger.

- LockPlayer

If true, the player will be unable to move, crouch, or jump when the UI is displayed.

### Broadcasting Events

The client script has an Event connected so another script can show or hide the UI.

The syntax for broadcasting the event is as follows:

```lua
Events.Broadcast(COMPONENT_ROOT.id .. ".SetUIVisibility", isVisible))
```

See below an example on how to close the UI with the ESC key.

```lua
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
```
