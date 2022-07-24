import std/strformat
import random
import wNim

type
    MenuID = enum
        idQuit = wIdUser
        idPet, idWait, idShowHappiness

#App vars
let app = App()
let frame = Frame(title="Gui Pet", size=(350,350))
let panel = Panel(frame)
let menuBar = MenuBar(frame)

#Options vars
var isShowHappiness = "false"

#InteractionsMenu vars
let InteractionsMenu = Menu(menuBar, "Interactions")
let action_pet = InteractionsMenu.append(idPet, "Pet")
InteractionsMenu.appendSeparator()
let action_wait = InteractionsMenu.append(idWait, "Wait")
InteractionsMenu.appendSeparator()
let action_quit = InteractionsMenu.append(idQuit, "Quit")
InteractionsMenu.appendSeparator()

#OptionsMenu vars
let OptionsMenu = Menu(menuBar, "Options")
OptionsMenu.appendCheckItem(idShowHappiness, "Show happiness")
OptionsMenu.appendSeparator()

#Pet Vars
var label = StaticText(panel, label=":)")
var happyness = 50

#App loop
frame.wEvent_Menu do (event: wEvent):
    #Interaction menu events
    if event.id == idQuit:
        frame.close()
    if event.id == idPet:
        happyness += rand(5) + 3
        if happyness > 100:
            happyness = 100
    if event.id == idWait:
        happyness -= rand(8) - 2
        if happyness < 0:
            happyness = 0

    happyness -= rand(2)
    if happyness < 0:
        happyness = 0
    
    #Options menu events
    isShowHappiness = $menuBar.isChecked(idShowHappiness)
    if isShowHappiness == "true":
        echo fmt"Happyness is {happyness}%"

    if happyness > 66:
        echo "Im Happy"
        label = StaticText(panel, label=":)")
    elif happyness < 33:
        echo "Im Sad"
        label = StaticText(panel, label=":(")
    else:
        echo "Im Mild"
        label = StaticText(panel, label=":|")
    
    label.center()
    frame.show()

label.center()
frame.center()
frame.show()

app.mainLoop()
