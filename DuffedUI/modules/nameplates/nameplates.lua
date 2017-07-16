local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local f, fs, ff = C["media"]["font"], 8, "THINOUTLINE"
local nWidth, nHeight = C["nameplate"]["platewidth"], C["nameplate"]["plateheight"]
local pScale = C["nameplate"]["platescale"]
local threat = C["nameplate"]["threat"]
local backdrop = {
	bgFile = C["media"].blank,
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

D["ConstructNameplates"] = function(self)
	-- Initial Elements
	self.colors = D["UnitColor"]

	-- health
	local health = CreateFrame("StatusBar", nil, self)
	health:SetAllPoints()
	health:SetStatusBarTexture(texture)
	health.colorTapping = true
	health.colorReaction = true
	health.frequentUpdates = true
	health.Smooth = true
	if C["nameplate"]["classcolor"] then
		health.colorClass = true
	else
		health.colorClass = false
	end

	-- health border
	local HealthBorder = CreateFrame("Frame", nil, health)
	HealthBorder:Point("TOPLEFT", health, "TOPLEFT", -1, 1)
	HealthBorder:Point("BOTTOMRIGHT", health, "BOTTOMRIGHT", 1, -1)
	HealthBorder:SetTemplate("Transparent")
	HealthBorder:SetFrameLevel(2)
	self.HealthBorder = HealthBorder

	-- background
	bg = health:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetColorTexture(.2, .2, .2)

	-- name
	name = health:CreateFontString(nil, "OVERLAY")
	name:Point("LEFT", health, "LEFT", 0, 10)
	name:SetJustifyH("LEFT")
	name:SetFont(f, fs, ff)
	name:SetShadowOffset(1.25, -1.25)
	self:Tag(name, "[difficulty][level][shortclassification] [DuffedUI:getnamecolor][DuffedUI:namelong]")

	-- debuffs
	local debuffs = CreateFrame("Frame", "NameplateDebuffs", self)
	debuffs:SetPoint("BOTTOMLEFT", health, "TOPLEFT", 0, 15)
	debuffs:SetSize(nWidth, 15)
	debuffs.size = 15
	debuffs.num = 5
	debuffs.filter = "HARMFUL|INCLUDE_NAME_PLATE_ONLY"
	debuffs.spacing = 4
	debuffs.initialAnchor = "TOPLEFT"
	debuffs["growth-y"] = "UP"
	debuffs["growth-x"] = "RIGHT"
	debuffs.PostCreateIcon = D.PostCreateAura
	debuffs.PostUpdateIcon = D.PostUpdateAura

	-- castbar
	local castbar = CreateFrame("StatusBar", self:GetName() .. "CastBar", self)
	castbar:SetStatusBarTexture(texture)
	castbar:Width(nWidth - 2)
	castbar:Height(5)
	castbar:Point("TOP", health, "BOTTOM", 0, -4)

	castbar.CustomTimeText = D["CustomTimeText"]
	castbar.CustomDelayText = CustomDelayText
	castbar.PostCastStart = D["CastBar"]
	castbar.PostChannelStart = D["CastBar"]

	castbar.time = castbar:CreateFontString(nil, "OVERLAY")
	castbar.time:SetFont(f, 6, ff)
	castbar.time:Point("RIGHT", castbar, "RIGHT", -5, 0)
	castbar.time:SetTextColor(.84, .75, .65)
	castbar.time:SetJustifyH("RIGHT")

	castbar.Text = castbar:CreateFontString(nil, "OVERLAY")
	castbar.Text:SetFont(f, 6, ff)
	castbar.Text:Point("LEFT", castbar, "LEFT", 6, 0)
	castbar.Text:SetTextColor(.84, .75, .65)
	castbar:CreateBackdrop()

	castbar.button = CreateFrame("Frame", nil, castbar)
	castbar.button:SetTemplate("Default")

	castbar.button:Size(nHeight + 12)
	castbar.button:Point("BOTTOMLEFT", castbar, "BOTTOMRIGHT", 3, -2)
	castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
	castbar.icon:Point("TOPLEFT", castbar.button, 2, -2)
	castbar.icon:Point("BOTTOMRIGHT", castbar.button, -2, 2)
	castbar.icon:SetTexCoord(unpack(D["IconCoord"]))

	-- threat
	if threat then
	
	end

	-- size
	self:SetSize(nWidth, nHeight)
	self:SetPoint("CENTER", 0, 0)
	self:SetScale(pScale * UIParent:GetScale())

	-- Init
	self.Health = health
	self.Name = name
	self.Debuffs = debuffs
	self.Castbar = castbar
	self.Castbar.Time = castbar.time
	self.Castbar.Icon = castbar.icon
end