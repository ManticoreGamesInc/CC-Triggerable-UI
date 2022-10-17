Assets {
  Id: 2648388081944529665
  Name: "Triggerable UI"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 7176691896320247595
      Objects {
        Id: 7176691896320247595
        Name: "TemplateBundleDummy"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        Folder {
          BundleDummy {
            ReferencedAssets {
              Id: 736360303936294653
            }
            ReferencedAssets {
              Id: 6907996033184907708
            }
            ReferencedAssets {
              Id: 15123898430258676698
            }
            ReferencedAssets {
              Id: 2852566101046937996
            }
            ReferencedAssets {
              Id: 12768730457743900369
            }
            ReferencedAssets {
              Id: 16841168125380120964
            }
          }
        }
      }
    }
    Assets {
      Id: 16841168125380120964
      Name: "TriggerableUI_Server"
      PlatformAssetType: 3
      TextAsset {
        Text: "local players = {}\r\n\r\nlocal function LockPlayer(player)\r\n\tplayers[player.id] = player.maxJumpCount\r\n\tplayer.maxJumpCount = 0\r\n\tplayer.isMovementEnabled = false\r\n\tplayer.isCrouchEnabled = false\r\nend\r\n\r\nlocal function UnlockPlayer(player)\r\n\tplayer.maxJumpCount = players[player.id] or 1\r\n\tplayer.isMovementEnabled = true\r\n\tplayer.isCrouchEnabled = true\r\nend\r\n\r\nlocal function OnPlayerJoined(player)\r\n\tplayers[player.id] = 1\r\nend\r\n\r\nlocal function OnPlayerLeft(player)\r\n\tplayers[player.id] = nil\r\nend\r\n\r\nEvents.ConnectForPlayer(\"LockPlayer\", LockPlayer)\r\nEvents.ConnectForPlayer(\"UnlockPlayer\", UnlockPlayer)\r\n\r\nGame.playerJoinedEvent:Connect(OnPlayerJoined)\r\nGame.playerLeftEvent:Connect(OnPlayerLeft)"
        CustomParameters {
        }
      }
    }
    Assets {
      Id: 12768730457743900369
      Name: "TriggerableUI_README"
      PlatformAssetType: 3
      TextAsset {
        Text: "--[[\r\n\r\n  _______   _                            _     _        _    _ _____ \r\n |__   __| (_)                          | |   | |      | |  | |_   _|\r\n    | |_ __ _  __ _  __ _  ___ _ __ __ _| |__ | | ___  | |  | | | |  \r\n    | | \'__| |/ _` |/ _` |/ _ \\ \'__/ _` | \'_ \\| |/ _ \\ | |  | | | |  \r\n    | | |  | | (_| | (_| |  __/ | | (_| | |_) | |  __/ | |__| |_| |_ \r\n    |_|_|  |_|\\__, |\\__, |\\___|_|  \\__,_|_.__/|_|\\___|  \\____/|_____|\r\n               __/ | __/ |                                           \r\n              |___/ |___/                                            \r\n              \r\nTriggerable UI is a component that implements logic on a trigger to\r\ndisplay a UI Container. \r\n\r\nThe goal is to open and close a UI Container using a Trigger\'s events.\r\nThe template can be switched from using a trigger\'s beginOverlapEvent\r\nor interactedEvent to open the UI. It also has the option to lock the \r\nplayer from crouching, moving, or jumping when the UI is open.\r\n\r\n=====\r\nSetup\r\n=====\r\n\r\nDrag the Triggerable UI template into the Hierarchy.\r\n\r\nThe template has a Trigger object that can be transformed to the specific\r\narea that needs to activate the UI.\r\n\r\nThe template has a UI Container object. Edit the children of this container\r\nso it contains the desired UI components. Make sure to not delete the Close Button.\r\n\r\n==========\r\nHow to use\r\n==========\r\n\r\nThe root of the template contains 2 custom properties.\r\n\r\n- DisplayOnOverlap\r\n\r\nIf active, the UI will be displayed when the player enters the trigger.\r\nIf inactive, the UI will be displayed when the player interacts with the trigger.\r\n\r\n- LockPlayer\r\n\r\nIf true, the player will be unable to move, crouch, or jump when the UI is displayed.\r\n\r\n\r\n======\r\nEvents\r\n======\r\n\r\nThe client script has an Event connected so another script can show or hide the UI.\r\n\r\nThe syntax for broadcasting the event is as follows:\r\n\r\nEvents.Broadcast(COMPONENT_ROOT.id .. \".SetUIVisibility\", isVisible))\r\n\r\nSee below an example on how to close the UI with the ESC key.\r\n\r\n=============\r\nExample Usage\r\n=============\r\n\r\n--Seperate client script\r\n--Reference to Triggerable UI root object\r\nlocal TRIGGERABLE_UI = script:GetCustomProperty(\"TriggerableUI\"):WaitForObject()\r\n\r\nfunction OnEscape(localPlayer, params)\r\n    -- Prevents Core\'s default pause from appearing\r\n    params.openPauseMenu = false\r\n\t--Hide the Triggerable UI\r\n    Events.Broadcast(TRIGGERABLE_UI.id .. \".SetUIVisibility\", false)\r\nend\r\n\r\n-- Intercept the ESC key being pressed\r\nInput.escapeHook:Connect(OnEscape)\r\n\r\n]]--"
        CustomParameters {
        }
      }
    }
    Assets {
      Id: 2852566101046937996
      Name: "TriggerableUI_Client"
      PlatformAssetType: 3
      TextAsset {
        Text: "local COMPONENT_ROOT = script:GetCustomProperty(\"ComponentRoot\"):WaitForObject()\r\nlocal TRIGGER = script:GetCustomProperty(\"Trigger\"):WaitForObject()\r\nlocal UICONTAINER = script:GetCustomProperty(\"UIContainer\"):WaitForObject()\r\nlocal CLOSE_BUTTON = script:GetCustomProperty(\"CloseButton\"):WaitForObject()\r\n\r\nlocal DISPLAY_ON_OVERLAP = COMPONENT_ROOT:GetCustomProperty(\"DisplayOnOverlap\")\r\nlocal LOCK_PLAYER = COMPONENT_ROOT:GetCustomProperty(\"LockPlayer\")\r\n\r\nlocal LOCAL_PLAYER = Game.GetLocalPlayer()\r\n\r\nlocal function SetUIVisibility(isVisible)\r\n\tUICONTAINER.visibility = isVisible and Visibility.FORCE_ON or Visibility.FORCE_OFF\r\n\tUI.SetCursorVisible(isVisible)\r\n\tUI.SetCanCursorInteractWithUI(isVisible)\r\n\tif LOCK_PLAYER then\r\n\t\tEvents.BroadcastToServer(isVisible and \"LockPlayer\" or \"UnlockPlayer\")\r\n\tend\r\n\tif not DISPLAY_ON_OVERLAP and not isVisible and TRIGGER:IsOverlapping(LOCAL_PLAYER) then\r\n\t\tTRIGGER.isInteractable = true\r\n\tend\r\nend\r\n\r\nlocal function OnBeginOverlap(trigger, other)\r\n\tif other == LOCAL_PLAYER then\r\n\t\tif DISPLAY_ON_OVERLAP then\r\n\t\t\tSetUIVisibility(true)\r\n\t\telse\r\n\t\t\tTRIGGER.isInteractable = true\r\n\t\tend\r\n\tend\r\nend\r\n\r\nlocal function OnEndOverlap(trigger, other)\r\n\tif other == LOCAL_PLAYER then\r\n\t\tSetUIVisibility(false)\r\n\tend\r\nend\r\n\r\nlocal function OnInteracted(trigger, other)\r\n\tif other == LOCAL_PLAYER then\r\n\t\tSetUIVisibility(true)\r\n\t\tTRIGGER.isInteractable = false\r\n\tend\r\nend\r\n\r\nlocal function OnCloseClicked(button)\r\n\tSetUIVisibility(false)\r\nend\r\n\r\nTRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)\r\nTRIGGER.endOverlapEvent:Connect(OnEndOverlap)\r\n\r\nif not DISPLAY_ON_OVERLAP then\r\n\tTRIGGER.interactedEvent:Connect(OnInteracted)\r\nend\r\n\r\nCLOSE_BUTTON.clickedEvent:Connect(OnCloseClicked)\r\n\r\nEvents.Connect(COMPONENT_ROOT.id .. \".SetUIVisibility\", SetUIVisibility)\r\n"
        CustomParameters {
        }
      }
    }
    Assets {
      Id: 15123898430258676698
      Name: "Triggerable UI"
      PlatformAssetType: 5
      TemplateAsset {
        ObjectBlock {
          RootId: 17950356168669750380
          Objects {
            Id: 17950356168669750380
            Name: "Triggerable UI - Potion Shop Example"
            Transform {
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 4781671109827199097
            ChildIds: 15308339077746048287
            ChildIds: 10791084889762020086
            ChildIds: 2110042125487463487
            UnregisteredParameters {
              Overrides {
                Name: "cs:DisplayOnOverlap"
                Bool: false
              }
              Overrides {
                Name: "cs:LockPlayer"
                Bool: true
              }
              Overrides {
                Name: "cs:DisplayOnOverlap:tooltip"
                String: "Should the UI display when a player enters the trigger. If false, it will only open when the player interacts with the trigger."
              }
              Overrides {
                Name: "cs:LockPlayer:tooltip"
                String: "Should the player be unable to move, jump, or crouch when the UI is visible."
              }
            }
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Folder {
              IsGroup: true
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 15308339077746048287
            Name: "README"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 17950356168669750380
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Script {
              ScriptAsset {
                Id: 12768730457743900369
              }
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 10791084889762020086
            Name: "TriggerableUI_Server"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 17950356168669750380
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Script {
              ScriptAsset {
                Id: 16841168125380120964
              }
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 2110042125487463487
            Name: "ClientContext"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 17950356168669750380
            ChildIds: 10619387704640909431
            ChildIds: 7582966459171349001
            ChildIds: 1049510239406072318
            Collidable_v2 {
              Value: "mc:ecollisionsetting:forceoff"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:forceoff"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            NetworkContext {
              MinDetailLevel {
                Value: "mc:edetaillevel:low"
              }
              MaxDetailLevel {
                Value: "mc:edetaillevel:ultra"
              }
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 10619387704640909431
            Name: "TriggerableUI_Client"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 2110042125487463487
            UnregisteredParameters {
              Overrides {
                Name: "cs:ComponentRoot"
                ObjectReference {
                  SubObjectId: 17950356168669750380
                }
              }
              Overrides {
                Name: "cs:Trigger"
                ObjectReference {
                  SubObjectId: 7582966459171349001
                }
              }
              Overrides {
                Name: "cs:UIContainer"
                ObjectReference {
                  SubObjectId: 1049510239406072318
                }
              }
              Overrides {
                Name: "cs:CloseButton"
                ObjectReference {
                  SubObjectId: 902152545649311712
                }
              }
            }
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Script {
              ScriptAsset {
                Id: 2852566101046937996
              }
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 7582966459171349001
            Name: "Trigger"
            Transform {
              Location {
                X: -47.5737305
                Z: 127.931778
              }
              Rotation {
              }
              Scale {
                X: 2.50886059
                Y: 2.50886059
                Z: 2.50886059
              }
            }
            ParentId: 2110042125487463487
            Collidable_v2 {
              Value: "mc:ecollisionsetting:forceon"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:alwaysvisible"
            }
            Trigger {
              InteractionLabel: "Shop"
              TeamSettings {
                IsTeamCollisionEnabled: true
                IsEnemyCollisionEnabled: true
              }
              TriggerShape_v2 {
                Value: "mc:etriggershape:box"
              }
              InteractionTemplate {
              }
              BreadcrumbTemplate {
              }
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 1049510239406072318
            Name: "UI Container"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 2110042125487463487
            ChildIds: 11706486923762935896
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:forceoff"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              Canvas {
                ContentType {
                  Value: "mc:ecanvascontenttype:dynamic"
                }
                Opacity: 1
                IsHUD: true
                CanvasWorldSize {
                  X: 1024
                  Y: 1024
                }
                RedrawTime: 30
                UseSafeZoneAdjustment: true
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:topleft"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 11706486923762935896
            Name: "UI Image"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 1049510239406072318
            ChildIds: 8924707526231865772
            ChildIds: 902152545649311712
            ChildIds: 16502294095062574447
            ChildIds: 7244304536804250639
            ChildIds: 14981684277462736575
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 500
              Height: 500
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              Image {
                Brush {
                }
                Color {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                TeamSettings {
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
                ScreenshotIndex: 1
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:middlecenter"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:middlecenter"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 8924707526231865772
            Name: "UI Text Box"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 11706486923762935896
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 300
              Height: 100
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              Text {
                Label: "Select One"
                Color {
                  A: 1
                }
                Size: 50
                Justification {
                  Value: "mc:etextjustify:center"
                }
                AutoWrapText: true
                Font {
                  Id: 841534158063459245
                }
                VerticalJustification {
                  Value: "mc:everticaljustification:center"
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
                OutlineColor {
                  A: 1
                }
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:middlecenter"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:middlecenter"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 902152545649311712
            Name: "Close Button"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 11706486923762935896
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 100
              Height: 100
              UIX: -25
              UIY: 25
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              IsHittable: true
              Button {
                FontColor {
                  A: 1
                }
                FontSize: 20
                ButtonColor {
                  R: 1
                  G: 4.37100709e-07
                  A: 1
                }
                HoveredColor {
                  R: 0.62
                  A: 1
                }
                PressedColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                DisabledColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                Brush {
                  Id: 18435662122406941624
                }
                IsButtonEnabled: true
                ClickMode {
                  Value: "mc:ebuttonclickmode:default"
                }
                Font {
                }
                Justification {
                  Value: "mc:etextjustify:center"
                }
                VerticalJustification {
                  Value: "mc:everticaljustification:center"
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:topright"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:topright"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 16502294095062574447
            Name: "UI Button"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 11706486923762935896
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 100
              Height: 100
              UIX: 25
              UIY: -25
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              IsHittable: true
              Button {
                FontColor {
                  A: 1
                }
                FontSize: 20
                ButtonColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                HoveredColor {
                  R: 0.547000051
                  G: 0.547000051
                  B: 0.547000051
                  A: 1
                }
                PressedColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                DisabledColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                Brush {
                  Id: 9581362795719031457
                }
                IsButtonEnabled: true
                ClickMode {
                  Value: "mc:ebuttonclickmode:default"
                }
                Font {
                }
                Justification {
                  Value: "mc:etextjustify:center"
                }
                VerticalJustification {
                  Value: "mc:everticaljustification:center"
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:bottomleft"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:bottomleft"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 7244304536804250639
            Name: "UI Button"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 11706486923762935896
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 100
              Height: 100
              UIY: -25
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              IsHittable: true
              Button {
                FontColor {
                  A: 1
                }
                FontSize: 20
                ButtonColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                HoveredColor {
                  R: 0.547000051
                  G: 0.547000051
                  B: 0.547000051
                  A: 1
                }
                PressedColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                DisabledColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                Brush {
                  Id: 10501665310126333750
                }
                IsButtonEnabled: true
                ClickMode {
                  Value: "mc:ebuttonclickmode:default"
                }
                Font {
                }
                Justification {
                  Value: "mc:etextjustify:center"
                }
                VerticalJustification {
                  Value: "mc:everticaljustification:center"
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:bottomcenter"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:bottomcenter"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 14981684277462736575
            Name: "UI Button"
            Transform {
              Location {
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 11706486923762935896
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Control {
              Width: 100
              Height: 100
              UIX: -25
              UIY: -25
              RenderTransformPivot {
                Anchor {
                  Value: "mc:euianchor:middlecenter"
                }
              }
              IsHittable: true
              Button {
                FontColor {
                  A: 1
                }
                FontSize: 20
                ButtonColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                HoveredColor {
                  R: 0.547000051
                  G: 0.547000051
                  B: 0.547000051
                  A: 1
                }
                PressedColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                DisabledColor {
                  R: 1
                  G: 1
                  B: 1
                  A: 1
                }
                Brush {
                  Id: 7834094191110061855
                }
                IsButtonEnabled: true
                ClickMode {
                  Value: "mc:ebuttonclickmode:default"
                }
                Font {
                }
                Justification {
                  Value: "mc:etextjustify:center"
                }
                VerticalJustification {
                  Value: "mc:everticaljustification:center"
                }
                ShadowColor {
                  A: 1
                }
                ShadowOffset {
                }
              }
              AnchorLayout {
                SelfAnchor {
                  Anchor {
                    Value: "mc:euianchor:bottomright"
                  }
                }
                TargetAnchor {
                  Anchor {
                    Value: "mc:euianchor:bottomright"
                  }
                }
              }
            }
            IsReplicationEnabledByDefault: true
          }
        }
        PrimaryAssetId {
          AssetType: "None"
          AssetId: "None"
        }
      }
    }
    Assets {
      Id: 7834094191110061855
      Name: "Fantasy Spell Potion 008"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "UI_Fantasy_Potion_008"
      }
    }
    Assets {
      Id: 10501665310126333750
      Name: "Fantasy Spell Potion 006"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "UI_Fantasy_Potion_006"
      }
    }
    Assets {
      Id: 9581362795719031457
      Name: "Fantasy Spell Potion 005"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "UI_Fantasy_Potion_005"
      }
    }
    Assets {
      Id: 18435662122406941624
      Name: "Icon Close"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "Icon_Close"
      }
    }
    Assets {
      Id: 6907996033184907708
      Name: "Potion Shop"
      PlatformAssetType: 5
      TemplateAsset {
        ObjectBlock {
          RootId: 16457722667709006352
          Objects {
            Id: 16457722667709006352
            Name: "Potion Shop"
            Transform {
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 4781671109827199097
            ChildIds: 14382171568039465677
            ChildIds: 3388578297777461539
            ChildIds: 9829783398670653228
            ChildIds: 3355821648734970136
            ChildIds: 16035380618076094655
            ChildIds: 6231488764281393197
            ChildIds: 1477290076161858351
            ChildIds: 5342600621614751334
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Folder {
              IsGroup: true
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 14382171568039465677
            Name: "Container - Rectangle"
            Transform {
              Location {
                X: 206.368286
                Y: 0.618249893
                Z: 38.5874023
              }
              Rotation {
                Yaw: 89.9999847
                Roll: 89.9999847
              }
              Scale {
                X: 3.96910262
                Y: 3.96910262
                Z: 3.96910262
              }
            }
            ParentId: 16457722667709006352
            UnregisteredParameters {
              Overrides {
                Name: "ma:Shared_BaseMaterial:id"
                AssetReference {
                  Id: 2396282117577594594
                }
              }
            }
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            CoreMesh {
              MeshAsset {
                Id: 7129902991243121338
              }
              Teams {
                IsTeamCollisionEnabled: true
                IsEnemyCollisionEnabled: true
              }
              DisableCastShadows: true
              StaticMesh {
                Physics {
                  Mass: 100
                  LinearDamping: 0.01
                }
                BoundsScale: 1
              }
            }
            Relevance {
              Value: "mc:eproxyrelevance:critical"
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 3388578297777461539
            Name: "Humanoid 2 Rig"
            Transform {
              Location {
                X: 4.95050049
                Y: -2.43226981
                Z: 105.000084
              }
              Rotation {
                Yaw: -179.945374
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 16457722667709006352
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            CoreMesh {
              MeshAsset {
                Id: 726553706546471658
              }
              Teams {
                IsTeamCollisionEnabled: true
                IsEnemyCollisionEnabled: true
              }
              DisableCastShadows: true
              AnimatedMesh {
                AnimationStance: "unarmed_idle_relaxed"
                AnimationStancePlaybackRate: 1
                AnimationStanceShouldLoop: true
                AnimationPlaybackRateMultiplier: 1
                PlayOnStartAnimation {
                  PlaybackRate: 1
                }
                SkinnedMeshes {
                  Id: 17002392688594592600
                }
                SkinnedMeshes {
                  Id: 841534158063459245
                }
                SkinnedMeshes {
                  Id: 841534158063459245
                }
                SkinnedMeshes {
                  Id: 841534158063459245
                }
              }
            }
            Relevance {
              Value: "mc:eproxyrelevance:critical"
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 9829783398670653228
            Name: "Table Assembled"
            Transform {
              Location {
                X: -129.331421
                Y: 0.618249893
              }
              Rotation {
                Yaw: 89.9999924
              }
              Scale {
                X: 0.558718
                Y: 0.558718
                Z: 0.558718
              }
            }
            ParentId: 16457722667709006352
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            CoreMesh {
              MeshAsset {
                Id: 8205404329062407317
              }
              Teams {
                IsTeamCollisionEnabled: true
                IsEnemyCollisionEnabled: true
              }
              StaticMesh {
                Physics {
                  Mass: 100
                  LinearDamping: 0.01
                }
                BoundsScale: 1
              }
            }
            Relevance {
              Value: "mc:eproxyrelevance:critical"
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 3355821648734970136
            Name: "Bottle 01"
            Transform {
              Location {
                X: -142.14679
                Y: -77.8716812
                Z: 76.2215881
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 16457722667709006352
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            CoreMesh {
              MeshAsset {
                Id: 9828719528625429874
              }
              Teams {
                IsTeamCollisionEnabled: true
                IsEnemyCollisionEnabled: true
              }
              StaticMesh {
                Physics {
                  Mass: 100
                  LinearDamping: 0.01
                }
                BoundsScale: 1
              }
            }
            Relevance {
              Value: "mc:eproxyrelevance:critical"
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 16035380618076094655
            Name: "Bottle 02"
            Transform {
              Location {
                X: -136.815918
                Y: -2.56852531
                Z: 76.221611
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 16457722667709006352
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            CoreMesh {
              MeshAsset {
                Id: 172624577138089059
              }
              Teams {
                IsTeamCollisionEnabled: true
                IsEnemyCollisionEnabled: true
              }
              StaticMesh {
                Physics {
                  Mass: 100
                  LinearDamping: 0.01
                }
                BoundsScale: 1
              }
            }
            Relevance {
              Value: "mc:eproxyrelevance:critical"
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 6231488764281393197
            Name: "Bottle 03"
            Transform {
              Location {
                X: -131.391846
                Y: 80.3994751
                Z: 76.2215881
              }
              Rotation {
              }
              Scale {
                X: 1
                Y: 1
                Z: 1
              }
            }
            ParentId: 16457722667709006352
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            CoreMesh {
              MeshAsset {
                Id: 5616872426686370716
              }
              Teams {
                IsTeamCollisionEnabled: true
                IsEnemyCollisionEnabled: true
              }
              StaticMesh {
                Physics {
                  Mass: 100
                  LinearDamping: 0.01
                }
                BoundsScale: 1
              }
            }
            Relevance {
              Value: "mc:eproxyrelevance:critical"
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 1477290076161858351
            Name: "Cube"
            Transform {
              Location {
                X: 166.677246
                Y: 0.618249893
                Z: 283.564728
              }
              Rotation {
              }
              Scale {
                X: 0.0605350882
                Y: 1.74054694
                Z: 1.74054694
              }
            }
            ParentId: 16457722667709006352
            UnregisteredParameters {
              Overrides {
                Name: "ma:Shared_BaseMaterial:id"
                AssetReference {
                  Id: 10184847056121543272
                }
              }
            }
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            CoreMesh {
              MeshAsset {
                Id: 12095835209017042614
              }
              Teams {
                IsTeamCollisionEnabled: true
                IsEnemyCollisionEnabled: true
              }
              StaticMesh {
                Physics {
                  Mass: 100
                  LinearDamping: 0.01
                }
                BoundsScale: 1
              }
            }
            Relevance {
              Value: "mc:eproxyrelevance:critical"
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
          Objects {
            Id: 5342600621614751334
            Name: "World Text"
            Transform {
              Location {
                X: 161.689575
                Y: 0.618249893
                Z: 276.329742
              }
              Rotation {
                Yaw: -179.999985
              }
              Scale {
                X: 2.85518575
                Y: 2.85518575
                Z: 2.85518575
              }
            }
            ParentId: 16457722667709006352
            Collidable_v2 {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            Visible_v2 {
              Value: "mc:evisibilitysetting:inheritfromparent"
            }
            CameraCollidable {
              Value: "mc:ecollisionsetting:inheritfromparent"
            }
            EditorIndicatorVisibility {
              Value: "mc:eindicatorvisibility:visiblewhenselected"
            }
            Text {
              Text: "POTION\r\nSHOP"
              FontAsset {
                Id: 2730088814289383420
              }
              Color {
                A: 1
              }
              HorizontalAlignment {
                Value: "mc:ecoretexthorizontalalign:center"
              }
              VerticalAlignment {
                Value: "mc:ecoretextverticalalign:center"
              }
            }
            NetworkRelevanceDistance {
              Value: "mc:eproxyrelevance:critical"
            }
            IsReplicationEnabledByDefault: true
          }
        }
        PrimaryAssetId {
          AssetType: "None"
          AssetId: "None"
        }
      }
    }
    Assets {
      Id: 2730088814289383420
      Name: "Teko Bold"
      PlatformAssetType: 28
      PrimaryAsset {
        AssetType: "FontAssetRef"
        AssetId: "TekoBold_ref"
      }
    }
    Assets {
      Id: 10184847056121543272
      Name: "Basic Material"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "mi_basic_pbr_material_001"
      }
    }
    Assets {
      Id: 12095835209017042614
      Name: "Cube"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_cube_002"
      }
    }
    Assets {
      Id: 5616872426686370716
      Name: "Bottle 03"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_prop_fantasy_bottle_003"
      }
    }
    Assets {
      Id: 172624577138089059
      Name: "Bottle 02"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_prop_fantasy_bottle_002"
      }
    }
    Assets {
      Id: 9828719528625429874
      Name: "Bottle 01"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_prop_fantasy_bottle_001"
      }
    }
    Assets {
      Id: 8205404329062407317
      Name: "Table Assembled"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_table_001"
      }
    }
    Assets {
      Id: 17002392688594592600
      Name: "Humanoid 2 Karl"
      PlatformAssetType: 26
      PrimaryAsset {
        AssetType: "SkinnedMeshAssetRef"
        AssetId: "npc_human_guy_head_basic_004_ref"
      }
    }
    Assets {
      Id: 726553706546471658
      Name: "Humanoid 2 Rig"
      PlatformAssetType: 25
      PrimaryAsset {
        AssetType: "SkeletonAssetRef"
        AssetId: "npc_guy_wireframe_001_ref"
      }
    }
    Assets {
      Id: 2396282117577594594
      Name: " Wood 9 Slice Crate 01"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "mat_advanced_9slice_wooden_crates_001_ref"
      }
    }
    Assets {
      Id: 7129902991243121338
      Name: "Container - Rectangle"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_container_rectangle_ref"
      }
    }
    Assets {
      Id: 736360303936294653
      Name: "Default Bindings"
      PlatformAssetType: 29
      BindingSetAsset {
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:spacebar"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:a"
              }
            }
          }
          Action: "Jump"
          Description: "Make the character jump."
          CoreBehavior {
            Value: "mc:ecorebehavior:jump"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:leftcontrol"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:c"
              }
              Controller {
                Value: "mc:ebindinggamepad:b"
              }
            }
          }
          Action: "Crouch"
          Description: "Enter crouch mode."
          CoreBehavior {
            Value: "mc:ecorebehavior:crouch"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:g"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:dpadup"
              }
            }
          }
          Action: "Mount"
          Description: "Enter mount mode."
          CoreBehavior {
            Value: "mc:ecorebehavior:mount"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:f"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:x"
              }
            }
          }
          Action: "Interact"
          Description: "Interact with triggers."
          CoreBehavior {
            Value: "mc:ecorebehavior:interact"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:enter"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:none"
              }
            }
          }
          Action: "Chat"
          Description: "Opens chat dialog and social menu."
          CoreBehavior {
            Value: "mc:ecorebehavior:chat"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:tilde"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:middleclick"
              }
              Controller {
                Value: "mc:ebindinggamepad:view"
              }
            }
          }
          Action: "Slot Picker"
          Description: "Reopens last opened picker menu."
          CoreBehavior {
            Value: "mc:ecorebehavior:slotpicker"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:directional"
          }
          DirectionalBindingData {
            UpInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:w"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftstickup"
              }
            }
            LeftInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:a"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftstickleft"
              }
            }
            DownInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:s"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftstickdown"
              }
            }
            RightInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:d"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftstickright"
              }
            }
          }
          Action: "Move"
          Description: "Moves the character."
          CoreBehavior {
            Value: "mc:ecorebehavior:move"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:axis"
          }
          AxisBindingData {
            IncreaseInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:spacebar"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:a"
              }
            }
            DecreaseInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:leftcontrol"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:c"
              }
              Controller {
                Value: "mc:ebindinggamepad:b"
              }
            }
          }
          Action: "Move Vertically"
          Description: "Fly or swim vertically up and down."
          CoreBehavior {
            Value: "mc:ecorebehavior:movevertically"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:directional"
          }
          DirectionalBindingData {
            UpInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:mouseup"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:rightstickup"
              }
            }
            LeftInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:mouseleft"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:rightstickleft"
              }
            }
            DownInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:mousedown"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:rightstickdown"
              }
            }
            RightInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:mouseright"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:rightstickright"
              }
            }
          }
          Action: "Look"
          Description: "Controls the camera."
          CoreBehavior {
            Value: "mc:ecorebehavior:look"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:axis"
          }
          AxisBindingData {
            IncreaseInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:scrolldown"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:rightbumper"
              }
            }
            DecreaseInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:scrollup"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftbumper"
              }
            }
          }
          Action: "Zoom"
          Description: "Zoom in or out with the camera."
          CoreBehavior {
            Value: "mc:ecorebehavior:zoom"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:leftalt"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:none"
              }
            }
          }
          Action: "Push-to-Talk"
          Description: "Toggle voice chat mode."
          CoreBehavior {
            Value: "mc:ecorebehavior:pushtotalk"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:leftclick"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:righttrigger"
              }
            }
          }
          Action: "Shoot"
          Description: "Shoot ability of weapon or equipment."
          CoreBehavior {
            Value: "mc:ecorebehavior:weapon"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:rightclick"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:lefttrigger"
              }
            }
          }
          Action: "Aim"
          Description: "Weapon or equipment aiming."
          CoreBehavior {
            Value: "mc:ecorebehavior:weapon"
          }
          Networked: true
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:r"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:y"
              }
            }
          }
          Action: "Reload"
          Description: "Reload ability on weapons."
          CoreBehavior {
            Value: "mc:ecorebehavior:weapon"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:leftclick"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:x"
              }
            }
          }
          Action: "Attack"
          Description: "Attack ability for melee weapons or equipment."
          CoreBehavior {
            Value: "mc:ecorebehavior:equipment"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:w"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:righttrigger"
              }
            }
          }
          Action: "Vehicle Accelerate"
          Description: "When driving, accelerate forward."
          CoreBehavior {
            Value: "mc:ecorebehavior:vehicleaccelerate"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:s"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:lefttrigger"
              }
            }
          }
          Action: "Vehicle Reverse"
          Description: "When driving, stop the vehicle and reverse."
          CoreBehavior {
            Value: "mc:ecorebehavior:vehiclereverse"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:axis"
          }
          AxisBindingData {
            IncreaseInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:d"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftstickright"
              }
            }
            DecreaseInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:a"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:leftstickleft"
              }
            }
          }
          Action: "Vehicle Turn"
          Description: "When driving, turn the vehicle."
          CoreBehavior {
            Value: "mc:ecorebehavior:vehicleturn"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:spacebar"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:b"
              }
            }
          }
          Action: "Vehicle Handbrake"
          Description: "When driving, apply the handbrake."
          CoreBehavior {
            Value: "mc:ecorebehavior:vehiclehandbrake"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:leftclick"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:a"
              }
            }
          }
          Action: "Vehicle Shoot"
          Description: "Shoot ability on vehicle."
          CoreBehavior {
            Value: "mc:ecorebehavior:vehicle"
          }
          IsEnabledOnStart: true
        }
        Bindings {
          BindingType {
            Value: "mc:ebindingtype:basic"
          }
          BasicBindingData {
            BasicInputs {
              KeyboardPrimary {
                Value: "mc:ebindingkeyboard:f"
              }
              KeyboardSecondary {
                Value: "mc:ebindingkeyboard:none"
              }
              Controller {
                Value: "mc:ebindinggamepad:x"
              }
            }
          }
          Action: "Vehicle Exit"
          Description: "When driving, exit the vehicle."
          CoreBehavior {
            Value: "mc:ecorebehavior:vehicleexit"
          }
          IsEnabledOnStart: true
        }
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  Marketplace {
    Id: "1603f65819f44945884f17099824a123"
    OwnerAccountId: "bd602d5201b04b3fbf7be10f59c8f974"
    OwnerName: "CoreAcademy"
  }
  SerializationVersion: 119
}
IncludesAllDependencies: true
