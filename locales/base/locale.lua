-- ============================================================
-- IMAGO — core/Locale_enUS.lua
-- English localization (default for enUS, enGB, and all others)
-- ============================================================

IMAGO = IMAGO or {}
IMAGO.LocaleData = IMAGO.LocaleData or {}

local L = {}
IMAGO.LocaleData.enUS = L

-- English (default for enUS, enGB, and all others)
L["WINDOW_TITLE"]                   = "Chronicle of the Unforgotten"
L["UNDISCOVERED"]                   = "Undiscovered"
L["UNDISCOVERED_LORE"]              = "Find this person in the world to uncover their fate."
L["ADDON_ENABLED"]                  = "IMAGO enabled."
L["ADDON_DISABLED"]                 = "IMAGO disabled."
L["RESET_DONE"]                     = "All discovered entries have been reset."
L["SETTINGS_TITLE"]                 = "IMAGO - Settings"
L["SETTINGS_DESC"]                  = "The world has a story. IMAGO preserves it."
L["SETTINGS_SEC_GENERAL"]           = "General"
L["SETTINGS_SEC_DISCOVERY_CARD"]    = "Discovery Card (NPC/Zone popup)"
L["SETTINGS_SEC_IDLE_FLASHCARDS"]   = "Idle Flashcards (snippets)"
L["SETTINGS_SEC_MOTD"]              = "Imago MotD (chat)"
L["SETTINGS_SEC_UI"]                = "UI"
L["SETTINGS_SEC_LANGUAGE"]          = "Language"
L["OPT_LANGUAGE"]                   = "Addon Language"
L["OPT_LANGUAGE_NOTE"]              = "Change takes effect after /reload."
L["OPT_ENABLE"]                     = "Enable IMAGO"
L["OPT_ENABLE_IDLE_FLASHCARDS"]     = "Enable Idle Flashcards"
L["OPT_ENABLE_MOTD"]                = "Enable Imago MotD (\"Did you know?\" in chat)"
L["OPT_ONCE_ONLY_NPC"]              = "Only show NPC lore on first discovery"
L["OPT_ONCE_ONLY_ZONE"]             = "Only show Zone lore on first discovery"
L["OPT_RESET_BTN"]                  = "Reset history"
L["OPT_SCALE"]                      = "Window scale"
L["OPT_MAIN_LORE_NO_TIMER"]         = "Keep Discovery Card open (no timer)"
L["OPT_SNIPPET_NO_TIMER"]           = "Keep Idle Flashcards open (no timer)"
L["OPT_OPAQUE_UI"]                  = "100% opaque windows and popups"
L["OPT_SHOW_MINIMAP"]               = "Show Minimap Icon"
L["CONTEXT_LORE_BTN"]               = "IMAGO Lore"
L["CONTEXT_LORE_NONE"]              = "|cFF888888IMAGO:|r No lore found for this NPC."
L["CONTEXT_LORE_COMBAT"]            = "|cFF888888IMAGO:|r Lore view is unavailable in combat."
L["CONTEXT_LORE_CHRONICLE_FAIL"]    = "|cFF888888IMAGO:|r The Chronicle could not focus on this entry."
L["DISPLAY_PROGRESS_NPC"]           = "Progress: %d%% (%d/%d NPCs)"
L["DISPLAY_PROGRESS_ZONE"]          = "Progress: %d%% (%d/%d zones)"
L["CMD_HELP_OPEN"]                  = "/imago open   — Open the Chronicle"
L["CMD_HELP_UNLOCK"]                = "/imago unlock — Layout mode"
L["CMD_HELP_TEST"]                  = "/imago test   — Test display"
L["CMD_HELP_RESET"]                 = "/imago reset  — Reset discovered entries"
L["CMD_HELP_OPEN_DESC"]             = "Opens or closes the Chronicle"
L["CMD_HELP_SETTINGS_DESC"]         = "Opens the addon settings"
L["CMD_HELP_HELP_DESC"]             = "Shows this help message"

-- Categories (Alliance)
L["CAT_STORMWIND"]                  = "Kingdom of Stormwind"
L["CAT_IRONFORGE"]                  = "Dwarves of Ironforge"
L["CAT_GNOMEREGAN"]                 = "Gnomeregan Exiles"
L["CAT_DARNASSUS"]                  = "Night Elves of Darnassus"
L["CAT_THERAMORE"]                  = "Theramore"
L["CAT_WILDHAMMER"]                 = "Wildhammer Clan"

