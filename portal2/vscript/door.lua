is_portal_door = true

number_buttons_total = 0
number_buttons_pressed = 0

function IncrementTotalButtons()
	number_buttons_total = number_buttons_total + 1
end

function CloseButton()
	number_buttons_pressed = number_buttons_pressed + 1
	
	if number_buttons_total == number_buttons_pressed then
		self:Fire("open")
	end
end

function OpenButton()
	number_buttons_pressed = number_buttons_pressed - 1
	self:Fire("close")
end