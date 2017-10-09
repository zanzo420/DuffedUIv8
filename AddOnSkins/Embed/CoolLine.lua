local AS = unpack(AddOnSkins)

if AS:CheckAddOn('CoolLine') then
	function AS:Embed_CoolLine()
		if not CoolLineDB.vertical then
			if AS:CheckAddon('ElvUI') then
				CoolLine:SetPoint('BOTTOMRIGHT', ElvUI_Bar1, 'TOPRIGHT', 0, 4)
				CoolLine:SetPoint("BOTTOMLEFT", ElvUI_Bar1, "TOPLEFT", 0, 4)
			elseif AS:CheckAddon('Tukui') then
				local function OnShow()
					CoolLine:Point('BOTTOM', AS.ActionBar4, 'TOP', 0, 1)
					CoolLineDB.h = ActionButton1:GetHeight()
					CoolLineDB.w = AS.ActionBar4:GetWidth()
					CoolLine.updatelook()
				end

				local function OnHide()
					CoolLine:Point('BOTTOM', AS.ActionBar1, 'TOP', 0, 1)
					CoolLineDB.h = ActionButton1:GetHeight()
					CoolLineDB.w = AS.ActionBar1:GetWidth()
					CoolLine.updatelook()
				end

				if AS.ActionBar4:IsShown() then
					OnShow()
				else
					OnHide()
				end

				AS.ActionBar4:HookScript('OnShow', OnShow)
				AS.ActionBar4:HookScript('OnHide', OnHide)
				CoolLine.updatelook()
			elseif AS:CheckAddOn('DuffedUI') then
				CoolLine:Point('BOTTOM', AS.ActionBar2, 'TOP', 0, 3)
				CoolLineDB.h = ActionButton1:GetHeight()
				CoolLineDB.w = AS.ActionBar2:GetWidth()
			end
		end
	end
end