-- ============================================================
-- IMAGO — core/Locale_ruRU.lua
-- Russian localization (UI chrome only — lore stays EN/DE)
-- ============================================================
 
IMAGO = IMAGO or {}
IMAGO.LocaleData = IMAGO.LocaleData or {}
 
local L = {}
IMAGO.LocaleData.ruRU = L
 
-- UI texts (translated)
L["WINDOW_TITLE"]                   = "Хроники Незабытых"
L["UNDISCOVERED"]                   = "Не известно"
L["UNDISCOVERED_LORE"]              = "Найдите этого персонажа, чтобы раскрыть его судьбу."
L["ADDON_ENABLED"]                  = "IMAGO включен."
L["ADDON_DISABLED"]                 = "IMAGO отключен."
L["RESET_DONE"]                     = "Все найденные записи были сброшены."
L["SETTINGS_TITLE"]                 = "IMAGO - Настройки"
L["SETTINGS_DESC"]                  = "Мир полон историй. IMAGO их записывает."
L["SETTINGS_SEC_GENERAL"]           = "Общие"
L["SETTINGS_SEC_DISCOVERY_CARD"]    = "Карточка Исследования (Всплывающие окна Персонажей/Зон)"
L["SETTINGS_SEC_IDLE_FLASHCARDS"]   = "Флеш-карточки в режиме ожидания (фрагменты)"
L["SETTINGS_SEC_MOTD"]              = "Сообшение дня IMAGO (чат)"
L["SETTINGS_SEC_UI"]                = "UI"
L["OPT_ENABLE"]                     = "Включить IMAGO"
L["OPT_ENABLE_IDLE_FLASHCARDS"]     = "Включить флеш-карточки в режиме ожидания"
L["OPT_ENABLE_MOTD"]                = "Включить сообщения дня IMAGO (\"А вы знали?\" в чате)"
L["OPT_ONCE_ONLY_NPC"]              = "Показывать лор Персонажей только при первом исследовании"
L["OPT_ONCE_ONLY_ZONE"]             = "Показывать лор Зон только при первом исследовании"
L["OPT_RESET_BTN"]                  = "Сбросить историю"
L["OPT_SCALE"]                      = "Размер окна"
L["OPT_MAIN_LORE_NO_TIMER"]         = "Держать Карточки Исследования открытыми (без таймера)"
L["OPT_SNIPPET_NO_TIMER"]           = "Держать флеш-карточки в режиме ожидания открытыми (без таймера)"
L["OPT_OPAQUE_UI"]                  = "100% непрозрачность окон и всплывающих окон"
L["OPT_SHOW_MINIMAP"]               = "Показывать иконку у миникарты"
L["CONTEXT_LORE_BTN"]               = "IMAGO Лор"
L["CONTEXT_LORE_NONE"]              = "|cFF888888IMAGO:|r Лор этого Персонажа не найден."
L["CONTEXT_LORE_COMBAT"]            = "|cFF888888IMAGO:|r Просмотр лора недоступен во время боя."
L["CONTEXT_LORE_CHRONICLE_FAIL"]    = "|cFF888888IMAGO:|r Хроники не смогли сфокусироваться на этой записи."
L["DISPLAY_PROGRESS_NPC"]           = "Прогресс: %d%% (%d/%d Персонажи)"
L["DISPLAY_PROGRESS_ZONE"]          = "Прогресс: %d%% (%d/%d Зоны)"
L["CMD_HELP_OPEN"]                  = "/imago open   — Открыть Хроники"
L["CMD_HELP_UNLOCK"]                = "/imago unlock — Изменить размер"
L["CMD_HELP_TEST"]                  = "/imago test   — Тест экрана"
L["CMD_HELP_RESET"]                 = "/imago reset  — Сбросить найденные записи"
L["CMD_HELP_OPEN_DESC"]             = "Открывает или закрывает Хроники"
L["CMD_HELP_SETTINGS_DESC"]         = "Открывает настройки аддона"
L["CMD_HELP_HELP_DESC"]             = "Показывает это сообщение"

-- Категории (Альянс)
L["CAT_STORMWIND"]                  = "Королевство Штормград"
L["CAT_IRONFORGE"]                  = "Дворфы Стальгорна"
L["CAT_GNOMEREGAN"]                 = "Изгнанники Гномрегана"
L["CAT_DARNASSUS"]                  = "Ночные эльфы Дарнасса"
L["CAT_THERAMORE"]                  = "Терамор"
L["CAT_WILDHAMMER"]                 = "Клан Громовара"

-- Категории (Орда)
L["CAT_ORCS"]                       = "Орки Орды"
L["CAT_DARKSPEAR"]                  = "Тролли Черного Копья"
L["CAT_FORSAKEN"]                   = "Отрекшиеся"
L["CAT_THUNDERBLUFF"]               = "Таурены Громового Утёса"

