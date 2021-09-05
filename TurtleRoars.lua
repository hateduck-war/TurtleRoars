-- 26 AUG 2021
-- Turtle Wow Functions to listen for /roar emote
-- Handle event and play proper soundfile

--===============================================================================
--==                    Global Variables                                       ==
--===============================================================================
tr_enable = true

--===============================================================================
--==                    Slash Command Registry                                 ==
--===============================================================================
function TurtleRoars_OnLoad()
	-- Use TR short for turtle roar
	SLASH_TURTLEROAR1 = "/tr"
	local function trSlashCommand(msg, editbox)
		SlashCommandHandler(msg)
	end
	
	-- Register function to slash command
	SlashCmdList["TURTLEROAR"] = SlashCommandHandler

	TurtleRoarsMain:RegisterEvent("CHAT_MSG_TEXT_EMOTE")
	TurtleRoarsMain:RegisterEvent("CHAT_MSG_EMOTE")

	TurtleRoarPrintHelp()
end

--===============================================================================
--==                    CLI Functions                                          ==
--===============================================================================
function SlashCommandHandler(msg)
	

    if msg == "disable" then
    	tr_enable = false
    	printf("Disabling  /roar Sounds")
    elseif msg == "enable" then
    	tr_enable = true
    	printf("Enabling  /roar Sounds")
    else
    	-- print usage if no args to /tr
		TurtleRoarPrintHelp()
    end
end

function TurtleRoarPrintHelp()
	printColors(cSEXGREEN, "TurtleRoars Loaded! /roar and /e emotes with\n the word 'roar' in them will trigger a race/sex based\nsound effect")
	printColors(cSEXGREEN, "/tr enable - Turns on /roar sounds")
	printColors(cSEXGREEN, "/tr disable - Turns off /roar sounds")
end


--===============================================================================
--==                    Event Handling                                         ==
--===============================================================================
function TurtleRoars_OnEvent()
	--event, arg1, arg2 variables passed in by frame
	--arg1 = Text of the emote example: You roar with bestial vigor. So fierce!
	--arg2 = Player Name that emoted. example: Souldoubt
    
    --printf(event)
	-- if arg1 ~= nil then
	-- 	printf(arg1)
	-- end

	-- if arg2 ~= nil then
	-- 	printf(arg2)
	-- end

	-- if arg3 ~= nil then
	-- 	printf(arg3)
	-- end

	-- Don't handle Events, if user disabled TurtleRoars.
	if not tr_enable then
		return
	end


   
    -- CHAT_MSG_TEXT_EMOTE is /roar. 
    -- CHAT_MSG_EMOTE is custom emote using /e that contains the word roar
	if event == "CHAT_MSG_TEXT_EMOTE" or event=="CHAT_MSG_EMOTE" then
		
		incoming_emote_str = string.lower(arg1)
		
		-- Make sure that was a roar we just heard.
		if string.find(incoming_emote_str, "roar") ~= nil then
			--arg2 is player name that roared
			DoRoar(arg2)
		end
		
	end
end

-- This function has to target the roarer
-- Figure out Sex/Race to play the right sound file
-- Then targets last target. Could cause issues if heavy roaring
-- during combat. Happens so fast, none encountered in testing.
function DoRoar(roarer_name)
	TargetByName(roarer_name)
	roar_sex = UnitSex("target")
	roar_race = UnitRace("target")
	TargetLastTarget()
	
	--printf("A "..roar_race.." "..roar_sex.." just let out a roar!")
   
    if roar_sex == 2 then
    	roar_sex = "male"
    else
    	-- Technically Female is 3, and "unknown is 1"
    	-- Let's just scream like a female if we don't know
    	roar_sex = "female"
    end
	   
    roar_race = string.lower(roar_race)
    roar_race = string.gsub(roar_race, "%s+", "")
    local roar_file_name = roar_race.."_"..roar_sex.."_roar.mp3"

    --printf("Roar File: "..roar_file_name)
	PlaySoundFile("Interface\\AddOns\\TurtleRoars\\roar_sounds\\"..roar_file_name)
end

--===============================================================================
--==                    Utility Functions                                      ==
--===============================================================================
function printf(guts)
	DEFAULT_CHAT_FRAME:AddMessage(guts);
end

function printColors(hex, guts)
	DEFAULT_CHAT_FRAME:AddMessage("|"..hex..guts);	
end


--======================= Color Codes for print color ==============================================

cLIGHTRED     	=	"cffff6060"
cLIGHTBLUE    	=	"cff00ccff"
cTORQUISEBLUE	=	"cff00C78C"
cSPRINGGREEN	=	"cff00FF7F"
cGREENYELLOW  	=	"cffADFF2F"
cBLUE         	=	"cff0000ff"
cPURPLE			=	"cffDA70D6"
cGREEN	    	=	"cff00ff00"
cRED          	=	"cffff0000"
cGOLD         	=	"cffffcc00"
cGOLD2			=	"cffFFC125"
cGREY         	=	"cff888888"
cWHITE        	=	"cffffffff"
cSUBWHITE     	=	"cffbbbbbb"
cMAGENTA      	=	"cffff00ff"
cYELLOW       	=	"cffffff00"
cORANGEY		=	"cffFF4500"
cCHOCOLATE		=	"cffCD661D"
cCYAN         	=	"cff00ffff"
cIVORY			=	"cff8B8B83"
cLIGHTYELLOW	=	"cffFFFFE0"
cSEXGREEN		=	"cff71C671"
cSEXTEAL		=	"cff388E8E"
cSEXPINK		=	"cffC67171"
cSEXBLUE		=	"cff00E5EE"
cSEXHOTPINK		=	"cffFF6EB4"