-- Categories (Horde)
L["CAT_ORCS"]                       = "Orcs of the Horde"
L["CAT_DARKSPEAR"]                  = "Darkspear Trolls"
L["CAT_FORSAKEN"]                   = "The Forsaken"
L["CAT_THUNDERBLUFF"]               = "Tauren of Thunder Bluff"

-- Categories (Others)
L["CAT_SKYBORNE"]                   = "Skyborne"
L["CAT_CENARION"]                   = "Cenarion Circle"
L["CAT_ARGENT"]                     = "Argent Dawn & Silver Hand"
L["CAT_DALARAN"]                    = "Dalaran & the Kirin Tor"
L["CAT_GOBLIN"]                     = "Goblin Cartels"
L["CAT_SHENDRALAR"]                 = "Shen'dralar"
L["CAT_DRAGONFLIGHTS"]              = "Dragonflights"
L["CAT_ELEMENTALS"]                 = "Elementals"
L["CAT_CENTAUR"]                    = "Centaur Clans"
L["CAT_NEUTRAL"]                    = "Neutral/Independent"
L["CAT_CUSTOM"]                     = "Custom"

-- ============================================================
-- TAB 2: ZONES (DASHBOARD & DETAILS)
-- ============================================================
L["FOOTER_ZONES_PROGRESS"]          = "%d / %d Zones discovered (%d%%)"
L["STARTPAGE_ZONES_RANK"]           = "EXPLORATION STATUS"
L["STARTPAGE_ZONES_NEXT"]           = "UPCOMING DISCOVERIES:"
L["ZONE_UNKNOWN_NAME"]              = "Unknown Region"
L["ZONE_UNEXPLORED_HEADER"]         = "AREA UNEXPLORED"
L["ZONE_UNEXPLORED_DESC"]           = "The cartography of this region is still incomplete.\nTravel there to reveal its secrets."
L["ZONE_POI_HEADER"]                = "POINTS OF INTEREST"
L["ZONE_UNDISCOVERED"]              = "Undiscovered"

-- ============================================================
-- TAB 3: RACES
-- ============================================================
L["RACES_OVERVIEW"]              = "RACES"
L["FOOTER_RACES_PROGRESS"]       = "%d / %d Races documented (%d%%)"
L["STARTPAGE_RACES_RANK"]        = "LORE STANDING"
L["STARTPAGE_RACES_NEXT"]        = "UPCOMING STANDINGS:"
L["CHAT_RACE_DISCOVERY"]         = "|cFF9370DB[IMAGO]|r New race documented: |cFFFFD700%s|r"
L["DISPLAY_PROGRESS_RACE"]       = "Progress: %d%% (%d/%d Races)"
L["FILTER_ALL_RACES"]            = "All Races"
L["RACE_ALIGN_ALLIANCE"]             = "Alliance"
L["RACE_ALIGN_HORDE"]                = "Horde"
L["RACE_ALIGN_NEUTRAL"]              = "Neutral"
L["HINT_RACE_LOCKED"]            = "PEOPLE UNKNOWN"
L["HINT_RACE_LOCKED_DESC"]       = "Meet a member of this race in the world to reveal its chronicle entry."
L["RACE_TAB_HISTORY"]                = "History"
L["RACE_TAB_GROUPS"]              = "Groups"
L["RACE_TAB_FIGURES"]                = "Figures"
L["RACE_TAB_SETTLEMENTS"]            = "Settlements"
L["RACE_TAB_CULTURE"]                = "Culture"
L["RACE_SEC_BIOLOGY"]                = "Physiology & Society"
L["RACE_SEC_BELIEFS"]                = "Beliefs"
L["RACE_SEC_RELATIONS"]              = "Relations"
L["RACE_EMPTY_GROUPS"]            = "No groups recorded."
L["RACE_EMPTY_FIGURES"]              = "No notable figures recorded."
L["RACE_EMPTY_SETTLEMENTS"]          = "No settlements recorded."
L["RACE_CAP_MALE"]                   = "Male"
L["RACE_CAP_FEMALE"]                 = "Female"
L["RACE_CAP_TABARD"]                 = "Tabard"
L["RACE_CAP_LEADER"]                 = "Leader"
L["RACE_CAP_MOUNT"]                  = "Racial Mount"
L["RACE_CAP_EPIC_MOUNT"]             = "Epic Racial Mount"