-- Категории (Прочие)
L["CAT_SKYBORNE"]                   = "Неборождённые"
L["CAT_CENARION"]                   = "Круг Кенария"
L["CAT_ARGENT"]                     = "Аргентумская заря и Серебряная Длань"
L["CAT_DALARAN"]                    = "Даларан и Кирин-Тор"
L["CAT_GOBLIN"]                     = "Гоблинские картели"
L["CAT_SHENDRALAR"]                 = "Шен'дралар"
L["CAT_DRAGONFLIGHTS"]              = "Драконьи стаи"
L["CAT_ELEMENTALS"]                 = "Элементали"
L["CAT_CENTAUR"]                    = "Племена кентавров"
L["CAT_NEUTRAL"]                    = "Нейтральные/Независимые"
L["CAT_CUSTOM"]                     = "Пользовательские"

-- ============================================================
-- Вкладка 2: Зоны (ПАНЕЛЬ УПРАВЛЕНИЯ и ПОДРОБНОСТИ)
-- ============================================================
L["FOOTER_ZONES_PROGRESS"]          = "%d / %d Зон исследовано (%d%%)"
L["STARTPAGE_ZONES_RANK"]           = "РАНГ ИССЛЕДОВАТЕЛЯ"
L["STARTPAGE_ZONES_NEXT"]           = "СЛЕДУЮЩИЕ РАНГИ:"
L["ZONE_UNKNOWN_NAME"]              = "Неизвестный регион"
L["ZONE_UNEXPLORED_HEADER"]         = "ОБЛАСТЬ НЕ ИССЛЕДОВАНА"
L["ZONE_UNEXPLORED_DESC"]           = "Местность этого региона исследована не до конца. Отправьтесь туда, чтобы расскрыть его секреты."
L["ZONE_POI_HEADER"]                = "ОСНОВНЫЕ МЕСТА"
L["ZONE_UNDISCOVERED"]              = "Не исследовано"

-- ============================================================
-- Вкладка 3: Инстансы (скоро)
-- ============================================================
L["COMING_SOON_INSTANCES_TITLE"]    = "СКРЫТЫЕ ПОДЗОНЫ"
L["COMING_SOON_INSTANCES_DESC"]     = "Подземелья, рейды и вылазки. \nОтголоски могущственных противников ждут своего часа.\n\n|cFF9370DB[ В РАЗРАБОТКЕ ]"

-- Сканер и всплывающая подсказка
L["TOOLTIP_KNOWN"]                  = "IMAGO: |cFFFFD700 Записан в Хрониках|r"
L["TOOLTIP_UNKNOWN"]                = "IMAGO: |cFF888888 Судьба не раскрыта (Цель для обнаружения)|r"
L["CHAT_DISCOVERY"]                 = "|cFF9370DB[IMAGO]|r Ваши Хроники содрогнулись... новый отголоск добавлен: |cFFFFD700%s|r"
L["QUEST_DISCOVERY"]                = "|cFF9370DB[IMAGO]|r Ваша хроника содрогнулись после завершения задания : |cFFFFD700%s|r... новый отголоск добавлен: |cFFFFD700%s|r"
L["CHAT_KNOWN"]                     = "|cFF888888[IMAGO]|r Запись уже существует: "

-- Валидация
L["VAL_START"]                      = "|cFFFFD700[IMAGO]|r Запускаю валидацию базы знаний..."
L["VAL_ERR_ID"]                     = "|cFFFF0000Ошибка:|r %s отсутствуют массивы displayID и ids!"
L["VAL_WARN_LORE"]                  = "|cFFFF8C00Предупреждение:|r отстутвует лор на текущем языке!"
L["VAL_DONE"]                       = "Валидация завершена. %d Персонажей проверено. %d критических ошибок, %d предупреждений."

L["CINEMATIC_CONTINUE"]             = "< Нажмите, чтобы раскрыть их судьбу >"
L["FILTER_ALL"]                     = "Все Отголоски"
L["FILTER_HIST"]                    = "Недавно исследованные"
L["FILTER_FAV"]                     = "Избранные"
L["HINT_IDENTITY_HIDDEN"]           = "ЛИЧНОСТЬ СКРЫТА"
L["DASHBOARD_FATES_UNCOVERED"]      = "Судьбы раскрыты"
L["DASHBOARD_TITLE"]                = "ОБЗОР ХРОНИК"
L["LOGIN_DID_YOU_KNOW"]             = "А вы знали?"
L["FUN_FACT"]                       = "Интересный факт"
L["DID_YOU_KNOW"]                   = "А вы знали?"
L["HISTORICAL_FACT"]                = "Исторический факт"
L["NEXT"]                           = "Далее"
L["LOGIN_EMPTY_CHRONICLE"]          = "Ваши Хроники все еще пусты..."
L["LOGIN_ALL_UNCOVERED"]            = "Все секреты раскрыты!"
L["FOOTER_PROGRESS"]                = "%d / %d Судеб раскрыто (%d%%)"
L["TAB_FATES"]                      = "Судьбы"
L["TAB_ZONES"]                      = "Зоны"
L["TAB_INSTANCES"]                  = "Подзоны"
L["STARTPAGE_RANK"]                 = "Ваш ранг Хроник:"
L["STARTPAGE_COMPLETED"]            = "ДОСТИГНУТО РАНГОВ:"
L["STARTPAGE_NEXT"]                 = "СЛЕДУЮЩИЕ РАНГИ:"
L["WORD_AT"]                        = "при"
L["STARTPAGE_NO_MILESTONES"]        = "|cFF888888Достигнутых рангов нет.|r"
L["STARTPAGE_MAX_REACHED"]          = "|cFF00FF00 Достигнут максимум!|r"
L["TAG_NEW"]                        = "[ НОВИНКА ]"
L["HINT_SCOUTS"]                    = "Замечен разведчиками в следующих областях:\n\n|cFFFFD700%s|r"
L["HINT_UNKNOWN_LOC"]               = "Отсутствуют записи о местонахождении. Ищите зацепки, исследуя мир."
L["TAB_DETAIL_LORE"]                = "Лор"
L["TAB_DETAIL_TIMELINE"]            = "Хронология"
L["CMD_UNLOCKALL_SUCCESS"]          = "Успех: все отголоски прошлого открыты в Хрониках!"

