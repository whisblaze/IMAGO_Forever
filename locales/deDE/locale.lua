-- ============================================================
-- IMAGO — core/Locale_deDE.lua
-- German localization
-- ============================================================

IMAGO = IMAGO or {}
IMAGO.LocaleData = IMAGO.LocaleData or {}

local L = {}
IMAGO.LocaleData.deDE = L

-- UI texts
L["WINDOW_TITLE"]                   = "Chronik der Unvergessenen"
L["UNDISCOVERED"]                   = "Unentdeckt"
L["UNDISCOVERED_LORE"]              = "Finde diese Person in der Welt, um ihr Schicksal zu entschlüsseln."
L["ADDON_ENABLED"]                  = "IMAGO aktiviert."
L["ADDON_DISABLED"]                 = "IMAGO deaktiviert."
L["RESET_DONE"]                     = "Alle gesehenen Einträge wurden zurückgesetzt."
L["SETTINGS_TITLE"]                 = "IMAGO - Einstellungen"
L["SETTINGS_DESC"]                  = "Die Welt hat eine Geschichte. IMAGO bewahrt sie."
L["SETTINGS_SEC_GENERAL"]           = "Allgemein"
L["SETTINGS_SEC_DISCOVERY_CARD"]    = "Discovery Card (NPC/Zonen-Popup)"
L["SETTINGS_SEC_IDLE_FLASHCARDS"]   = "Idle Flashcards (Snippets)"
L["SETTINGS_SEC_MOTD"]              = "Imago MotD (Chat)"
L["SETTINGS_SEC_UI"]                = "UI"
L["SETTINGS_SEC_LANGUAGE"]          = "Sprache"
L["OPT_LANGUAGE"]                   = "Addon-Sprache"
L["OPT_LANGUAGE_NOTE"]              = "\195\132nderung wird erst nach /reload wirksam."
L["OPT_ENABLE"]                     = "IMAGO aktivieren"
L["OPT_ENABLE_IDLE_FLASHCARDS"]     = "Idle Flashcards aktivieren"
L["OPT_ENABLE_MOTD"]                = "Imago MotD aktivieren (\"Wusstest du schon?\" im Chat)"
L["OPT_ONCE_ONLY_NPC"]              = "NPC-Texte nur beim ersten Entdecken anzeigen"
L["OPT_ONCE_ONLY_ZONE"]             = "Zonen-Texte nur beim ersten Entdecken anzeigen"
L["OPT_RESET_BTN"]                  = "Historie zurücksetzen"
L["OPT_SCALE"]                      = "Fenstergröße (Skalierung)"
L["OPT_MAIN_LORE_NO_TIMER"]         = "Discovery Card offen lassen (kein Timer)"
L["OPT_SNIPPET_NO_TIMER"]           = "Idle Flashcards offen lassen (kein Timer)"
L["OPT_OPAQUE_UI"]                  = "100% intransparente Fenster und Popups"
L["OPT_SHOW_MINIMAP"]               = "Minimap-Symbol anzeigen"
L["CONTEXT_LORE_BTN"]               = "IMAGO Lore"
L["CONTEXT_LORE_NONE"]              = "|cFF888888IMAGO:|r Keine Lore für diesen NPC gefunden."
L["CONTEXT_LORE_COMBAT"]            = "|cFF888888IMAGO:|r Lore-Anzeige im Kampf nicht verfügbar."
L["CONTEXT_LORE_CHRONICLE_FAIL"]    = "|cFF888888IMAGO:|r Chronik konnte den Eintrag nicht fokussieren."
L["DISPLAY_PROGRESS_NPC"]           = "Fortschritt: %d%% (%d/%d NPCs)"
L["DISPLAY_PROGRESS_ZONE"]          = "Fortschritt: %d%% (%d/%d Zonen)"
L["CMD_HELP_OPEN"]                  = "/imago open   — Öffnet die Chronik"
L["CMD_HELP_UNLOCK"]                = "/imago unlock — Layout-Modus"
L["CMD_HELP_TEST"]                  = "/imago test   — Testanzeige"
L["CMD_HELP_RESET"]                 = "/imago reset  — Gesehene Einträge zurücksetzen"
L["CMD_HELP_OPEN_DESC"]             = "Öffnet oder schließt die Chronik"
L["CMD_HELP_SETTINGS_DESC"]         = "Öffnet die Addon-Einstellungen"
L["CMD_HELP_HELP_DESC"]             = "Zeigt diese Hilfe an"

