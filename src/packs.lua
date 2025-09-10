SMODS.Booster {
    key = "arcana_giga",
    weight = 0,
    kind = 'Arcana', -- You can also use Arcana if you want it to belong to the vanilla kind
    cost = 12,
    pos = { x = 2, y = 2 },
    config = { extra = 12, choose = 5 },
    discovered = true,
    group_key = "k_arcana_pack",
    draw_hand = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {
                set = "Spectral",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "ar2"
            }
        else
            _card = {
                set = "Tarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "ar2"
            }
        end
        return _card
    end,
}

SMODS.Booster {
    key = "celestial_giga",
    weight = 0,
    kind = 'Celestial', -- You can also use Celestial if you want it to belong to the vanilla kind
    cost = 10,
    pos = { x = 2, y = 3 },
    config = { extra = 9, choose = 3 }, -- 9 planets, or else the rest get replaced with Pluto.
    discovered = true,
    group_key = "k_celestial_pack",
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for _, handname in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                    _hand = handname
                    _tally = G.GAME.hands[handname].played
                end
            end
            if _hand then
                for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                    if planet_center.config.hand_type == _hand then
                        _planet = planet_center.key
                    end
                end
            end
            _card = {
                set = "Planet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key = _planet,
                key_append =
                "pl1"
            }
        else
            _card = {
                set = "Planet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "pl1"
            }
        end
        return _card
    end,
}

SMODS.Booster {
    key = "spectral_giga",
    weight = 0,
    kind = 'Spectral', -- You can also use Spectral if you want it to belong to the vanilla kind
    cost = 12,
    pos = { x = 3, y = 4 },
    config = { extra = 8, choose = 4 },
    discovered = true,
    group_key = "k_spectral_pack",
    draw_hand = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.SPECTRAL_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "Spectral",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append =
            "spe"
        }
    end,
}

SMODS.Booster {
    key = "standard_giga",
    weight = 0,
    kind = 'Standard', -- You can also use Standard if you want it to belong to the vanilla kind
    cost = 12,
    pos = { x = 2, y = 7 },
    config = { extra = 12, choose = 5 },
    discovered = true,
    group_key = "k_standard_pack",
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.STANDARD_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.3,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.BLACK, G.C.RED },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _edition = poll_edition('standard_edition' .. G.GAME.round_resets.ante, 2, true)
        local _seal = SMODS.poll_seal({ mod = 10 })
        return {
            set = "Playing Card",
            edition = _edition,
            seal = _seal,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "sta"
        }
    end,
}

SMODS.Booster {
    key = "buffoon_giga",
    weight = 0,
    kind = 'Buffoon', -- You can also use Buffoon if you want it to belong to the vanilla kind
    cost = 12,
    pos = { x = 3, y = 8 },
    config = { extra = 8, choose = 4 },
    discovered = true,
    group_key = "k_buffoon_pack",
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.BUFFOON_PACK)
    end,
    create_card = function(self, card, i)
        return { set = "Joker", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "buf" }
    end,
}