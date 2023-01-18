plib.Require( 'dynamic_light' )

local CreateDynamicLight = CreateDynamicLight
local hook_Add = hook.Add
local IsValid = IsValid
local ipairs = ipairs

local function isFireGlowed( ent )
	return ent:IsOnFire() or ent:GetClass() == 'env_fire'
end

timer.Create('PLib - Dynamic Fire Light', 0.25, 0, function()
	for _, ent in ipairs( ents.GetAll() ) do
		if isFireGlowed( ent ) then
			local light = ent.DynamicFireLight
			if IsValid( light ) then
				light:SetPos( ent:LocalToWorld( ent:OBBCenter() ) )
				return
			end

			local new = CreateDynamicLight()
			if IsValid( new ) then
				ent.DynamicFireLight = new
				new:SetColorUnpacked( 255, 100, 0 )
				new:SetBrightness( 1 )
				new:SetSize( 128 )

				hook_Add('Think', new, function( self )
					if IsValid( ent ) and isFireGlowed( ent ) then return end
					self:Remove()
				end)
			end
		end
	end
end)