-- Categories (Alliance)
L["CAT_STORMWIND"]                  = "Königreich Sturmwind"
L["CAT_IRONFORGE"]                  = "Zwerge von Eisenschmiede"
L["CAT_GNOMEREGAN"]                 = "Gnomeregan-Exilanten"
L["CAT_DARNASSUS"]                  = "Nachtelfen von Darnassus"
L["CAT_THERAMORE"]                  = "Theramore"
L["CAT_WILDHAMMER"]                 = "Wildhammerklan"

-- Categories (Horde)
L["CAT_ORCS"]                       = "Orcs der Horde"
L["CAT_DARKSPEAR"]                  = "Dunkelspeertrolle"
L["CAT_FORSAKEN"]                   = "Die Verlassenen"
L["CAT_THUNDERBLUFF"]               = "Tauren von Donnerfels"

-- Categories (Others)
L["CAT_SKYBORNE"]                   = "Skyborne"
L["CAT_CENARION"]                   = "Zirkel des Cenarius"
L["CAT_ARGENT"]                     = "Argentumdämmerung & Silberne Hand"
L["CAT_DALARAN"]                    = "Dalaran & die Kirin Tor"
L["CAT_GOBLIN"]                     = "Goblinkartelle"
L["CAT_SHENDRALAR"]                 = "Die Shen'dralar"
L["CAT_DRAGONFLIGHTS"]              = "Drachenschwärme"
L["CAT_ELEMENTALS"]                 = "Elementare"
L["CAT_CENTAUR"]                    = "Zentaurenklans"
L["CAT_NEUTRAL"]                    = "Neutral/Unabhängig"
L["CAT_CUSTOM"]                     = "Eigene"

-- ============================================================
-- TAB 2: ZONES (DASHBOARD & DETAILS)
-- ============================================================
L["FOOTER_ZONES_PROGRESS"]          = "%d / %d Zonen entdeckt (%d%%)"
L["STARTPAGE_ZONES_RANK"]           = "ERKUNDUNGS-STATUS"
L["STARTPAGE_ZONES_NEXT"]           = "KOMMENDE ENTDECKUNGEN:"
L["ZONE_UNKNOWN_NAME"]              = "Unbekannte Region"
L["ZONE_UNEXPLORED_HEADER"]         = "GEBIET UNERKUNDET"
L["ZONE_UNEXPLORED_DESC"]           = "Die Kartographie dieser Region ist noch unvollständig.\nReise dorthin, um ihre Geheimnisse zu offenbaren."
L["ZONE_POI_HEADER"]                = "INTERESSANTE ORTE"
L["ZONE_UNDISCOVERED"]              = "Unentdeckt"