-- Подсказка на мини-карте
L["MINIMAP_TOOLTIP_TITLE"]          = "IMAGO"
L["MINIMAP_TOOLTIP_LEFTCLICK"]      = "ЛКМ: Открыть Хроники"
L["MINIMAP_TOOLTIP_RIGHTCLICK"]     = "ПКМ: Флеш-карточки в режиме ожидания"

-- Настройки боя и отрыва от противника
L["OPT_CLOSE_ON_COMBAT"]            = "Закрыть Карточку Исследования при входе в бой"
L["OPT_ENABLE_BREAK_CONTACT"]       = "Закрыть Карточку Исследования при отдалении от Персонажа"
L["OPT_BREAK_CONTACT_DISTANCE"]     = "Пороговая дистанция (метры)"

-- Создатели
L["TAB_CREDITS"]                    = "Благодарности"
L["CREDITS_TITLE"]                  = "ВНЕСШИЕ ВКЛАД"
L["CREDITS_DESC"]                   = "Огромная благодарность всему сообществу Discord сервера IMAGO - их знания и энтузиазм наполнили этот аддон жизнью."
L["CREDITS_TOP_HINT"]               = "|cFFFFD700Выделенные имена|r принадлежат участникам, привнесшим особенно большой вклад в базу знаний."
L["CREDITS_ROLE_SCRIBE"]            = "Хранители знаний"
L["CREDITS_ROLE_ARCHIVIST"]         = "Архивисты"
L["CREDITS_ROLE_MINER"]             = "Датамайнеры"
L["CREDITS_ROLE_TRANSLATOR"]        = "Переводчики"
L["CREDITS_ROLE_TESTER"]            = "Тестировщики"

-- Защита от спойлеров
L["SPOILER_MIDNIGHT_TITLE"]         = "События Midnight"
L["SPOILER_MIDNIGHT_HINT"]          = "Нажмите для раскрытия"
L["SPOILER_TWW_TITLE"]              = "События The War Within"
L["SPOILER_TWW_HINT"]               = "Нажмите для раскрытия"
L["SPOILER_TOOLTIP_TITLE"]          = "СПОЙЛЕР"
L["SPOILER_TOOLTIP_DESC"]           = "Дополнение Midnight"
L["SPOILER_TOOLTIP_DESC_TWW"]       = "Дополнение The War Within"

-- Переключение режима
L["MODE_LABEL"]                     = "Режим"
L["MODE_EXPLORER"]                  = "Режим Исследователя"
L["MODE_ENCYCLOPEDIA"]              = "Режим Энциклопедии"
L["MODE_MANUAL_UNLOCK"]             = "Ручная разблокировка"

-- Переключатель карты
L["ACTION_OPEN_MAP"]                = "Открыть карту мира"
L["ACTION_OPEN_MAP_TIP"]            = "Открыть данную зону на карте мира"
L["ACTION_OPEN_EJ"]                 = "Открыть в Diario de mazmorra"
L["ACTION_OPEN_IMAGO"]              = "Открыть в IMAGO Хроники"

-- диалоговые окна подтверждения
L["CONFIRM_YES"]                    = "Да"
L["CONFIRM_NO"]                     = "Нет"
L["CONFIRM_ENC_TITLE"]              = "Включить Режим Энциклопедии"
L["CONFIRM_ENC_DESC"]               = "Весь контент будет раскрыт,\nно не будет учтен в вашем прогрессе.\n\nПродолжить?"
L["CONFIRM_UNLOCK_TITLE"]           = "Разблокировать запись"
L["CONFIRM_UNLOCK_DESC"]            = "Данная запись будет доступна для чтения, но не будет учтена в вашем прогрессе.\n\nРазблокировать?"
L["BACK"]                           = "Назад"