-- ============================================================
-- TAB 4: CLASSES (skeleton)
-- ============================================================
L["CLASSES_OVERVIEW"]                = "CLASSES"
L["FOOTER_CLASSES_PROGRESS"]         = "%d Classes"
L["STARTPAGE_CLASSES_RANK"]          = "CLASS ARCHIVES"
L["CLASS_TAB_OVERVIEW"]              = "Overview"
L["CLASS_TAB_MECHANICS"]             = "Mechanics"
L["CLASS_TAB_TALENTS"]               = "Talents"
L["CLASS_TAB_TRAINERS"]              = "Trainers"

-- ============================================================
-- TAB 5: CODEX
-- ============================================================
L["TAB_CODEX"]                      = "Codex"
L["CODEX_OVERVIEW"]                 = "CATEGORIES"
L["CODEX_CAT_COSMOLOGY"]            = "Cosmology"
L["CODEX_CAT_MAGIC"]                = "Magic & Powers"
L["CODEX_CAT_PEOPLES"]              = "Peoples & Origins"
L["CODEX_CAT_HISTORY"]              = "History & Concepts"
L["CODEX_CAT_FACTIONS"]             = "Factions & Orders"
L["CODEX_RELATED"]                  = "RELATED ENTRIES"
L["CODEX_EMPTY"]                    = "No entries in this category."
L["CODEX_SEARCH_EMPTY"]             = "No entries match this search."
L["CODEX_SEARCH_RESULTS"]           = "Search Results"

-- Scanner & Tooltip
L["TOOLTIP_KNOWN"]                  = "IMAGO: |cFFFFD700Recorded in Chronicle|r"
L["TOOLTIP_UNKNOWN"]                = "IMAGO: |cFF888888Fate hidden (Target to uncover)|r"
L["CHAT_DISCOVERY"]                 = "|cFF9370DB[IMAGO]|r Your chronicle trembles... a new echo is bound: |cFFFFD700%s|r"
L["QUEST_DISCOVERY"]                = "|cFF9370DB[IMAGO]|r Your chronicle trembles after completing the quest: |cFFFFD700%s|r... a new echo is bound: |cFFFFD700%s|r"
L["CHAT_KNOWN"]                     = "|cFF888888[IMAGO]|r Archive entry accessed: |cFFCCCCCC%s|r"

-- Validation
L["VAL_START"]                      = "|cFFFFD700[IMAGO]|r Starting database validation..."
L["VAL_ERR_ID"]                     = "|cFFFF0000Error:|r %s has neither displayID nor ids array!"
L["VAL_WARN_LORE"]                  = "|cFFFF8C00Warning:|r %s has no lore in the current language!"
L["VAL_DONE"]                       = "Validation complete. %d NPCs checked. %d critical errors, %d warnings."

L["CINEMATIC_CONTINUE"]             = "< Click to uncover their fate >"
L["FILTER_ALL"]                     = "All Echoes"
L["FILTER_HIST"]                    = "Recently Discovered"
L["FILTER_FAV"]                     = "Favorites"
L["HINT_IDENTITY_HIDDEN"]           = "IDENTITY HIDDEN"
L["DASHBOARD_FATES_UNCOVERED"]      = "Fates Uncovered"
L["DASHBOARD_TITLE"]                = "CHRONICLE OVERVIEW"
L["LOGIN_DID_YOU_KNOW"]             = "Did you know?"
L["FUN_FACT"]                       = "Fun Fact"
L["DID_YOU_KNOW"]                   = "Did you know?"
L["HISTORICAL_FACT"]                = "Historical Fact"
L["BEHIND_THE_SCENES"]              = "Behind the Scenes"
L["NEXT"]                           = "Next"
L["LOGIN_EMPTY_CHRONICLE"]          = "Your chronicle is still empty..."
L["LOGIN_ALL_UNCOVERED"]            = "All secrets have been revealed!"
L["FOOTER_PROGRESS"]                = "%d / %d Fates uncovered (%d%%)"
L["TAB_FATES"]                      = "Fates"
L["TAB_ZONES"]                      = "Zones"
L["TAB_RACES"]                   = "Races"
L["TAB_CLASSES"]                    = "Classes"
L["SEARCH_IN_FATES"]                = "Search Fates..."
L["SEARCH_IN_ZONES"]                = "Search Zones..."
L["SEARCH_IN_RACES"]                = "Search Races..."
L["SEARCH_IN_CLASSES"]              = "Search Classes..."
L["SEARCH_IN_CODEX"]                = "Search in Codex..."
L["STARTPAGE_RANK"]                 = "Your Standing in the Chronicle:"
L["STARTPAGE_COMPLETED"]            = "REACHED MILESTONES:"
L["STARTPAGE_NEXT"]                 = "HIDDEN MILESTONES:"
L["WORD_AT"]                        = "at"
L["STARTPAGE_NO_MILESTONES"]        = "|cFF888888No milestones reached yet.|r"
L["STARTPAGE_MAX_REACHED"]          = "|cFF00FF00Maximum reached!|r"
L["TAG_NEW"]                        = "[ NEW ]"
L["HINT_SCOUTS"]                    = "Faction scouts report recent sightings in the following areas:\n\n|cFFFFD700%s|r"
L["HINT_UNKNOWN_LOC"]               = "The location is currently not recorded in the archives. Search the world for clues."
L["TAB_DETAIL_LORE"]                = "Lore"
L["TAB_DETAIL_TIMELINE"]            = "Timeline"
L["CMD_UNLOCKALL_SUCCESS"]          = "Success: All %d echoes of the past have been unlocked in the chronicle!"

