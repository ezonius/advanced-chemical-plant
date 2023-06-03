-- If Krastorio is installed then don't do anything.
-- I am not familiar with Krastorio's balance, so don't want to change the emissions,
-- and what else would this mod do?
if data.raw.item["kr-advanced-chemical-plant"] then
  return
end

local graphics_path = "__advanced-chemical-plant__/graphics/"
local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

-- remnant
data:extend({
  {
    type = "corpse",
    name = "kr-big-random-pipes-remnant",
    icon = graphics_path .. "remnant/remnants-icon.png",
    icon_size = 64,
    flags = { "placeable-neutral", "building-direction-8-way", "not-on-map" },
    selection_box = { { -4, -4 }, { 4, 4 } },
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    subgroup = "remnants",
    order = "z[remnants]-a[generic]-b[big]",
    time_before_removed = 60 * 60 * 20, -- 20 minutes
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = make_rotated_animation_variations_from_sheet(1, {
      filename = graphics_path .. "remnant/big-random-pipes-remnant.png",
      line_length = 1,
      width = 250,
      height = 250,
      frame_count = 1,
      direction_count = 1,
      hr_version = {
        filename = graphics_path .. "remnant/hr-big-random-pipes-remnant.png",
        line_length = 1,
        width = 500,
        height = 500,
        frame_count = 1,
        direction_count = 1,
        scale = 0.5,
      },
    }),
  },
})

-- pipes
local empty_sprite = {
  filename = graphics_path .. "empty.png",
  priority = "high",
  width = 1,
  height = 1,
  scale = 0.5,
  shift = { 0, 0 },
}

kr_pipe_path = {
  north = empty_sprite,
  east = empty_sprite,
  south = {
    filename = graphics_path .. "pipe-patch/pipe-patch.png",
    priority = "high",
    width = 28,
    height = 25,
    shift = { 0.01, -0.58 },
    hr_version = {
      filename = graphics_path .. "pipe-patch/hr-pipe-patch.png",
      priority = "high",
      width = 55,
      height = 50,
      scale = 0.5,
      shift = { 0.01, -0.58 },
    },
  },
  west = empty_sprite,
}

--item
data:extend({
  {
    type = "item",
    name = "kr-advanced-chemical-plant",
    icon = graphics_path .. "icons/advanced-chemical-plant.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "chemistry",
    order = "e[chemical-plant]-b[advanced-chemical-plant]",
    place_result = "kr-advanced-chemical-plant",
    stack_size = 50,
  }
})

-- entity
data:extend({
  {
    type = "assembling-machine",
    name = "kr-advanced-chemical-plant",
    icon = graphics_path .. "icons/advanced-chemical-plant.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 1, result = "kr-advanced-chemical-plant" },
    max_health = 1500,
    corpse = "kr-big-random-pipes-remnant",
    dying_explosion = "big-explosion",
    damaged_trigger_effect = hit_effects.entity(),
    resistances = {
      { type = "physical", percent = 50 },
      { type = "fire",     percent = 70 },
      { type = "impact",   percent = 70 },
    },
    fluid_boxes = {
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        base_area = 20,
        base_level = -1,
        pipe_connections = { { type = "input", position = { 2, -4 } } },
      },
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        base_area = 20,
        base_level = -1,
        pipe_connections = { { type = "input", position = { 0, -4 } } },
      },
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        base_area = 20,
        base_level = -1,
        pipe_connections = { { type = "input", position = { -2, -4 } } },
      },
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        base_area = 10,
        base_level = 1,
        pipe_connections = { { type = "output", position = { 2, 4 } } },
      },
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        base_area = 10,
        base_level = 1,
        pipe_connections = { { type = "output", position = { 0, 4 } } },
      },
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        base_area = 10,
        base_level = 1,
        pipe_connections = { { type = "output", position = { -2, 4 } } },
      },

      off_when_no_fluid_recipe = false,
    },
    collision_box = { { -3.25, -3.25 }, { 3.25, 3.25 } },
    selection_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },
    fast_replaceable_group = "assembling-machine",
    animation = {
      layers = {
        {
          filename = graphics_path .. "entity/advanced-chemical-plant.png",
          priority = "high",
          width = 226,
          height = 268,
          shift = { 0, -0.48 },
          frame_count = 20,
          line_length = 5,
          animation_speed = 0.25,
          scale = 1,
          hr_version = {
            filename = graphics_path .. "entity/hr-advanced-chemical-plant.png",
            priority = "high",
            width = 451,
            height = 535,
            shift = { 0, -0.48 },
            frame_count = 20,
            line_length = 5,
            animation_speed = 0.25,
            scale = 0.5,
          },
        },
        {
          filename = graphics_path .. "entity/advanced-chemical-plant-sh.png",
          priority = "high",
          width = 258,
          height = 229,
          shift = { 0.33, 0.32 },
          frame_count = 1,
          repeat_count = 20,
          animation_speed = 0.25,
          scale = 1,
          draw_as_shadow = true,
          hr_version = {
            filename = graphics_path .. "entity/hr-advanced-chemical-plant-sh.png",
            priority = "high",
            width = 516,
            height = 458,
            shift = { 0.33, 0.32 },
            frame_count = 1,
            repeat_count = 20,
            animation_speed = 0.25,
            scale = 0.5,
            draw_as_shadow = true,
          },
        },
      },
    },
    crafting_categories = { "chemistry" },
    vehicle_impact_sound = sounds.generic_impact,
    working_sound = {
      sound = { filename = "__advanced-chemical-plant__/sounds/advanced-chemical-plant.ogg" },
      idle_sound = { filename = "__base__/sound/idle1.ogg" },
      apparent_volume = 1,
    },
    crafting_speed = 8,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 2,
    },

    water_reflection = {
      pictures = {
        filename = graphics_path .. "entity/advanced-chemical-plant-reflection.png",
        priority = "extra-high",
        width = 80,
        height = 60,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false,
    },

    energy_usage = "2.97MW",
    ingredient_count = 6,
    module_specification = { module_slots = 4, module_info_icon_shift = { 0, 1.7 }, module_info_icon_scale = 1 },
    allowed_effects = { "consumption", "speed", "productivity", "pollution" },
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
  }
})

-- recipe
data:extend({
  {
    type = "recipe",
    name = "kr-advanced-chemical-plant",
    energy_required = 30,
    enabled = "false",
    ingredients =
    {
      { "chemical-plant",     4 },
      { "speed-module",       4 },
      { "effectivity-module", 4 },
    },
    result = "kr-advanced-chemical-plant",
  }
})

-- technology
data:extend({
  {
    type = "technology",
    name = "kr-advanced-chemical-plant",
    mod = "Krastorio2",
    icon = graphics_path .. "technology/advanced-chemical-plant.png",
    icon_size = 256,
    icon_mipmaps = 4,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "kr-advanced-chemical-plant",
      },
    },
    prerequisites =
    {
      "speed-module",
      "effectivity-module",
      "coal-liquefaction"
    },
    unit = {
      count = 300,
      ingredients = {
        { "utility-science-pack",    1 },
        { "automation-science-pack", 1 },
        { "logistic-science-pack",   1 },
        { "chemical-science-pack",   1 }
      },
      time = 45,
    },
  }
})

