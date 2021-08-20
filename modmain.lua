Assets = {

}

PrefabFiles = 
{

}

local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS
local FRAMES = GLOBAL.FRAMES

local function MakeGrowTimes(germination_min, germination_max, full_grow_min, full_grow_max) -- From farm_plant_defs.lua, makes the time in which the plant grows and germinates
	local grow_time = {}

	-- germination time
	grow_time.seed		= {germination_min, germination_max}

	-- grow time
	grow_time.sprout	= {full_grow_min * 0.5, full_grow_max * 0.5}
	grow_time.small		= {full_grow_min * 0.3, full_grow_max * 0.3}
	grow_time.med		= {full_grow_min * 0.2, full_grow_max * 0.2}

	-- harvestable perish time
	grow_time.full		= 4 * TUNING.TOTAL_DAY_TIME
	grow_time.oversized	= 6 * TUNING.TOTAL_DAY_TIME
	grow_time.regrow	= {4 * TUNING.TOTAL_DAY_TIME, 5 * TUNING.TOTAL_DAY_TIME} -- min, max

	return grow_time
end

local drink_low = TUNING.FARM_PLANT_DRINK_LOW -- Low water needs
local drink_med = TUNING.FARM_PLANT_DRINK_MED -- Medium water needs
local drink_high = TUNING.FARM_PLANT_DRINK_HIGH -- High water needs

local S = TUNING.FARM_PLANT_CONSUME_NUTRIENT_LOW -- Low nutrient needs
local M = TUNING.FARM_PLANT_CONSUME_NUTRIENT_MED -- Medium nutrient needs
local L = TUNING.FARM_PLANT_CONSUME_NUTRIENT_HIGH -- High nutrient needs

PLANT_DEFS.wheatplant = {build = "farm_plant_potato", bank = "farm_plant_potato"} -- Build and bank of the plant

PLANT_DEFS.wheatplant.prefab = "farm_plant_wheat" -- Prefab for the plant

PLANT_DEFS.wheatplant.product = "wheat" -- The fruit or veggie that the plant produces

PLANT_DEFS.wheatplant.product_oversized = "wheat" -- The fruit or veggie that the giant plant produces

PLANT_DEFS.wheatplant.seed = "wheat_seeds" -- The seeds the fruit or veggie gives when harvested

PLANT_DEFS.wheatplant.family_min_count = 2 -- The number of the plant needed to make the plant happy

PLANT_DEFS.wheatplant.family_check_dist = 4 -- The distance up to where it checks for plants

PLANT_DEFS.wheatplant.plant_type_tag = nil -- I honestly don't know what this does, but if you know, tell me in the comments. It's probably still needed

PLANT_DEFS.wheatplant.grow_time = MakeGrowTimes(12*TUNING.SEG_TIME, 16*TUNING.SEG_TIME, 4*TUNING.TOTAL_DAY_TIME, 7*TUNING.TOTAL_DAY_TIME) -- The time it takes for the plant to germinate and grow (germination minimum, germination maximum, growth minimum, growth maximum)

PLANT_DEFS.wheatplant.moisture = {drink_rate = drink_med, min_percent = TUNING.FARM_PLANT_DROUGHT_TOLERANCE} -- How much water the plant needs

PLANT_DEFS.wheatplant.good_seasons = {winter = true, spring = true} -- The season in which the plant is comfortable

PLANT_DEFS.wheatplant.nutrient_consumption = {0, L, S} -- How much of each fertilizaer the plant needs {Seaweed, Compost, Manure}

PLANT_DEFS.wheatplant.max_killjoys_tolerance = TUNING.FARM_PLANT_KILLJOY_TOLERANCE -- The plant's tolerance to killjoys, AKA, anything that would stress it out

PLANT_DEFS.wheatplant.weight_data = { 361.51, 506.04, .28 } -- The weight of the plant { min, max, sigmoid }

PLANT_DEFS.wheatplant.sounds = PLANT_DEFS.potato.sounds -- The sounds the plant makes when growing


PLANT_DEFS.wheatplant.pictureframeanim = {anim = "emoteXL_loop_dance8", time = 27*FRAMES} -- The pose of your character as it appears in the registry

PLANT_DEFS.wheatplant.plantregistrywidget = "widgets/redux/farmplantpage" -- This should remain unchanged, it's what appears when you click on your plant

PLANT_DEFS.wheatplant.plantregistrysummarywidget = "widgets/redux/farmplantsummarywidget" -- This should remain unchanged, this is the summary that appears at the end of the plant preview

PLANT_DEFS.wheatplant.plantregistryinfo = { -- This should remain unchanged, it's what shows the animations in the preview and plant page
    {
        text = "seed",
        anim = "crop_seed",
        grow_anim = "grow_seed",
        learnseed = true,
        growing = true,
    },
    {
        text = "sprout",
        anim = "crop_sprout",
        grow_anim = "grow_sprout",
        growing = true,
    },
    {
        text = "small",
        anim = "crop_small",
        grow_anim = "grow_small",
        growing = true,
    },
    {
        text = "medium",
        anim = "crop_med",
        grow_anim = "grow_med",
        growing = true,
    },
    {
        text = "grown",
        anim = "crop_full",
        grow_anim = "grow_full",
        revealplantname = true,
        fullgrown = true,
    },
    {
        text = "oversized",
        anim = "crop_oversized",
        grow_anim = "grow_oversized",
        revealplantname = true,
        fullgrown = true,
        hidden = true,
    },
    {
        text = "rotting",
        anim = "crop_rot",
        grow_anim = "grow_rot",
        stagepriority = -100,
        is_rotten = true,
        hidden = true,
    },
    {
        text = "oversized_rotting",
        anim = "crop_rot_oversized",
        grow_anim = "grow_rot_oversized",
        stagepriority = -100,
        is_rotten = true,
        hidden = true,
    },
}

       GLOBAL.STRINGS.NAMES.FARM_PLANT_WHEAT = "Wheat plant"
	   local RARE = TUNING.SEED_CHANCE_RARE
	   local UNCOMMON = TUNING.SEED_CHANCE_UNCOMMON
       local COMMON = TUNING.SEED_CHANCE_COMMON

local function MakeVegStats(seedweight, hunger, health, perish_time, sanity, cooked_hunger, cooked_health, cooked_perish_time, cooked_sanity, float_settings, cooked_float_settings, dryable, secondary_foodtype, halloweenmoonmutable_settings, lure_data)
    return {
        health = health,
        hunger = hunger,
        cooked_health = cooked_health,
        cooked_hunger = cooked_hunger,
        seed_weight = seedweight,
        perishtime = perish_time,
        cooked_perishtime = cooked_perish_time,
        sanity = sanity,
        cooked_sanity = cooked_sanity,
        float_settings = float_settings,
        cooked_float_settings = cooked_float_settings,
		dryable = dryable,
		halloweenmoonmutable_settings = halloweenmoonmutable_settings,
		secondary_foodtype = secondary_foodtype,
        lure_data = lure_data,
    }
end
AddSimPostInit(function()
    GLOBAL.VEGGIES["wheat"] = MakeVegStats(COMMON, TUNING.CALORIES_TINY, 0, TUNING.PERISH_SLOW, -TUNING.SANITY_SMALL, 
                                   TUNING.CALORIES_TINY, TUNING.HEALING_TINY, TUNING.PERISH_MED, -TUNING.SANITY_TINY,
                                   {"large", 0.05, 0.45})
end)

AddPrefabPostInit("wheatgrass",function(inst)
 inst:RemoveComponent("workable") 
 end)