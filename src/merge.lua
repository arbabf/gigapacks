local update_shop_ref = Game.update_shop
local button_shown = false
local BUTTON_MOVE_AMOUNT = 1.65

G.merge_button = nil

G.FUNCS.merge_booster = function(e)
    G.FUNCS.show_button(false)
    local center_key = "p_gigapack_" .. G.shop_booster.cards[1].config.center.kind:lower() .. "_giga"
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.75,
        func = (function()
            local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,
            G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[center_key], {bypass_discovery_center = true, bypass_discovery_ui = true})
            create_shop_card_ui(card, 'Booster', G.shop_booster)
            card.ability.booster_pos = 1
            card:start_materialize()
            G.shop_booster:emplace(card)
            G.shop_booster.config.card_limit = 1
            return true
        end)
    }))
    G.shop_booster.cards[1]:start_dissolve()
    G.shop_booster.cards[2]:start_dissolve()
end

function G.UIDEF.merge_button()
    local t = {n=G.UIT.ROOT, config={align = "cr", minh=3.5, minw=5, colour = G.C.CLEAR, emboss = 0.05}, nodes={
        {n=G.UIT.C, config={align = "cr", minh=3.5, minw=5, padding = 0.15, r=0.2, colour = G.C.GREEN, shadow = true, emboss = 0.05, button = 'merge_booster', hover = true}, nodes={
            {n=G.UIT.T, config={text = localize('b_merge'),colour = G.C.WHITE, scale = 0.5}}
        }}}}
    return t
end

function Game:update_shop(dt)
    -- draw merge button before the shop so it gets drawn under the shop
    G.merge_button = G.merge_button or UIBox{
        definition = G.UIDEF.merge_button(),
        config = {align='tmi', offset = {x=3.2,y=G.ROOM.T.y+11}, major = G.hand, bond = 'Weak'}
    }
    -- shop doesn't exist before we draw the merge button so we need to set its major afterward
    if G.shop and G.merge_button.major ~= G.shop then
        G.merge_button:set_role({major=G.shop, role_type='Minor'})
        G.merge_button.alignment.offset.y = 4.38
    end

    update_shop_ref(self, dt)

    if #G.shop_booster.cards >= 2 then
        -- todo: what if we have more than two boosters in the shop?
        if G.FUNCS.can_merge() then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                blockable = false,
                delay =  0.5,
                func = (function() G.FUNCS.show_button(true); return true end)
            }))
        end
    end
end

G.FUNCS.button_shown = function()
    return button_shown
end

G.FUNCS.can_merge = function()
    return G.shop_booster.cards[1].label == G.shop_booster.cards[2].label and G.shop_booster.cards[1].label:sub(1, #"Mega") == "Mega"
    and not button_shown
    and not G.shop_booster.cards[1].dissolve_colours
end

G.FUNCS.show_button = function(enable)
    if (not G.merge_button) or enable == button_shown then return end
    if enable then
        G.merge_button.alignment.offset.x = G.merge_button.alignment.offset.x + BUTTON_MOVE_AMOUNT
        G.deck.T.x = G.deck.T.x + BUTTON_MOVE_AMOUNT
    else
        G.merge_button.alignment.offset.x = G.merge_button.alignment.offset.x - BUTTON_MOVE_AMOUNT
        G.deck.T.x = G.deck.T.x - BUTTON_MOVE_AMOUNT
    end
    play_sound('cancel')
    button_shown = enable
end