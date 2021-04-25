setup_token = 'a2f924'
assets_deck = 'mv1s47'
boon_deck = '00c94d'
bane_deck = '4b5612'
spell_deck = 'n17byb'
talent_deck = '00c94d'
u_assets_deck = 'hr2o1d'
pawn_bag = '5p189x'
hp_bag = '14vzl8'
san_bag = '8o97r1'
trash_bag = '62mbfc'
game_board = '5y4u6n'
zone = '4i02oy'
pyramid_bag = '7r39h8'
ant_bag = '1sw2bb'
et_bag = '084f8n'
ancients_bag = 'i1suo8'
prelude_deck = '323e47'
doom_track = '0meu2k'
monster_bag = 'f784da'
epic_monster_bag = '3616e4'
mystic_bag = '9o33o4'
dream_bag = 'f35a79'
moreset = false
disaster_bag = 'f2ace9'
nyarla_bag = '142c8e'
eldritch_bag = '084f8n'

discard_bag = '84844c'

focus_bag = 'ps1q97'
clue_bag = '652d1t'
ticket_bag = '6d91f2'
will_bag = '8ca0b4'
resource_bag = 'f0fcc6'
gates_bag = '96en34'

shouldGetPrelude = "False"
shouldIncludeEasyMythos = "True"
shouldIncludeMediumMythos = "True"
shouldIncludeHardMythos = "True"

decks = {
  character = "84yoxs",
  other_worls = "ecab11",
  general = "82af68",
  america = "b2d49d",
  europe = "2bbb46",
  asia = "d90c42",
  expedition = "hz6n3c",
  assets = "mv1s47",
  spells = "n17byb",
  unique_assets = "hr2o1d",
  artifacts = "a20be5",

  -- mythos decks
  hgm = 'qszvkn',
  mgm = 'vxiwyn',
  egm = 'uc2b43',
  hym = '8c13f8',
  mym = 'n621fe',
  eym = 'cr05o1',
  hbm = 'k39546',
  mbm = '6g97ke',
  ebm = '0c9452',

  bm  = "7eaa3b",
  ym  = "c30267",
  gm  = "6c5ef6",

  -- preludes must be filtered after mythos to avoid spawning mythos cards
  preludes = "323e47",

  injuries = "07ikco",
  madnesses = "1r1szf",
  illnesses = "p754n7",
  exposures = "53tcz7",
  pursuits = "47x9bv",
  deals = "k47v7z",
  talents = "00c94d",
  banes = "4b5612",
  restrictions = "f398ba"
}

extension_codes = { "EH01", "EH02", "EH03", "EH04", "EH05", "EH06", "EH07", "EH08", "EH09" }
selected_expansions = { }

ancients_by_expansion = {
  EH01 = {"Azathoth", "Cthulhu", "Shub-Niggurath", "Yog-Sothoth" },
  EH02 = {"Yig"},
  EH03 = {"ElderThings", "Ithaqua"},
  EH04 = {"Syzygy"},
  EH05 = {"Abhoth", "Nephren-Ka"},
  EH06 = {"Hastur"},
  EH07 = {"Atlach-Nacha", "Hypnos"},
  EH08 = {"Shudde Mell"},
  EH09 = {"Antediluvium", "Nyarlathotep"},
  EHX1 = {"Ghatanothoa", "Y-Golonac", "The King in Yellow", "The Mi-go"}
}

-- Functions

function onSave()
  return JSON.encode({started=gameStarted})
end

function onLoad(save_state)
  math.randomseed(os.time())
  if save_state ~= nil and JSON.decode(save_state) ~= nil then
    for k,v in pairs(JSON.decode(save_state)) do
      print(k,v)
    end
  end

  -- Enable all expansions by default
  for iext = 1, #extension_codes do
    selected_expansions[extension_codes[iext]] = "true"
  end

  options = getOptions()
  createButtons()
end

function setupCharacter(a,b)
  local card_offset = 0
  local decks = {bane_deck,assets_deck,talent_deck,boon_deck,spell_deck,u_assets_deck}
  for k,v in pairs(a.getVar('starters')) do
    for i=1,#decks do
      if type(searchForIn(v,decks[i],{rotation={0,180,0},position={a.getPosition().x+2+card_offset,a.getPosition().y+1,a.getPosition().z}})) == 'userdata' then break end
  a.removeButton(0)  end
    card_offset = card_offset + 1
  end
  local token = searchForIn(a.getName(),pawn_bag,{position={a.getPosition().x-2,a.getPosition().y+2,a.getPosition().z}})
  local hp = getObjectFromGUID(hp_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z+3}})
  local san = getObjectFromGUID(san_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z-3}})
  hp.Counter.setValue(a.getVar('hp'))
  san.Counter.setValue(a.getVar('san'))
  token.setColorTint(stringColorToRGB(b))
  local namepos = Player[b].getPlayerHand()
end


function setupCharacterF(a,b)
  local card_offset = 0
  local decks = {bane_deck,assets_deck,talent_deck,boon_deck,spell_deck,u_assets_deck}
  for k,v in pairs(a.getVar('starters')) do
    for i=1,#decks do
      if type(searchForIn(v,decks[i],{rotation={0,180,0},position={a.getPosition().x+2+card_offset,a.getPosition().y+1,a.getPosition().z}})) == 'userdata' then break end
  a.removeButton(0)  end
    card_offset = card_offset + 1
  end
  getObjectFromGUID(focus_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z}})
  local token = searchForIn(a.getName(),pawn_bag,{position={a.getPosition().x-2,a.getPosition().y+2,a.getPosition().z}})
  local hp = getObjectFromGUID(hp_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z+3}})
  local san = getObjectFromGUID(san_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z-3}})
  hp.Counter.setValue(a.getVar('hp'))
  san.Counter.setValue(a.getVar('san'))
  token.setColorTint(stringColorToRGB(b))
  local namepos = Player[b].getPlayerHand()
