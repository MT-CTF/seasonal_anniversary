if os.date("%m") ~= "8" or tonumber(os.date("%d")) < 16 then return end

local old_fireworks_on_use = fireworks.on_use

local given = {}

fireworks.on_use = function(user, ...)
	local name = user:get_player_name()

	if not given[name] then
		local meta = user:get_meta()

		if meta:get_int("server_cosmetics:entity:party_hat:anniversary") ~= 1 then
			user:get_meta():set_int("server_cosmetics:entity:party_hat:anniversary", 1)

			hud_events.new(name, {
				text = "You have unlocked the anniversary party hat! Put it on in the Customize tab!",
				color = "success",
			})
		else
			given[name] = true
		end
	end

	return old_fireworks_on_use(user, ...)
end

minetest.register_on_leaveplayer(function(player)
	given[player:get_player_name()] = nil
end)