-- Minimap Tooltip
L["MINIMAP_TOOLTIP_TITLE"]          = "IMAGO"
L["MINIMAP_TOOLTIP_LEFTCLICK"]      = "Left Click: Open Chronicle"
L["MINIMAP_TOOLTIP_RIGHTCLICK"]     = "Right Click: Idle Flashcards"

-- Combat & Break Contact Settings
L["OPT_CLOSE_ON_COMBAT"]            = "Close Discovery Card when entering combat"
L["OPT_ENABLE_BREAK_CONTACT"]       = "Close Discovery Card when moving away from NPC"
L["OPT_BREAK_CONTACT_DISTANCE"]     = "Distance threshold (yards)"

-- Credits
L["TAB_CREDITS"]                    = "Credits"
L["CREDITS_TITLE"]                  = "CONTRIBUTORS"
L["CREDITS_DESC"]                   = "A huge thank you to the IMAGO Discord community for enriching this addon with their knowledge and passion."
L["CREDITS_TOP_HINT"]               = "|cFFFFD700Highlighted names|r mark members with an exceptionally high number of contributions to the database."
L["CREDITS_ROLE_SCRIBE"]            = "Lore Scribes"
L["CREDITS_ROLE_ARCHIVIST"]         = "Archivists"
L["CREDITS_ROLE_MINER"]             = "Data Miners"
L["CREDITS_ROLE_TRANSLATOR"]        = "Translators"
L["CREDITS_ROLE_TESTER"]            = "Testers"

-- Midnight Spoiler Protection
L["SPOILER_FOREVER_TITLE"]          = "Forever Event"
L["SPOILER_FOREVER_HINT"]           = "Click to reveal"
L["SPOILER_TOOLTIP_TITLE"]          = "SPOILER"
L["SPOILER_TOOLTIP_DESC"]           = "Current Forever events"

-- Mode Toggle
L["MODE_LABEL"]                     = "Mode"
L["MODE_EXPLORER"]                  = "Explorer Mode"
L["MODE_ENCYCLOPEDIA"]              = "Encyclopedia Mode"
L["MODE_MANUAL_UNLOCK"]             = "Manually unlock"

-- Map Toggle --
L["ACTION_OPEN_MAP"]                = "Open World Map"
L["ACTION_OPEN_MAP_TIP"]            = "Open this zone on the World Map"
L["ACTION_OPEN_EJ"]                 = "Open in Encounter Journal"
L["ACTION_OPEN_IMAGO"]              = "Open in IMAGO Chronicle"

-- Confirm Dialogs
L["CONFIRM_YES"]                    = "Yes"
L["CONFIRM_NO"]                     = "No"
L["CONFIRM_ENC_TITLE"]              = "Enable Encyclopedia Mode"
L["CONFIRM_ENC_DESC"]               = "All content becomes visible,\nbut won't count toward your progress.\n\nContinue?"
L["CONFIRM_UNLOCK_TITLE"]           = "Unlock Content Preview"
L["CONFIRM_UNLOCK_DESC"]            = "This entry will become readable but won't count toward your progress.\n\nUnlock?"
L["BACK"]                           = "Back"