-- ============================================================
-- TAB 3: RACES
-- ============================================================
L["RACES_OVERVIEW"]              = "VÖLKER"
L["FOOTER_RACES_PROGRESS"]       = "%d / %d Völker dokumentiert (%d%%)"
L["STARTPAGE_RACES_RANK"]        = "KENNTNIS DER VÖLKER"
L["STARTPAGE_RACES_NEXT"]        = "KOMMENDE RÄNGE:"
L["CHAT_RACE_DISCOVERY"]         = "|cFF9370DB[IMAGO]|r Neues Volk dokumentiert: |cFFFFD700%s|r"
L["DISPLAY_PROGRESS_RACE"]       = "Fortschritt: %d%% (%d/%d Völker)"
L["FILTER_ALL_RACES"]            = "Alle Völker"
L["RACE_ALIGN_ALLIANCE"]             = "Allianz"
L["RACE_ALIGN_HORDE"]                = "Horde"
L["RACE_ALIGN_NEUTRAL"]              = "Neutral"
L["HINT_RACE_LOCKED"]            = "VOLK UNBEKANNT"
L["HINT_RACE_LOCKED_DESC"]       = "Begegne einem Angehörigen dieses Volkes in der Welt, um ihren Chronik-Eintrag zu enthüllen."
L["RACE_TAB_HISTORY"]                = "Geschichte"
L["RACE_TAB_GROUPS"]              = "Gruppen"
L["RACE_TAB_FIGURES"]                = "Persönlichkeiten"
L["RACE_TAB_SETTLEMENTS"]            = "Siedlungen"
L["RACE_TAB_CULTURE"]                = "Kultur"
L["RACE_SEC_BIOLOGY"]                = "Physiologie & Gesellschaft"
L["RACE_SEC_BELIEFS"]                = "Glauben"
L["RACE_SEC_RELATIONS"]              = "Beziehungen"
L["RACE_EMPTY_GROUPS"]            = "Keine Gruppen verzeichnet."
L["RACE_EMPTY_FIGURES"]              = "Keine nennenswerten Persönlichkeiten verzeichnet."
L["RACE_EMPTY_SETTLEMENTS"]          = "Keine Siedlungen verzeichnet."
L["RACE_CAP_MALE"]                   = "Männlich"
L["RACE_CAP_FEMALE"]                 = "Weiblich"
L["RACE_CAP_TABARD"]                 = "Wappenrock"
L["RACE_CAP_LEADER"]                 = "Anführer"
L["RACE_CAP_MOUNT"]                  = "Völker-Reittier"
L["RACE_CAP_EPIC_MOUNT"]             = "Episches Reittier"

-- ============================================================
-- TAB 4: CLASSES (skeleton)
-- ============================================================
L["CLASSES_OVERVIEW"]                = "KLASSEN"

-- Scanner & Tooltip
L["TOOLTIP_KNOWN"]                  = "IMAGO: |cFFFFD700In Chronik verzeichnet|r"
L["TOOLTIP_UNKNOWN"]                = "IMAGO: |cFF888888Schicksal verborgen (Anvisieren zum Entschlüsseln)|r"
L["CHAT_DISCOVERY"]                 = "|cFF9370DB[IMAGO]|r Deine Chronik erzittert... ein neues Echo wurde gebunden: |cFFFFD700%s|r"
L["QUEST_DISCOVERY"]                = "|cFF9370DB[IMAGO]|r Deine Chronik erzittert nach Abschluss der Quest: |cFFFFD700%s|r... ein neues Echo wurde gebunden: |cFFFFD700%s|r"
L["CHAT_KNOWN"]                     = "|cFF888888[IMAGO]|r Archiv-Eintrag abgerufen: |cFFCCCCCC%s|r"

-- Validation
L["VAL_START"]                      = "|cFFFFD700[IMAGO]|r Starte Datenbank-Validierung..."
L["VAL_ERR_ID"]                     = "|cFFFF0000Fehler:|r %s hat weder displayID noch ids-Array!"
L["VAL_WARN_LORE"]                  = "|cFFFF8C00Warnung:|r %s hat keine Lore in der aktuellen Sprache!"
L["VAL_DONE"]                       = "Validierung beendet. %d NPCs geprüft. %d kritische Fehler, %d Warnungen."