end

function setupCharacterW(a,b)
  local card_offset = 0
  local decks = {bane_deck,assets_deck,talent_deck,boon_deck,spell_deck,u_assets_deck}
  for k,v in pairs(a.getVar('starters')) do
    for i=1,#decks do
      if type(searchForIn(v,decks[i],{rotation={0,180,0},position={a.getPosition().x+2+card_offset,a.getPosition().y+1,a.getPosition().z}})) == 'userdata' then break end
  a.removeButton(0)  end
    card_offset = card_offset + 1
  end
  getObjectFromGUID(will_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z}})
  local token = searchForIn(a.getName(),pawn_bag,{position={a.getPosition().x-2,a.getPosition().y+2,a.getPosition().z}})
  local hp = getObjectFromGUID(hp_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z+3}})
  local san = getObjectFromGUID(san_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z-3}})
  hp.Counter.setValue(a.getVar('hp'))
  san.Counter.setValue(a.getVar('san'))
  token.setColorTint(stringColorToRGB(b))
  local namepos = Player[b].getPlayerHand()
end

function setupCharacterTC(a,b)
  local card_offset = 0
  local decks = {bane_deck,assets_deck,talent_deck,boon_deck,spell_deck,u_assets_deck}
  for k,v in pairs(a.getVar('starters')) do
    for i=1,#decks do
      if type(searchForIn(v,decks[i],{rotation={0,180,0},position={a.getPosition().x+2+card_offset,a.getPosition().y+1,a.getPosition().z}})) == 'userdata' then break end
  a.removeButton(0)  end
    card_offset = card_offset + 1
  end
  getObjectFromGUID(ticket_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z}})
  getObjectFromGUID(clue_bag).takeObject({position={a.getPosition().x,a.getPosition().y+3,a.getPosition().z}})
  local token = searchForIn(a.getName(),pawn_bag,{position={a.getPosition().x-2,a.getPosition().y+2,a.getPosition().z}})
  local hp = getObjectFromGUID(hp_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z+3}})
  local san = getObjectFromGUID(san_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z-3}})
  hp.Counter.setValue(a.getVar('hp'))
  san.Counter.setValue(a.getVar('san'))
  token.setColorTint(stringColorToRGB(b))
  local namepos = Player[b].getPlayerHand()
end

function setupCharacterRC(a,b)
  local card_offset = 0
  local decks = {bane_deck,assets_deck,talent_deck,boon_deck,spell_deck,u_assets_deck}
  for k,v in pairs(a.getVar('starters')) do
    for i=1,#decks do
      if type(searchForIn(v,decks[i],{rotation={0,180,0},position={a.getPosition().x+2+card_offset,a.getPosition().y+1,a.getPosition().z}})) == 'userdata' then break end
  a.removeButton(0)  end
    card_offset = card_offset + 1
  end
  getObjectFromGUID(resource_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z}})
  getObjectFromGUID(clue_bag).takeObject({position={a.getPosition().x,a.getPosition().y+3,a.getPosition().z}})
  local token = searchForIn(a.getName(),pawn_bag,{position={a.getPosition().x-2,a.getPosition().y+2,a.getPosition().z}})
  local hp = getObjectFromGUID(hp_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z+3}})
  local san = getObjectFromGUID(san_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z-3}})
  hp.Counter.setValue(a.getVar('hp'))
  san.Counter.setValue(a.getVar('san'))
  token.setColorTint(stringColorToRGB(b))
  local namepos = Player[b].getPlayerHand()
end

function setupCharacterC(a,b)
  local card_offset = 0
  local decks = {bane_deck,assets_deck,talent_deck,boon_deck,spell_deck,u_assets_deck}
  for k,v in pairs(a.getVar('starters')) do
    for i=1,#decks do
      if type(searchForIn(v,decks[i],{rotation={0,180,0},position={a.getPosition().x+2+card_offset,a.getPosition().y+1,a.getPosition().z}})) == 'userdata' then break end
  a.removeButton(0)  end
    card_offset = card_offset + 1
  end
  getObjectFromGUID(clue_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z}})
  local token = searchForIn(a.getName(),pawn_bag,{position={a.getPosition().x-2,a.getPosition().y+2,a.getPosition().z}})
  local hp = getObjectFromGUID(hp_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z+3}})
  local san = getObjectFromGUID(san_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z-3}})
  hp.Counter.setValue(a.getVar('hp'))
  san.Counter.setValue(a.getVar('san'))
  token.setColorTint(stringColorToRGB(b))
  local namepos = Player[b].getPlayerHand()
end

function setupCharacterT(a,b)
  local card_offset = 0
  local decks = {bane_deck,assets_deck,talent_deck,boon_deck,spell_deck,u_assets_deck}
  for k,v in pairs(a.getVar('starters')) do
    for i=1,#decks do
      if type(searchForIn(v,decks[i],{rotation={0,180,0},position={a.getPosition().x+2+card_offset,a.getPosition().y+1,a.getPosition().z}})) == 'userdata' then break end
  a.removeButton(0)  end
    card_offset = card_offset + 1
  end
  getObjectFromGUID(ticket_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z}})
  local token = searchForIn(a.getName(),pawn_bag,{position={a.getPosition().x-2,a.getPosition().y+2,a.getPosition().z}})
  local hp = getObjectFromGUID(hp_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z+3}})
  local san = getObjectFromGUID(san_bag).takeObject({position={a.getPosition().x,a.getPosition().y+2,a.getPosition().z-3}})
  hp.Counter.setValue(a.getVar('hp'))
  san.Counter.setValue(a.getVar('san'))
  token.setColorTint(stringColorToRGB(b))
  local namepos = Player[b].getPlayerHand()
end

