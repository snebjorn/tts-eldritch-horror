self.createButton({click_function='draw',
                  function_owner=self,
                  label='Find',
                  position={0,0.5,0},
                  width=300,
                  height=150})

deck_object = nil

function onCollisionEnter(collision_info)
  if collision_info.collision_object.getQuantity() > 1 then
    deck_object = collision_info.collision_object
  end
end

function onCollisionExit(collision_info)
  if collision_info.collision_object.getQuantity() > 1 then
    deck_object = nil
  end
end

function draw()
  local params = {top=false,position={self.getPosition().x,self.getPosition().y+1,self.getPosition().z}}
  if self.getName() ~= '' then
    for k,v in pairs(deck_object.getObjects()) do
      if (string.find(string.lower(v.nickname),string.lower(self.getName()))) then
        params.guid = v.guid
        break
      end
    end
  end
  deck_object.takeObject(params)
end