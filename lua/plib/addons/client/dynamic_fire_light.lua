plib.Require( 'dynamic_light' )

timer.Create('PLib - Dynamic Fire Light', 0.25, 0, function()
	for _, ent in ipairs( ents.GetAll() ) do
		if ent:IsOnFire() or (ent:GetClass() == 'env_fire') then
			local light = ent.DynamicFireLight
			if IsValid( light ) then
				light:SetPos( ent:LocalToWorld( ent:OBBCenter() ) )
			else
				local new = CreateDynamicLight( ent:EntIndex() )
				if IsValid( new ) then
					ent.DynamicFireLight = new
					new:SetColorUnpacked( 255, 100, 0 )
					new:SetBrightness( 1 )
					new:SetSize( 128 )
				end
			end
		else
			local light = ent.DynamicFireLight
			if IsValid( light ) then
				light:Remove()
			end
		end
	end
end)

hook.Add('EntityRemoved', 'PLib - Dynamic Fire Light', function( ent )
	local light = ent.DynamicFireLight
	if IsValid( light ) then
		light:Remove()
	end
end)