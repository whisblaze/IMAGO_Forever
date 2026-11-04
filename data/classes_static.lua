-- ============================================================
-- IMAGO Forever - Classes (static records)
-- ============================================================
-- One record per playable class in Forever.
-- classFile = RAID_CLASS_COLORS / CLASS_ICON_TCOORDS key,
-- faction   = playable faction(s): alliance | horde | both,
-- races     = race slugs this class is open to (Völker tab),
--           incl. the six new WoW: Forever combos and the Skyborne,
-- figures   = ordered member keys for the personalities tab
--             ({ key = k } = text row, { slug = s } = NPC link),
-- groups    = ordered organisation keys (accordion).
-- Localized text lives in locales/base/data/classes.lua.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.classes = IMAGOdb.classes or {}

-- WARRIOR
IMAGOdb.classes["warrior"] = {
    classFile = "WARRIOR",
    faction = "both",
    races = { "human", "dwarf", "night_elf", "gnome", "orc", "undead", "tauren", "troll", "skyborne" },
    figures = { { key = "anduin_lothar" }, { key = "varian_wrynn" }, { key = "llane_wrynn" }, { key = "marshal_reginald_windsor" }, { slug = "king_magni_bronzebeard_forever" }, { key = "muradin_bronzebeard" }, { key = "thargas_anvilmar" }, { key = "thoras_trollbane" }, { key = "galen_trollbane" }, { key = "daelin_proudmoore" }, { key = "genn_greymane" }, { key = "kurtalos_ravencrest" }, { key = "jarod_shadowsong" }, { slug = "cairne_bloodhoof_forever" }, { key = "baine_bloodhoof" }, { key = "blackhand" }, { key = "orgrim_doomhammer" }, { key = "grommash_hellscream" }, { key = "dalrend_blackhand" }, { key = "durotan" }, { key = "eitrigg" }, { key = "varok_saurfang" }, { key = "broxigar" }, { key = "kilrogg_deadeye" }, { key = "kargath_bladefist" }, { key = "danath_trollbane" }, { key = "kurdran_wildhammer" }, { key = "nazgrel" } },
    groups = { "knights_of_stormwind", "guardsmen", "warsong_clan", "blackrock_clan", "black_tooth_grin_clan", "blademasters", "korkron", "dreadguard", "spellbreakers", "kings_guard", "brotherhood_of_the_horse" },
}

-- PALADIN
IMAGOdb.classes["paladin"] = {
    classFile = "PALADIN",
    faction = "both",
    races = { "human", "dwarf", "undead" },
    figures = { { key = "uther_the_lightbringer" }, { key = "turalyon" }, { key = "gavinrad" }, { slug = "tirion_fordring_forever" }, { key = "saidan_dathrohan" }, { key = "grayson_shadowbreaker" }, { key = "maxwell_tyrosus" }, { key = "arthas_menethil" }, { slug = "bolvar_fordragon_forever" }, { key = "alexandros_mograine" } },
    groups = { "knights_of_the_silver_hand", "scarlet_crusade", "brotherhood_of_northshire", "argent_dawn", "champions_of_peace" },
}

-- HUNTER
IMAGOdb.classes["hunter"] = {
    classFile = "HUNTER",
    faction = "both",
    races = { "dwarf", "night_elf", "orc", "tauren", "troll", "human", "skyborne" },
    figures = { { slug = "sylvanas_windrunner_forever" }, { key = "nathanos_blightcaller" }, { key = "rexxar" }, { key = "alleria_windrunner" }, { key = "shandris_feathermoon" }, { key = "hemet_nesingwary" }, { key = "halduron_brightwing" }, { key = "vereesa_windrunner" }, { key = "huln_highmountain" } },
    groups = { "farstriders", "riflemen", "dark_rangers", "frostwolf_clan", "nesingwary_safari", "dragon_hunters" },
}