function createButtons()
  local controller = getObjectFromGUID(setup_token)
  controller.createButton({click_function = 'startGame',
                          label = 'Setup',
                          font_size = 400,
                          position = {0,0.30,0},
                          width = 1000,
                          height = 550})
  assetButtons()
end

function assetButtons()
  local gameboard = getObjectFromGUID(game_board)
  gameboard.createButton({click_function = 'assets1',
                          label = 'Restock',
                          font_size = 300,
                          position = {-21.3,0.1,13},
                          width = 1500,
                          height = 500})
  gameboard.createButton({click_function = 'assets2',
                          label = 'Restock',
                          font_size = 300,
                          position = {-17.5,0.1,13},
                          width = 1500,
                          height = 500})
  gameboard.createButton({click_function = 'assets3',
                          label = 'Restock',
                          font_size = 300,
                          position = {-13.8,0.1,13},
                          width = 1500,
                          height = 500})
  gameboard.createButton({click_function = 'assets4',
                          label = 'Restock',
                          font_size = 300,
                          position = {-10,0.1,13},
                          width = 1500,
                          height = 500})
end

function assets1()
  local pos = getObjectFromGUID(game_board).getPosition()
  searchForIn('',assets_deck,{position={pos.x-21.5,1.5,pos.z-16}}).setRotation({0,180,0})
end

function assets2()
  local pos = getObjectFromGUID(game_board).getPosition()
  searchForIn('',assets_deck,{position={pos.x-17.6,1.5,pos.z-16}}).setRotation({0,180,0})
end

function assets3()
  local pos = getObjectFromGUID(game_board).getPosition()
  searchForIn('',assets_deck,{position={pos.x-13.8,1.5,pos.z-16}}).setRotation({0,180,0})
end

function assets4()
  local pos = getObjectFromGUID(game_board).getPosition()
  searchForIn('',assets_deck,{position={pos.x-10,1.5,pos.z-16}}).setRotation({0,180,0})
end

function startGame(a, b)
  setupToken = getObjectFromGUID("a2f924")
  current_pos = setupToken.getPosition()
  setupToken.setPositionSmooth({current_pos.x, current_pos.y + 500, current_pos.z + 100}, false, true)  --move the setup button 500 up and +z

  UI.show("SetupPanel")
  UI.setAttribute("SetupPanel", "active", "true")
  initSelectedExpansions()
  updatePreludeToggleState()
  updateAllAncientButtonsState()
end

function initSelectedExpansions()
  for i=1,#extension_codes do
      exp = extension_codes[i]
      if selected_expansions[exp] and selected_expansions[exp] == "true" then
        UI.setAttribute(exp, "isOn", "true")
      else
        UI.setAttribute(exp, "isOn", "false")
      end

      --selected_expansions[exp] = string.lower(UI.getAttribute(exp, "isOn"))
  end
end

function cancelSetup(a,b)
  UI.hide("SetupPanel")
  current_pos = setupToken.getPosition()
  setupToken.setPositionSmooth({current_pos.x, current_pos.y - 500, current_pos.z - 100}, false, true)  --move the setup button 500 down and -z
end

function hideSetupPanel(a, b)
  UI.hide("SetupPanel")
  UI.setAttribute("SetupPanel", "active", "false")
end

  --[[
  options = getOptions()
  if tonumber(options.prelude) == 1 then
    getPrelude()
  end
  randomAncient()
  gameStarted = true
end]]--

