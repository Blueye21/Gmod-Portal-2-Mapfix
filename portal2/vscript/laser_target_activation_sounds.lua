PowerUpSound = "Portal:button_down"
PowerDownSound = "coast:combine_apc_shutdown"

-- Precache sounds we will emit
function Precache()
	self:PrecacheSoundScript( PowerUpSound )
	self:PrecacheSoundScript( PowerDownSound )
end

function OnPostSpawn()	
	self:ConnectOutput( "OnPowered", "OnPowered" )
	self:ConnectOutput( "OnUnpowered", "OnUnpowered" )
end

function OnPowered()
	PlayPoweredSound()	
end

function OnUnpowered()
	PlayUnpoweredSound()
end

function PlayPoweredSound()
	self:EmitSound( PowerUpSound )
end

function PlayUnpoweredSound()
	self:EmitSound( PowerDownSound )
end