L["CINEMATIC_CONTINUE"]             = "< Klicken, um das Schicksal zu entschlüsseln >"
L["FILTER_ALL"]                     = "Alle Echos"
L["FILTER_HIST"]                    = "Zuletzt entdeckt"
L["FILTER_FAV"]                     = "Favoriten"
L["HINT_IDENTITY_HIDDEN"]           = "IDENTITÄT VERBORGEN"
L["DASHBOARD_FATES_UNCOVERED"]      = "Schicksale entschlüsselt"
L["DASHBOARD_TITLE"]                = "CHRONIK ÜBERSICHT"
L["LOGIN_DID_YOU_KNOW"]             = "Wusstest du schon?"
L["FUN_FACT"]                       = "Fun Fact"
L["DID_YOU_KNOW"]                   = "Wusstest du schon?"
L["HISTORICAL_FACT"]                = "Historischer Fakt"
L["BEHIND_THE_SCENES"]              = "Hinter den Kulissen"
L["NEXT"]                           = "Weiter"
L["LOGIN_EMPTY_CHRONICLE"]          = "Deine Chronik ist noch leer..."
L["LOGIN_ALL_UNCOVERED"]            = "Alle Geheimnisse gelüftet!"
L["FOOTER_PROGRESS"]                = "%d / %d Schicksale entschlüsselt (%d%%)"
L["TAB_FATES"]                      = "Schicksale"
L["TAB_ZONES"]                      = "Zonen"
L["TAB_RACES"]                   = "Völker"
L["TAB_CLASSES"]                    = "Klassen"
L["SEARCH_IN_FATES"]                = "Schicksale suchen..."
L["SEARCH_IN_ZONES"]                = "Zonen suchen..."
L["SEARCH_IN_RACES"]                = "Völker suchen..."
L["SEARCH_IN_CLASSES"]              = "Klassen suchen..."
L["SEARCH_IN_CODEX"]                = "Im Kodex suchen..."
L["TAB_CODEX"]                      = "Kodex"
L["CODEX_OVERVIEW"]                 = "KATEGORIEN"
L["CODEX_CAT_COSMOLOGY"]            = "Kosmologie"
L["CODEX_CAT_MAGIC"]                = "Magie & Mächte"
L["CODEX_CAT_PEOPLES"]              = "Völker & Ursprünge"
L["CODEX_CAT_HISTORY"]              = "Geschichte & Konzepte"
L["CODEX_CAT_FACTIONS"]             = "Fraktionen & Orden"
L["CODEX_RELATED"]                  = "VERWANDTE EINTRÄGE"
L["CODEX_EMPTY"]                    = "Keine Einträge in dieser Kategorie."
L["CODEX_SEARCH_EMPTY"]             = "Keine Einträge gefunden."
L["CODEX_SEARCH_RESULTS"]           = "Suchergebnisse"
L["STARTPAGE_RANK"]                 = "Dein Stand in der Chronik:"
L["STARTPAGE_COMPLETED"]            = "ERREICHTE MEILENSTEINE:"
L["STARTPAGE_NEXT"]                 = "KOMMENDE ENTDECKUNGEN:"
L["WORD_AT"]                        = "bei"
L["STARTPAGE_NO_MILESTONES"]        = "|cFF888888Noch keine Meilensteine erreicht.|r"
L["STARTPAGE_MAX_REACHED"]          = "|cFF00FF00MAXIMALRANG ERREICHT!|r"
L["TAG_NEW"]                        = "[ NEU ]"
L["HINT_SCOUTS"]                    = "Späher der Fraktionen berichten von jüngsten Sichtungen in folgenden Gebieten:\n\n|cFFFFD700%s|r"
L["HINT_UNKNOWN_LOC"]               = "Der Aufenthaltsort ist in den Archiven aktuell nicht verzeichnet. Suche in der Welt nach Hinweisen."
L["TAB_DETAIL_LORE"]                = "Lore"
L["TAB_DETAIL_TIMELINE"]            = "Timeline"
L["CMD_UNLOCKALL_SUCCESS"]          = "Erfolg: Alle %d Echos der Vergangenheit wurden in der Chronik freigeschaltet!"

-- Minimap Tooltip
L["MINIMAP_TOOLTIP_TITLE"]          = "IMAGO"
L["MINIMAP_TOOLTIP_LEFTCLICK"]      = "Linksklick: Chronik öffnen"
L["MINIMAP_TOOLTIP_RIGHTCLICK"]     = "Rechtsklick: Idle Flashcards"