function randomOfficialAncient()
  local allAncients = { }
  for i=1, #extension_codes do
      exp = extension_codes[i]
      if selected_expansions[exp] == "true" then
        ancients = ancients_by_expansion[exp]
        for j = 1, #ancients do
            table.insert(allAncients, ancients[j])
        end
      end
  end

  setupAncient(allAncients[math.random(#allAncients)])
end

function randomFanAncient()
  local fanAncients = ancients_by_expansion["EHX1"];
  setupAncient(fanAncients[math.random(#fanAncients)])
end

function mysticRuins()
  local pos = getObjectFromGUID(game_board).getPosition()
  local bag = getObjectFromGUID(mystic_bag)
  bag.takeObject({position={25.41, 1.09, 24.44},rotation={180,0,0},callback_owner=Global})
  bag.takeObject({position={25.41, 2.09, 24.44},rotation={180,0,0},callback_owner=Global})
  bag.takeObject({position={pos.x+23.5,1.4,pos.z-25.5},rotation={0,90,0},callback_owner=Global})
  bag.takeObject({position={pos.x+23.5,1.2,pos.z-25.5},rotation={0,90,0},callback_owner=Global})
end

function nyarla()
  local pos = getObjectFromGUID(game_board).getPosition()
  local bag = getObjectFromGUID(nyarla_bag)
  bag.takeObject({position={60.59, 0.96, 8.46},rotation={180,0,0},callback_owner=Global})
  bag.takeObject({position={67.05, 0.96, 8.46},rotation={180,0,0},callback_owner=Global})
  bag.takeObject({position={60.59, 0.96, 4.34},rotation={180,0,0},callback_owner=Global})
  bag.takeObject({position={67.05, 0.96, 4.34},rotation={180,0,0},callback_owner=Global})
  bag.takeObject({position={63.91, 0.87, 1.11},rotation={180,0,0},callback_owner=Global})
end

function eldritch()
  local pos = getObjectFromGUID(game_board).getPosition()
  local bag = getObjectFromGUID(eldritch_bag)
  bag.takeObject({position={-5.11, 1.10, 20.71},rotation={180,0,0},callback_owner=Global})
  bag.takeObject({position={1.81, 1.10, 20.71},rotation={180,0,0},callback_owner=Global})
  bag.takeObject({position={8.73, 1.10, 20.72},rotation={180,0,0},callback_owner=Global})
  bag.takeObject({position={15.68, 1.10, 20.72},rotation={180,0,0},callback_owner=Global})
end

function disaster()
  local pos = getObjectFromGUID(game_board).getPosition()
  local bag = getObjectFromGUID(disaster_bag)
  bag.takeObject({position={16.41, 1.18, 24.36},rotation={180,0,0},callback_owner=Global})
  bag.takeObject({position={22.41, 1.11, 24.44},rotation={180,0,0},callback_owner=Global})
  bag.takeObject({position={22.41, 2.11, 24.44},rotation={180,0,0},callback_owner=Global})
end

function egyptSide()
  local pos = getObjectFromGUID(game_board).getPosition()
  local bag = getObjectFromGUID(pyramid_bag)
  bag.takeObject({position={pos.x,1.01,pos.z-25.5},rotation={0,180,0},callback='callbackLock',callback_owner=Global}).interactable = true
  local tokens = searchForIn('Tokens',bag,{position={50,1,0}})
  searchForIn('Egypt',bag,{position={pos.x+13.5,1,pos.z-21},rotation={180,0,0}})
  searchForIn('Africa',bag,{position={pos.x+13.5,1,pos.z-26.5},rotation={180,0,0}})
  searchForIn('Adventure',bag,{position={pos.x+21,1,pos.z-21},rotation={180,270,0}})
  egyptMonsters()
  tokens.takeObject({position={pos.x+21,3,pos.z-21}})
  local gatepos = getObjectFromGUID('96en34').getPosition()
  local cluepos = getObjectFromGUID('652d1t').getPosition()
  for i=1,3 do
    tokens.takeObject({position={gatepos.x,5,gatepos.z},rotation={0,180,0}})
  end
  for i=1,6 do
    tokens.takeObject({position={cluepos.x,5,cluepos.z}})
  end
end

function DreamSide()
  local pos = getObjectFromGUID(game_board).getPosition()
  local bag = getObjectFromGUID(dream_bag)
  bag.takeObject({position={pos.x,1.01,pos.z-30.9},rotation={0,270,0},callback='callbackLock',callback_owner=Global}).interactable = true
  local tokens = searchForIn('Tokens',bag,{position={50,1,0}})
  searchForIn('Dream Quest',bag,{position={pos.x+10.6,1,pos.z-21},rotation={180,0,0}})
  searchForIn('Dreamlands',bag,{position={pos.x+10.6,1,pos.z-26.5},rotation={180,0,0}})
  searchForIn('Otherworldly Dreams',bag,{position={pos.x+25,1,pos.z-21},rotation={180,270,0}})
  dreamMonsters()
  tokens.takeObject({position={pos.x+10.6,2,pos.z-21}})
  tokens.takeObject({position={pos.x+25,2,pos.z-21}})
  tokens.takeObject({position={pos.x+17,1,pos.z-27},rotation={0,180,0}})
  tokens.takeObject({position={pos.x+25,1,pos.z-27},rotation={0,180,0}})
  tokens.takeObject({position={pos.x+33,1,pos.z-27},rotation={0,180,0}})
  local gatepos = getObjectFromGUID('96en34').getPosition()
  local cluepos = getObjectFromGUID('652d1t').getPosition()
  for i=1,3 do
    tokens.takeObject({position={gatepos.x,5,gatepos.z},rotation={0,180,0}})
  end
  for i=1,7 do
    tokens.takeObject({position={cluepos.x,5,cluepos.z},rotation={0,0,0}})
  end
end

function DreamSide2()
  local pos = getObjectFromGUID(game_board).getPosition()
  local bag = getObjectFromGUID(dream_bag)
  bag.takeObject({position={pos.x,1.01,pos.z-30.9},rotation={0,270,0},callback='callbackLock',callback_owner=Global}).interactable = true
  local tokens = searchForIn('Tokens',bag,{position={50,1,0}})
  searchForIn('Dream Quest',bag,{position={pos.x+10.6,1,pos.z-21},rotation={180,0,0}})
  searchForIn('Dreamlands',bag,{position={pos.x+10.6,1,pos.z-26.5},rotation={180,0,0}})
  searchForIn('Otherworldly Dreams',bag,{position={pos.x+25,1,pos.z-21},rotation={180,270,0}})
  tokens.takeObject({position={pos.x+10.6,2,pos.z-21}})
  tokens.takeObject({position={pos.x+25,2,pos.z-21}})
  tokens.takeObject({position={pos.x+17,1,pos.z-27},rotation={0,180,0}})
  tokens.takeObject({position={pos.x+25,1,pos.z-27},rotation={0,180,0}})
  tokens.takeObject({position={pos.x+33,1,pos.z-27},rotation={0,180,0}})
  local gatepos = getObjectFromGUID('96en34').getPosition()
  local cluepos = getObjectFromGUID('652d1t').getPosition()
  for i=1,3 do
    tokens.takeObject({position={gatepos.x,5,gatepos.z},rotation={0,180,0}})
  end
  for i=1,7 do
    tokens.takeObject({position={cluepos.x,5,cluepos.z},rotation={0,0,0}})
  end
end

function dreamMonsters()
  table.insert(ancient.monsters, 'Zoog')
  table.insert(ancient.monsters, 1)
  table.insert(ancient.monsters, 'Ghoul')
  table.insert(ancient.monsters, 1)
  table.insert(ancient.monsters, 'Moon-Beast')
  table.insert(ancient.monsters, 1)
  table.insert(ancient.monsters, 'Nightgaunt')
  table.insert(ancient.monsters, 1)
  setAsideMonsters()
 end

function egyptMonsters()
  table.insert(ancient.monsters, 'Sand Dweller')
  table.insert(ancient.monsters, 1)
  table.insert(ancient.monsters, 'Mummy')
  table.insert(ancient.monsters, 1)
  table.insert(ancient.monsters, 'Spawn of Sebak')
  table.insert(ancient.monsters, 1)
  setAsideMonsters()
end

function antSide()
  local pos = getObjectFromGUID(game_board).getPosition()
  local bag = getObjectFromGUID(ant_bag)
  bag.takeObject({position={pos.x,1.01,pos.z-25.5},rotation={0,180,0},callback='callbackLock',callback_owner=Global}).interactable = true
  local tokens = searchForIn('Tokens',bag,{position={50,1,0}})
  searchForIn('Dream Quest',bag,{position={pos.x+13.5,1,pos.z-21},rotation={180,0,0}})
  searchForIn('Mountains',bag,{position={13.34, 1.15, -21.34},rotation={180,0,0}})
  searchForIn('Outpost',bag,{position={13.29, 1.07, -16.43},rotation={180,0,0}})
  searchForIn('Adventure',bag,{position={pos.x+21,1,pos.z-21},rotation={180,270,0}})
  searchForIn('Research',bag,{position={13.36, 1.15, -26.22},rotation={180,0,0}})
  antMonsters()
  tokens.takeObject({position={pos.x+21,3,pos.z-21}})
  local gatepos = getObjectFromGUID('96en34').getPosition()
  local cluepos = getObjectFromGUID('652d1t').getPosition()
  for i=1,3 do
    tokens.takeObject({position={gatepos.x,5,gatepos.z},rotation={0,180,0}})
  end
  for i=1,6 do
    tokens.takeObject({position={cluepos.x,5,cluepos.z}})
  end
end

function antMonsters()
  table.insert(ancient.monsters, 'Elder Thing')
  table.insert(ancient.monsters, 1)
  table.insert(ancient.monsters, 'Giant Penguin')
  table.insert(ancient.monsters, 1)
  table.insert(ancient.monsters, 'Shoggoth')
  table.insert(ancient.monsters, 1)
  table.insert(ancient.monsters, 'Shoggoth')
  table.insert(ancient.monsters, 1)
  setAsideMonsters()
end

ancient = {}
ancient.mythos = {}
ancient.mythos.stage1 = {}
ancient.mythos.stage2 = {}
ancient.mythos.stage3 = {}
ancient.monsters = {}
ancient.expansion = ""

function setupAncient(name)
  if name == 'Hastur' then
    ancient.mythos.stage1.green = 0
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 2
    ancient.mythos.stage2.green = 2
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 0
    ancient.mythos.stage3.green = 3
    ancient.mythos.stage3.yellow = 5
    ancient.mythos.stage3.blue = 0
    ancient.monsters = {'Byakhee', 1}
    ancient.doom = 11
elseif name == 'Nyarlathotep' then
    ancient.mythos.stage1.green = 1
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 2
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 1
    ancient.mythos.stage3.green = 2
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.doom = 12
    nyarla()
elseif name == 'Antediluvium' then
    ancient.mythos.stage1.green = 1
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 2
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 1
    ancient.mythos.stage3.green = 2
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.monsters = {'Cultist', 5, 'Deep One', 1}
    ancient.doom = 13
    mysticRuins()
    local pos = getObjectFromGUID(game_board).getPosition()
    getObjectFromGUID(et_bag).takeObject({position={22.88, 1.10, 18.59}})
    local pos = getObjectFromGUID(game_board).getPosition()
    getObjectFromGUID(et_bag).takeObject({position={25.93, 1.10, 19.41}})
  elseif name == 'The Mi-go' then
    ancient.mythos.stage1.green = 2
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 3
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 0
    ancient.mythos.stage3.green = 2
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.monsters = {'Cultist', 6, 'Mi-go', 1}
    ancient.doom = 12
  elseif name == 'The King in Yellow' then
    ancient.mythos.stage1.green = 0
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 2
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 1
    ancient.mythos.stage3.green = 3
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.monsters = {'Cultist', 5, 'Riot', 1, 'Witch', 1, 'Warlock', 1}
    ancient.doom = 14
elseif name == 'Shudde Mell' then
    ancient.mythos.stage1.green = 0
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 2
    ancient.mythos.stage2.green = 4
    ancient.mythos.stage2.yellow = 2
    ancient.mythos.stage2.blue = 0
    ancient.mythos.stage3.green = 2
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.doom = 15
    disaster()
    eldritch()
  elseif name == 'Ghatanothoa' then
    ancient.mythos.stage1.green = 1
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 2
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 0
    ancient.mythos.stage3.green = 3
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 1
    ancient.monsters = {'Mummy', 1, 'Mi-go', 1, 'Lloigor', 1}
    ancient.doom = 13
  elseif name == 'Y-Golonac' then
    ancient.mythos.stage1.green = 1
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 3
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 1
    ancient.mythos.stage3.green = 2
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.monsters = {'Maniac', 1, 'Ghoul', 2,}
    ancient.doom = 13
  elseif name == 'Hypnos' then
    ancient.mythos.stage1.green = 0
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 2
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 1
    ancient.mythos.stage3.green = 3
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.monsters = {'Zoog', 1, 'Ghoul', 1, 'Moon-Beast', 1, 'Nightgaunt', 1}
    ancient.doom = 12
    DreamSide2()
  elseif name == 'Atlach-Nacha' then
    ancient.mythos.stage1.green = 1
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 3
    ancient.mythos.stage2.yellow = 2
    ancient.mythos.stage2.blue = 1
    ancient.mythos.stage3.green = 2
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.monsters = {'Leng Spider', 1}
    ancient.doom = 9
  elseif name == 'Yog-Sothoth' then
    ancient.mythos.stage1.green = 0
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 2
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 1
    ancient.mythos.stage3.green = 3
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.doom = 14
  elseif name == 'ElderThings' then
    ancient.mythos.stage1.green = 2
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 3
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 1
    ancient.mythos.stage3.green = 4
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.doom = 16
    antSide()
  elseif name == 'Azathoth' then
    ancient.mythos.stage1.green = 1
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 2
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 1
    ancient.mythos.stage3.green = 2
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.doom = 15
    local pos = getObjectFromGUID(game_board).getPosition()
    getObjectFromGUID(et_bag).takeObject({position={24.00, 1.10, 20.49}})
  elseif name == 'Syzygy' then
    ancient.mythos.stage1.green = 0
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 2
    ancient.mythos.stage2.green = 3
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 0
    ancient.mythos.stage3.green = 3
    ancient.mythos.stage3.yellow = 5
    ancient.mythos.stage3.blue = 0
    ancient.doom = 13
    mysticRuins()
  elseif name == 'Ithaqua' then
    ancient.mythos.stage1.green = 0
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 2
    ancient.mythos.stage2.green = 4
    ancient.mythos.stage2.yellow = 2
    ancient.mythos.stage2.blue = 0
    ancient.mythos.stage3.green = 2
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.monsters = {'Gnoph-Keh', 1, 'Wendigo', 1}
    ancient.doom = 13
  elseif name == 'Shub-Niggurath' then
    ancient.mythos.stage1.green = 1
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 3
    ancient.mythos.stage2.yellow = 2
    ancient.mythos.stage2.blue = 1
    ancient.mythos.stage3.green = 2
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.monsters = {'Goat Spawn', 2, 'Ghoul', 2 , 'Dark Young', 1}
    ancient.doom = 13
  elseif name == 'Yig' then
    ancient.mythos.stage1.green = 1
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 2
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 1
    ancient.mythos.stage3.green = 2
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.monsters = {'Cultist', 6, 'Serpent People', 1}
    ancient.doom = 10
  elseif name == 'Abhoth' then
    ancient.mythos.stage1.green = 1
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 1
    ancient.mythos.stage2.green = 3
    ancient.mythos.stage2.yellow = 2
    ancient.mythos.stage2.blue = 1
    ancient.mythos.stage3.green = 2
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.monsters = {'Cultist', 8}
    ancient.doom = 14
  elseif name == 'Nephren-Ka' then
    ancient.mythos.stage1.green = 0
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 2
    ancient.mythos.stage2.green = 1
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 0
    ancient.mythos.stage3.green = 3
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.doom = 12
    egyptSide()
  elseif name == 'Cthulhu' then
    ancient.mythos.stage1.green = 0
    ancient.mythos.stage1.yellow = 2
    ancient.mythos.stage1.blue = 2
    ancient.mythos.stage2.green = 1
    ancient.mythos.stage2.yellow = 3
    ancient.mythos.stage2.blue = 0
    ancient.mythos.stage3.green = 3
    ancient.mythos.stage3.yellow = 4
    ancient.mythos.stage3.blue = 0
    ancient.monsters = {'Deep One', 1, 'Star Spawn', 1}
    ancient.doom = 12
  end
  setupAncient2(searchForIn(name,ancients_bag,{position={50,5,20}}))
  filterExpansions()

  -- Prelude setup needs to happen before mythos deck setup
  -- certain preludes require cards from mythos deck
  if shouldGetPrelude == "True" then
    getPrelude()
  end

  setupMythosDeck()
  if not moreset then
    setAsideMonsters()
  end

  hideSetupPanel()
end

function filterExpansions()
  discardbag = getObjectFromGUID(discard_bag)

  function filterSingleFilter(ext)
      matchGmFn = function(v) return string.find(string.lower(v.gm_notes),string.lower(ext)) end
      local callbackFn = function(obj) discardbag.putObject(obj) end
      local discard_offset = 1

      -- skip deck filtering for user expansion
      if ext ~= "EHX1" then
        for k,v in pairs(decks) do
            -- spawn a separate thread/coroutine for each deck in order to speed things up
            local co = coroutine.create(
                function(cparams)
                    local deckGuid = cparams.deck
                    local ext = cparams.ext
                    local offset = cparams.offset

                    local deck = getObjectFromGUID(deckGuid)
                    local lpos = discardbag.getPosition()
                    lpos.y = lpos.y + 4 + offset
                    local callbackFn = function(obj) discardbag.putObject(obj) end
                    local res = takeFromCollection(deck, matchGmFn, lpos, callbackFn)
                end)
            hr = coroutine.resume(co, { deck = v, ext = ext, offset = discard_offset })
            if not hr then
              print("Failed to start coroutine for deck: " .. k)
            end

            discard_offset = discard_offset+1
        end
      end

      local lpos = discardbag.getPosition()
      lpos.y = lpos.y + 4 + discard_offset
      monsterbag = getObjectFromGUID(monster_bag)
      takeFromCollection(monsterbag, matchGmFn, lpos, callbackFn)

      lpos.y = lpos.y + 1
      epicmonsterbag = getObjectFromGUID(epic_monster_bag)
      takeFromCollection(epicmonsterbag, matchGmFn, lpos, callbackFn)

      lpos.y = lpos.y + 4
      gatesbag = getObjectFromGUID(gates_bag)
      takeFromCollection(gatesbag, matchGmFn, lpos, callbackFn)
  end

  local filterStr = getExpansionFilter()
  if filterStr then
      filterSingleFilter(filterStr)
  end

  if not isUserExpansionsEnabled() then
    filterSingleFilter("EHX1")
  end

end

function getExpansionFilter()
  local filterStr = "EH0["
  local needFilter = false
  for i=1,#extension_codes do
    local ext = extension_codes[i]
    if selected_expansions[ext] == "false" then
        needFilter = true
        filterStr = filterStr .. i
    end
  end
  filterStr = filterStr .. "]"

  if needFilter then
    return filterStr
  else
    return nil
  end
end

function isUserExpansionsEnabled()
  local enable = true
  -- enable user extensions only if all base game extensions are enabled

  for i=1,#extension_codes do
    local ext = extension_codes[i]
    if selected_expansions[ext] == "false" then
      enable = false
      break
    end
  end

  return enable
end

function isExpansionEnabled(exp)
  if exp == "EHX1" then
    return isUserExpansionsEnabled()
  else
    return selected_expansions[exp] == "true"
  end
end

function isPreludeExist()
    local expansions_with_prelude = {"EH03", "EH04", "EH05", "EH06", "EH07", "EH08", "EH09"}
    for i=1,#expansions_with_prelude do
      if selected_expansions[expansions_with_prelude[i]] == "true" then
        return true
      end
    end

    return false
end

function getPrelude()
  local prelude = searchForIn('',prelude_deck,{callback_owner=Global,position={0,2,0},rotation={180,0,180}})
  if prelude.getGUID() == '95wn6m' then
    moreset = true
    antMonsters()
  elseif prelude.getGUID() == 'qxkqjd' then
    moreset = true
    egyptMonsters()
  end
end

function setScale(a)
  -- 666 lol
  a.setScale({6,6,6})
  a.lock()
end

function getPlayerCount()
  local pos = getObjectFromGUID(game_board).getPosition()
  local num_players = #getSeatedPlayers()
  local player_num_ref = getObjectFromGUID('d8b7a4')
  local player_guid = {'4576dr', '7ojp91', 's2rwq2', 'olbcuq', 't117wb', '36tlad', 'ky9tj2', 'hutw2i'}
  player_num_ref.takeObject({position={pos.x+34,1,pos.z+25},rotation={0,180,0},guid=player_guid[num_players]})
end

function callbackLock(a)
  a.unlock()
end

function setupAncient2(bag)
  local doom_tracker = getObjectFromGUID(doom_track)
  local pos = getObjectFromGUID(game_board).getPosition()
  doom_tracker.setPosition({pos.x+20.2-(2.31*ancient.doom),1.3,pos.z+16.67})

  function filterMyteryDeck(obj)
    filterStr = getExpansionFilter()
    if filterStr then
        discardbag = getObjectFromGUID(discard_bag)
        callbackFn = function(obj) discardbag.putObject(obj) end
        position = discardbag.getPosition()
        position["y"] = position["y"] + 10
        matchGmFn = function(v) return string.find(string.lower(v.gm_notes),string.lower(filterStr)) end
        takeFromCollection(obj, matchGmFn, position, callbackFn)
    end
  end

  bag.takeObject({position={pos.x+34,1,pos.z+10},rotation={0,180,0},callback='callbackLock',callback_owner=Global})
  searchForIn('Research',bag,{position={10.41, 1.11, 24.44},rotation={180,0,0}})
  searchForIn('Mystery',bag,{position={pos.x+63.8,1,pos.z+13.5},rotation={180,270,0}}, filterMyteryDeck)
  searchForIn('',bag,{position={pos.x+42,1,9},rotation={180,0,0}})
  searchForIn('',bag,{position={pos.x+42,1,14},rotation={180,0,0}})
  searchForIn('',bag,{position={pos.x+42,1,19},rotation={180,0,0}})
  searchForIn('',bag,{position={pos.x+42,1,24},rotation={180,0,0}})

  getPlayerCount()
end

z_offset = 0
function setAsideMonsters()
  for i=1,#ancient.monsters,2 do
    for j=1,ancient.monsters[i+1] do
      searchForIn(ancient.monsters[i],monster_bag,{position={46,1.5+1*(j-1),20-z_offset},rotation={180,0,0}})
    end
    z_offset = z_offset + 2
  end
end

function setupMythosDeck()
  local pos = getObjectFromGUID(game_board).getPosition()
  -- local diff = {split(options.difficulty,',')}

  local diff = {}
  local currentTableIndex = 1
  if shouldIncludeEasyMythos == "True" then
    -- broadcastToAll("Easy mythos included")
    diff[currentTableIndex] = 1
    currentTableIndex = currentTableIndex + 1
  end
  if shouldIncludeMediumMythos == "True" then
    -- broadcastToAll("Medium mythos included")
    diff[currentTableIndex] = 2
    currentTableIndex = currentTableIndex + 1
  end
  if shouldIncludeHardMythos == "True" then
    -- broadcastToAll("Hard mythos included")
    diff[currentTableIndex] = 3
  end

-- for i=1,#diff do
--   print(diff[i])
-- end

  local hgm = 'qszvkn'
  local mgm = 'vxiwyn'
  local egm = 'uc2b43'
  local hym = '8c13f8'
  local mym = 'n621fe'
  local eym = 'cr05o1'
  local hbm = 'k39546'
  local mbm = '6g97ke'
  local ebm = '0c9452'
  local blue = {ebm, mbm, hbm}
  local green = {egm, mgm, hgm}
  local yellow = {eym, mym, hym}
  local stage_offset = 0
  for k,v in pairs(ancient.mythos) do
    for i,j in pairs(v) do
      if i == 'blue' then
        for a=1,j do
          local randomNum = tonumber(diff[math.random(#diff)])
          searchForIn('',blue[randomNum],{position={pos.x+29.5+stage_offset,1.5,3},rotation={180,0,0}})
        end
      elseif i == 'green' then
        for a=1,j do
          local randomNum = tonumber(diff[math.random(#diff)])
          searchForIn('',green[randomNum],{position={pos.x+29.5+stage_offset,1.5,3},rotation={180,0,0}})
        end
      elseif i == 'yellow' then
        for a=1,j do
          local randomNum = tonumber(diff[math.random(#diff)])
          searchForIn('',yellow[randomNum],{position={pos.x+29.5+stage_offset,1.5,3},rotation={180,0,0}})
        end
      end
    end
    stage_offset = stage_offset + 3.5
  end
end

function searchForIn(object, containerguid, params2, callbackFn)
  params2.guid = '000000'
  params2.callback_function = callbackFn
  local deckorbag
  local guids = {}
  if type(containerguid) == 'string' then
    deckorbag = getObjectFromGUID(containerguid)
  else
    deckorbag = containerguid
  end
  local obj = nil
  for k,v in pairs(deckorbag.getObjects()) do
    if string.find(string.lower(v.name==nil and v.nickname==nil and '' or v.name or v.nickname), string.lower(string.gsub(object,'-','%%-'))) then
      table.insert(guids, v.guid)
    end
  end
  if #guids > 0 then
    params2.guid = guids[math.random(#guids)]
    return deckorbag.takeObject(params2)
  else
    return false
  end
end

function takeFromCollection(collection, matchFn, matchPosition, callbackFn)
    if collection ~= nil and collection.getObjects() ~= nil then
        matchObj = nil
        matchesAll = true

        for k,v in pairs(collection.getObjects()) do
            if not( matchFn(v) ) then
                matchesAll = false
                break
            end
        end

        if matchesAll then
            -- Take whole deck
            collection.setPosition(matchPosition)
            matchObj = collection
            callbackFn(matchObj)
        else
            -- Take only matches out of the deck, and form new deck
            params = {top=false, position = matchPosition}

            for k,v in pairs(collection.getObjects()) do
                if ( matchFn(v) ) then
                    params.guid = v.guid
                    params.callback_function = callbackFn
                    newObj = collection.takeObject(params)
                end
            end
        end

        return matchObj
    else
        return nil
    end
end

function split(input, split)
  local returnarr = {}
  local i = 1
  for str in string.gmatch(input, '([^' .. split .. ']+)') do
    returnarr[i] = str
    i = i + 1
  end
  return returnarr
end

function getRulesText()
  for k,v in pairs(getNotebookTabs()) do
    if v.color == 'White' then
      return v.body
    end
  end
end

function getOptions()
  local returnarr = {}
  local lines = split(getRulesText(),'\n')
  for k,v in pairs(lines) do
    local optparam = split(v,'=')
    returnarr[optparam[1]] = optparam[2]
  end
  return returnarr
end


-- Specific Ancient One SetupPanel
function setupAbhoth()  setupAncient("Abhoth") end
function setupAntediluvium()  setupAncient("Antediluvium") end
function setupAtlachNacha()  setupAncient("Atlach-Nacha") end
function setupAzathoth()  setupAncient("Azathoth") end
function setupCthulhu()  setupAncient("Cthulhu") end
function setupElderThings()  setupAncient("ElderThings") end
function setupHastur()  setupAncient("Hastur") end
function setupHypnos()  setupAncient("Hypnos") end
function setupIthaqua()  setupAncient("Ithaqua") end
function setupNephrenKa()  setupAncient("Nephren-Ka") end
function setupNyarlathotep()  setupAncient("Nyarlathotep") end
function setupShubNiggurath()  setupAncient("Shub-Niggurath") end
function setupShuddeMell()  setupAncient("Shudde Mell") end
function setupSyzygy()  setupAncient("Syzygy") end
function setupYig()  setupAncient("Yig") end
function setupYogSothoth()  setupAncient("Yog-Sothoth") end
function setupGhatanothoa()  setupAncient("Ghatanothoa") end
function setupTheKingInYellow()  setupAncient("The King in Yellow") end
function setupTheMigo()  setupAncient("The Mi-go") end
function setupYGolonac()  setupAncient("Y-Golonac") end

function updatePreludeToggleState()
    if isPreludeExist() then
        UI.setAttribute("preludeToggle", "interactable", "true")
        UI.show("preludeToggle")
    else
        UI.setAttribute("preludeToggle", "isOn", "false")
        UI.setAttribute("preludeToggle", "interactable", "false")
    end
end

function updateAllAncientButtonsState()
  for i = 1, #extension_codes do
    updateAncientButtonState(extension_codes[i])
  end
end

function updateAncientButtonState(exp)
    local ancients = ancients_by_expansion[exp]
    local buttonInteractableVal = selected_expansions[exp]
    local opacityVal = "100"
    if buttonInteractableVal == "true" then
      opacityVal = "0"
    end

    for i=1,#ancients do
        local buttonName = ancients[i] .. "SetupButton"
        UI.setAttribute(buttonName, "interactable", buttonInteractableVal)
        UI.setAttribute(buttonName, "opacity", opacityVal)
    end

    -- update fan created ancients
    if isUserExpansionsEnabled() then
      buttonInteractableVal = "true"
      opacityVal = "0"
    else
      buttonInteractableVal = "false"
      opacityVal = "100"
    end
    ancients = ancients_by_expansion["EHX1"]
    for i=1,#ancients do
        buttonName = ancients[i] .. "SetupButton"
        UI.setAttribute(buttonName, "interactable", buttonInteractableVal)
        UI.setAttribute(buttonName, "opacity", opacityVal)
    end
    UI.setAttribute("RandomFanAncientOneSetupButton", "interactable", buttonInteractableVal)
    UI.setAttribute("RandomFanAncientOneSetupButton", "opacity", opacityVal)
end

function expansionValueChanged(player, value, id)
    selected_expansions[id] = string.lower(value)
    updatePreludeToggleState()
    updateAncientButtonState(id)
end

function preludeToggleValueChanged(sender, value)
  shouldGetPrelude = value
end

function easyMythosToggleValueChanged(sender, value)
shouldIncludeEasyMythos = value
makeSureAtLeastMediumMythosIsSelected()
end

function mediumMythosToggleValueChanged(sender, value)
shouldIncludeMediumMythos = value
makeSureAtLeastMediumMythosIsSelected()
end

function hardMythosToggleValueChanged(sender, value)
shouldIncludeHardMythos = value
makeSureAtLeastMediumMythosIsSelected()
end

function makeSureAtLeastMediumMythosIsSelected()
  if shouldIncludeEasyMythos == "False"
  and shouldIncludeMediumMythos == "False"
  and shouldIncludeHardMythos == "False"
  then
    UI.setAttribute("mediumMythosToggle", "isOn", "True")
  end
end