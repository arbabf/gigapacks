SMODS.Atlas {
	key = "GigaPacks",
	path = "gigapacks.png",
	px = 114,
	py = 186
}

SMODS.Atlas({
    key = "modicon",
    path = "modicon.png",
    px = 80,
    py = 80
})

assert(SMODS.load_file("src/packs.lua"))()
assert(SMODS.load_file("src/merge.lua"))()