-- ============================================================
-- IMAGO Forever — data/races_static.lua  (static data)
-- Playable race records: leaderID = creature ID used for the
-- Figures-tab model; mountID/epicMountID = creature IDs of the
-- racial mounts shown stacked in the Culture tab (hidden if nil).
-- iconM/iconF = race icon FileIDs (portraits), tabard = race tabard.
-- figures = array of { slug = <npc slug> } (links to Fates) or
-- { key = <localized key> } (plain text entry).
-- settlements = array of uiMapIDs (Classic-era; link activates once
-- the zone exists in IMAGOdb.zones) or string keys for text-only
-- records (Skyborne isles); names/lore are localized.
-- groups = array of keys; texts live in locales.
-- Localized dossier texts (quote, overview, facts, classes, history,
-- culture, relations, group names/lore, figureText name/role/aff)
-- live in locales/<locale>/data/races.lua.
-- ============================================================

IMAGOdb = IMAGOdb or {}
IMAGOdb.races = IMAGOdb.races or {}

-- ============================================================
-- ALLIANCE
-- ============================================================

IMAGOdb.races["human"] = {
    iconM = 236448, -- race icon FileID (male)
    iconF = 236447, -- race icon FileID (female)
    tabard = 255150, -- race tabard FileID
    mountID = 307,       -- racial mount (creature ID)
    epicMountID = 14560,   -- epic racial mount (creature ID)
    alignment = "Alliance",
    leaderID = 1748, -- Highlord Bolvar Fordragon
    figures = { { key = "varian_wrynn" }, { slug = "anduin_wrynn_forever" }, { key = "llane_wrynn" }, { key = "anduin_lothar" }, { key = "turalyon" }, { key = "terenas_menethil_ii" }, { key = "arthas_menethil" }, { key = "calia_menethil" }, { key = "uther_the_lightbringer" }, { key = "genn_greymane" }, { key = "darius_crowley" }, { key = "daelin_proudmoore" }, { key = "jaina_proudmoore" }, { slug = "bolvar_fordragon_forever" }, { key = "alexandros_mograine" }, { slug = "tirion_fordring_forever" }, { key = "aegwynn" }, { key = "medivh" }, { key = "khadgar" }, { key = "antonidas" }, { key = "rhonin" }, { key = "thoras_trollbane" }, { key = "galen_trollbane" }, { key = "danath_trollbane" }, { key = "reginald_windsor" }, { key = "mathias_shaw" }, { key = "aiden_perenolde" }, { key = "edwin_van_cleef" }, { key = "alonsus_faol" }, { key = "archbishop_benedictus" }, { key = "archmage_arugal" }, { key = "othmar_garithos" }, { key = "saidan_dathrohan" }, { key = "aedelas_blackmoore" }, { key = "maxwell_tyrosus" } },
    settlements = { 1453, 1429 }, -- Stormwind City, Elwynn Forest
    groups = { "stormwind", "lordaeron", "dalaran", "kul_tiras", "gilneas", "stromgarde", "alterac", "theramore" },
}

IMAGOdb.races["dwarf"] = {
    iconM = 236444, -- race icon FileID (male)
    iconF = 236443, -- race icon FileID (female)
    tabard = 255148, -- race tabard FileID
    mountID = 4779,       -- racial mount (creature ID)
    epicMountID = 14547,   -- epic racial mount (creature ID)
    alignment = "Alliance",
    leaderID = 2784, -- King Magni Bronzebeard
    figures = { { key = "modimus_anvilmar" }, { key = "madoran_bronzebeard" }, { slug = "king_magni_bronzebeard_forever" }, { key = "muradin_bronzebeard" }, { key = "brann_bronzebeard" }, { key = "moira_thaurissan" }, { key = "thargas_anvilmar" }, { key = "hjalmar_anvilmar" }, { key = "baelgun_flamebeard" }, { key = "high_priest_rohan" }, { key = "vanndar_stormpike" }, { key = "hemet_nesingwary" }, { key = "rom" }, { key = "thane_korthazz" }, { key = "khardros_wildhammer" }, { key = "falstad_wildhammer" }, { key = "kurdran_wildhammer" }, { key = "sorcerer_thane_thaurissan" }, { key = "modgud" }, { key = "emperor_dagran_thaurissan" }, { key = "franclorn_forgewright" } },
    settlements = { 1455, 1426 }, -- Ironforge, Dun Morogh
    groups = { "bronzebeard_clan", "wildhammer_clan", "dark_iron_clan", "stormpike_clan", "explorers_league" },
}