-- ROGUE
IMAGOdb.classes["rogue"] = {
    classFile = "ROGUE",
    faction = "both",
    races = { "human", "dwarf", "gnome", "night_elf", "orc", "troll", "undead", "skyborne" },
    figures = { { key = "edwin_vancleef" }, { key = "mathias_shaw" }, { key = "jorach_ravenholdt" }, { key = "hulfdan_blackbeard" }, { key = "garona_halforcen" }, { key = "renzik_the_shiv" }, { key = "marin_noggenfogger" } },
    groups = { "si_7", "defias_brotherhood", "ravenholdt", "hidden_circle", "shattered_hand_clan", "deathstalkers", "wastewanderers", "blackwater_cartel", "bloodsail_buccaneers", "southsea_freebooters", "shera_alikh" },
}

-- PRIEST
IMAGOdb.classes["priest"] = {
    classFile = "PRIEST",
    faction = "both",
    races = { "human", "dwarf", "night_elf", "troll", "undead", "gnome" },
    figures = { { slug = "tyrande_whisperwind_forever" }, { key = "archbishop_benedictus" }, { key = "alonsus_faol" }, { key = "sally_whitemane" }, { key = "moira_thaurissan" }, { key = "natalie_seline" } },
    groups = { "church_of_the_holy_light", "brotherhood_of_northshire", "sisterhood_of_elune", "cult_of_the_forgotten_shadow", "thalassian_priesthood", "darkspear_circle" },
}

-- SHAMAN
IMAGOdb.classes["shaman"] = {
    classFile = "SHAMAN",
    faction = "both",
    races = { "orc", "tauren", "troll", "dwarf", "skyborne" },
    figures = { { slug = "thrall_forever" }, { key = "drekthar" }, { key = "magatha_grimtotem" }, { key = "muln_earthfury" }, { key = "rehgar_earthfury" }, { key = "nerzhul" }, { key = "zuluhed_the_whacked" }, { key = "greatmother_geyah" }, { key = "ayessa_dawnsinger" } },
    groups = { "earthen_ring", "shadowmoon_clan", "alaketh", "windshapers" },
}

-- MAGE
IMAGOdb.classes["mage"] = {
    classFile = "MAGE",
    faction = "both",
    races = { "human", "gnome", "troll", "undead", "orc", "skyborne" },
    figures = { { key = "antonidas" }, { key = "jaina_proudmoore" }, { key = "mordent_evenshade" }, { key = "aegwynn" }, { key = "khadgar" }, { key = "medivh" }, { key = "rhonin" }, { key = "modera" }, { key = "kaelthas_sunstrider" }, { key = "chogall" }, { key = "meryl_felstorm" }, { key = "prince_tortheldrin" }, { key = "ansirem_runeweaver" }, { key = "elaadrin_evengale" } },
    groups = { "kirin_tor", "magisters", "violet_eye", "academy_of_arcane_arts_and_sciences", "wizards_sanctum_society", "magical_preservation_society", "eaaaes", "council_of_tirisfal", "conjurers_of_stormwind", "one_hundred", "moon_guard", "violet_council", "high_order" },
}

-- WARLOCK
IMAGOdb.classes["warlock"] = {
    classFile = "WARLOCK",
    faction = "both",
    races = { "human", "gnome", "orc", "undead", "troll" },
    figures = { { key = "guldan" }, { key = "kiljaeden" }, { key = "archimonde" }, { key = "teron_gorefiend" }, { key = "nekros_skullcrusher" }, { key = "neeru_fireblade" } },
    groups = { "shadow_council", "slaughtered_lamb_coven", "stormreaver_clan", "burning_blade_clan", "searing_blade", "argus_wake", "cult_of_the_dark_strand", "shadowsworn" },
}

-- DRUID
IMAGOdb.classes["druid"] = {
    classFile = "DRUID",
    faction = "both",
    races = { "night_elf", "tauren", "skyborne" },
    figures = { { key = "cenarius" }, { key = "malfurion_stormrage" }, { slug = "fandral_staghelm_forever" }, { key = "hamuul_runetotem" }, { key = "remulos" }, { key = "broll_bearmantle" } },
    groups = { "cenarion_circle", "emerald_circle", "druids_of_the_claw", "druids_of_the_fang", "druids_of_the_scythe", "druids_of_the_talon", "druids_of_the_antler", "thornweavers" },
}