-- Combat & Break Contact Settings
L["OPT_CLOSE_ON_COMBAT"]            = "Discovery Card bei Kampfbeginn schließen"
L["OPT_ENABLE_BREAK_CONTACT"]       = "Discovery Card bei Entfernung vom NPC schließen"
L["OPT_BREAK_CONTACT_DISTANCE"]     = "Distanz-Schwellenwert (m)"

-- Credits
L["TAB_CREDITS"]                    = "Credits"
L["CREDITS_TITLE"]                  = "MITWIRKENDE"
L["CREDITS_DESC"]                   = "Ein großes Dankeschön an die IMAGO Discord Community, die dieses Addon mit ihrem Wissen und ihrer Leidenschaft bereichert hat."
L["CREDITS_TOP_HINT"]               = "|cFFFFD700Hervorgehobene Namen|r markieren Mitglieder mit besonders vielen Beiträgen zur Datenbank."
L["CREDITS_ROLE_SCRIBE"]            = "Lore Scribes"
L["CREDITS_ROLE_ARCHIVIST"]         = "Archivists"
L["CREDITS_ROLE_MINER"]             = "Data Miners"
L["CREDITS_ROLE_TRANSLATOR"]        = "Translators"
L["CREDITS_ROLE_TESTER"]            = "Testers"

-- Midnight Spoiler Protection
L["SPOILER_FOREVER_TITLE"]          = "Forever-Ereignis"
L["SPOILER_FOREVER_HINT"]           = "Klicken zum Anzeigen"
L["SPOILER_TOOLTIP_TITLE"]          = "SPOILER"
L["SPOILER_TOOLTIP_DESC"]           = "Aktuelle Forever-Ereignisse"

-- Mode Toggle
L["MODE_LABEL"]                     = "Modus"
L["MODE_EXPLORER"]                  = "Entdecker-Modus"
L["MODE_ENCYCLOPEDIA"]              = "Enzyklopädie-Modus"
L["MODE_MANUAL_UNLOCK"]             = "Manuell freischalten"

-- Map Toggle --
L["ACTION_OPEN_MAP"]                = "Weltkarte öffnen"
L["ACTION_OPEN_MAP_TIP"]            = "Diese Zone auf der Weltkarte öffnen"
L["ACTION_OPEN_EJ"]                 = "Open in Encounter Journal"
L["ACTION_OPEN_IMAGO"]              = "Open in IMAGO Chronicle"

-- Confirm Dialogs
L["CONFIRM_YES"]                    = "Ja"
L["CONFIRM_NO"]                     = "Nein"
L["CONFIRM_ENC_TITLE"]              = "Enzyklopädie-Modus aktivieren"
L["CONFIRM_ENC_DESC"]               = "Alle Inhalte werden sichtbar,\nzählen aber nicht für deinen Fortschritt.\n\nFortfahren?"
L["CONFIRM_UNLOCK_TITLE"]           = "Inhaltsvorschau freischalten"
L["CONFIRM_UNLOCK_DESC"]            = "Dieser Eintrag wird für dich lesbar, zählt aber nicht für deinen Fortschritt.\n\nFreischalten?"
L["BACK"]                           = "Zurück"

-- Credits
L["TAB_CREDITS"] = "Credits"
L["CREDITS_TITLE"] = "MITWIRKENDE"
L["CREDITS_DESC"] = "Ein großes Dankeschön an die IMAGO Discord Community, die dieses Addon mit ihrem Wissen und ihrer Leidenschaft bereichert hat."
L["CREDITS_TOP_HINT"] = "|cFFFFD700Hervorgehobene Namen|r markieren Mitglieder mit besonders vielen Beiträgen zur Datenbank."
L["CREDITS_ROLE_SCRIBE"] = "Lore Scribes"
L["CREDITS_ROLE_ARCHIVIST"] = "Archivists"
L["CREDITS_ROLE_MINER"] = "Data Miners"
L["CREDITS_ROLE_TRANSLATOR"] = "Translators"
L["CREDITS_ROLE_TESTER"] = "Testers"