IMAGOdb.races["gnome"] = {
    iconM = 236446, -- race icon FileID (male)
    iconF = 236445, -- race icon FileID (female)
    tabard = 255149, -- race tabard FileID
    mountID = 7739,       -- racial mount (creature ID)
    epicMountID = 14552,   -- epic racial mount (creature ID)
    alignment = "Alliance",
    leaderID = 7937, -- High Tinker Mekkatorque
    figures = { { slug = "high_tinker_mekkatorque_forever" }, { key = "sicco_thermaplugg" }, { key = "indus" }, { key = "erbag" }, { key = "king_mechagon" }, { key = "tinkmaster_overspark" }, { key = "brink_spannercrank" }, { key = "kelsey_steelspark" }, { key = "pip_quickwit" }, { key = "millhouse_manastorm" }, { key = "narain_soothfancy" }, { key = "oglethorpe_obnoticus" }, { key = "silas_darkmoon" }, { key = "j_d_collie" }, { key = "linken" }, { key = "doctor_weavil" } },
    settlements = { 1455, 1426 }, -- Dun Morogh (Tinker Town, Ironforge)
    groups = { "kingdom_of_gnomeregan_in_exile", "thermapluggs_court", "gnomeregan_covert_ops", "kirin_tor", "leper_gnomes" },
}

IMAGOdb.races["night_elf"] = {
    iconM = 236450, -- race icon FileID (male)
    iconF = 236449, -- race icon FileID (female)
    tabard = 255151, -- race tabard FileID
    mountID = 7690,       -- racial mount (creature ID)
    epicMountID = 14602,   -- epic racial mount (creature ID)
    alignment = "Alliance",
    leaderID = 7999, -- Tyrande Whisperwind
    figures = { { slug = "tyrande_whisperwind_forever" }, { key = "malfurion_stormrage" }, { slug = "fandral_staghelm_forever" }, { key = "shandris_feathermoon" }, { key = "maiev_shadowsong" }, { key = "jarod_shadowsong" }, { key = "broll_bearmantle" }, { key = "suura_swiftarrow" }, { key = "naralex" }, { key = "archdruid_renferal" }, { key = "mordent_evenshade" }, { key = "prince_tortheldrin" }, { key = "kurtalos_ravencrest" }, { key = "valstann_staghelm" }, { key = "queen_azshara" }, { key = "illidan_stormrage" }, { key = "lady_vashj" }, { key = "xavius" }, { key = "ralaar_fangfire" }, { key = "keeper_remulos" }, { key = "rabine_saturna" }, { key = "omen" } },
    settlements = { 1457, 1438 }, -- Darnassus, Teldrassil
    groups = { "darnassus", "sisterhood_of_elune", "sentinels", "silverwing_sentinels", "watchers", "cenarion_circle", "highborne_shendralar", "allies_of_nature" },
}

-- ============================================================
-- HORDE
-- ============================================================

IMAGOdb.races["orc"] = {
    iconM = 236452, -- race icon FileID (male)
    iconF = 236451, -- race icon FileID (female)
    tabard = 255152, -- race tabard FileID
    mountID = 358,       -- racial mount (creature ID)
    epicMountID = 14539,   -- epic racial mount (creature ID)
    alignment = "Horde",
    leaderID = 4949, -- Thrall
    figures = { { slug = "thrall_forever" }, { key = "blackhand" }, { key = "guldan" }, { key = "orgrim_doomhammer" }, { key = "nerzhul" }, { key = "grommash_hellscream" }, { key = "garrosh_hellscream" }, { key = "durotan" }, { key = "draka" }, { key = "greatmother_geyah" }, { key = "drekthar" }, { key = "rend_blackhand" }, { key = "teron_gorefiend" }, { key = "broxigar" }, { key = "varok_saurfang" }, { key = "dranosh_saurfang" }, { key = "eitrigg" }, { key = "kilrogg_deadeye" }, { key = "jorin_deadeye" }, { key = "kargath_bladefist" }, { key = "zuluhed_the_whacked" }, { key = "rehgar_earthfury" }, { key = "nazgrel" }, { key = "samuro" }, { key = "rokaro" }, { key = "utok_scratcher" }, { key = "drakthul" } },
    settlements = { 1454, 1411 }, -- Orgrimmar, Durotar
    groups = { "frostwolf", "warsong", "blackrock", "bleeding_hollow", "shattered_hand", "shadowmoon", "dragonmaw", "burning_blade", "thunderlord", "stormreaver", "twilights_hammer", "laughing_skull", "bonechewer", "black_tooth_grin" },
}

