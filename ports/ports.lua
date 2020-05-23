--[[
  written by topkek
--]]
local AddOn, config = ...
local frame = CreateFrame("Frame")
frame:RegisterEvent("CHAT_MSG_WHISPER")
frame:RegisterEvent("CHAT_MSG_YELL")
frame:RegisterEvent("CHAT_MSG_SAY")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
local enabled = false

function filterPorts(msg)
  local keywords = config.keywords
  for i = 1, #keywords do
    if string.match(msg, keywords[i]) then
      return true
    end
  end
  if string.match(msg, "uc") and #msg == 2 then
    return true
  end
  return false
end

function wantsPort(msg, sender)
  if filterPorts(msg) then
    InviteToGroup(sender)
  end
end

function handleEvents(self, event, msg, sender)
  if enabled then
    if event == "CHAT_MSG_SAY" or event == "CHAT_MSG_YELL" or event == "CHAT_MSG_WHISPER" then
      wantsPort(msg:lower(), sender)
    end
    ConvertToRaid()
  end
end

frame:SetScript("OnEvent", handleEvents)

function slashCommand(msg)
  enabled = not enabled
  if enabled then
    print("Ports enabled")
  else
    print("Ports disabled")
  end
end

SLASH_PORTS1 = "/port"
SLASH_PORTS2 = "/ports"
SlashCmdList["PORTS"] = slashCommand