IMAGOdb.races["troll"] = {
    iconM = 236456, -- race icon FileID (male)
    iconF = 236455, -- race icon FileID (female)
    tabard = 255154, -- race tabard FileID
    mountID = 6075,       -- racial mount (creature ID)
    epicMountID = 14543,   -- epic racial mount (creature ID)
    alignment = "Horde",
    leaderID = 10540, -- Vol'jin
    figures = { { slug = "vol_jin_forever" }, { key = "senjin" }, { key = "rokhan" }, { key = "master_gadrin" }, { key = "zalazane" }, { key = "zuljin" }, { key = "jindo_the_hexxer" }, { key = "zanzil_the_outcast" }, { key = "jammalan_the_prophet" }, { key = "elder_torntusk" }, { key = "primal_torntusk" }, { key = "warlord_threshjin" }, { key = "war_master_voone" }, { key = "ganzulah" }, { key = "anathek_the_cruel" }, { key = "chief_ukorz_sandscalp" }, { key = "king_rastakhan" }, { key = "zanza_the_restless" }, { key = "hakkar_the_soulflayer" }, { key = "frost_king_malakk" } },
    settlements = { 1411 }, -- Durotar (Echo Isles)
    groups = { "darkspear_tribe", "zandalari_tribe_zandalari_empire", "gurubashi_tribes", "amani_tribes", "revantusk_tribe", "shatterspear_tribe", "drakkari_tribes", "farraki_tribe", "shadowtooth_clan" },
}

IMAGOdb.races["undead"] = {
    iconM = 236458, -- race icon FileID (male)
    iconF = 236457, -- race icon FileID (female)
    tabard = 456569, -- race tabard FileID
    mountID = 11153,       -- racial mount (creature ID)
    epicMountID = 14558,   -- epic racial mount (creature ID)
    alignment = "Horde",
    leaderID = 10181, -- Lady Sylvanas Windrunner
    figures = { { slug = "sylvanas_windrunner_forever" }, { slug = "varimathras_forever" }, { key = "nathanos_blightcaller" }, { key = "master_apothecary_faranell" }, { key = "belmont" }, { key = "alexi_barov" }, { key = "helcular" }, { key = "gunther_arcanus" }, { key = "leonid_barthalomew" }, { key = "alonsus_faol" } },
    settlements = { 1458, 1420 }, -- Tirisfal Glades (Undercity)
    groups = { "undercity", "royal_apothecary_society", "deathguard", "deathstalkers", "defilers", "dark_rangers", "cult_of_forgotten_shadow", "scourge_and_the_scarlet_crusade" },
}

IMAGOdb.races["tauren"] = {
    iconM = 236454, -- race icon FileID (male)
    iconF = 236453, -- race icon FileID (female)
    tabard = 255153, -- race tabard FileID
    mountID = 12149,       -- racial mount (creature ID)
    epicMountID = 14542,   -- epic racial mount (creature ID)
    alignment = "Horde",
    leaderID = 3057, -- Cairne Bloodhoof
    figures = { { slug = "cairne_bloodhoof_forever" }, { key = "baine_bloodhoof" }, { key = "magatha_grimtotem" }, { key = "hamuul_runetotem" }, { key = "huln_highmountain" }, { key = "muln_earthfury" }, { key = "perith_stormhoof" }, { key = "tagar_bloodhoof" }, { key = "bovan_windtotem" }, { key = "fleet_master_seahorn" }, { key = "xarantaur" }, { key = "trag_highmountain" } },
    settlements = { 1456, 1412 }, -- Thunder Bluff, Mulgore
    groups = { "bloodhoof_tribe", "grimtotem_tribe", "runetotem_tribe", "tribes_of_thunder_bluff", "far_tribes", "earthen_ring", "longwalkers", "outrunners" },
}

-- ============================================================
-- BOTH FACTIONS (WoW Forever exclusive)
-- ============================================================

IMAGOdb.races["skyborne"] = {
    alignment = "Both", -- playable on Alliance and Horde
    figures = { { key = "the_shalnan" }, { key = "talaanis_shadowsong" }, { key = "valennia_stormfist" }, { key = "elaadrin_evengale" }, { key = "ayessa_dawnsinger" }, { key = "high_priestess_lorthuna" }, { key = "belathaan_brightwish" }, { key = "commander_haalien" }, { key = "elegael_thornpaw" }, { key = "lotheluum_starbreeze" }, { key = "illaya_amberwing" }, { key = "dorii_brightwhisper" }, { key = "resaan" }, { key = "ealaane_nimbuswalker" } },
    settlements = { "zephras_isle", "banaethal", "eldrethalas" },
    groups = { "high_order", "windshapers", "alaketh", "peacekeepers", "nightclaw_druids", "rangers_of_thendal_grove", "council_of_elders" },
}

-- Left-column artwork for the History sub-tab (2:3 portraits in media/races)
for slug in pairs(IMAGOdb.races) do
    IMAGOdb.races[slug].imagePath = "Interface\\AddOns\\IMAGO_forever\\media\\races\\" .. slug .. ".tga"
end
