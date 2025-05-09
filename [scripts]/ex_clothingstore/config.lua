Config  = {}



Config.type = "QBCORE"  ---- ESX or QBCORE

Config.skinstyle = "qb-clothing"   ---- qb-clothing, esx_skin, ownsystem(json) , custom  (for save)

Config.Wardrobe = true  ------------------- use wardrobe true,false

Config.usedemowardrobecommand = false  ------- TriggerEvent('ex_clothingstore:wardrobe')

Config.forinventorys = false  ---- if this ture working  Forlikeinventorys() function in config

Forlikeinventorys = function(skin)

    print(json.encode(skin))   ---------------- Example coming data =  {"pants_1": 0 , "torso_1": 0}

end


Customedit = function(skin)
  print(json.encode(skin)) ---------------- Example coming data =  {"pants_1": 0 , "torso_1": 0}
end

Config.StoreList = {
    ----------------------- STORE 1----------------------------------------------------------------------------------------------------
    {
        ['storename'] = "Premium", 
        ['storedrawtext'] = "Clothing Store [E]",
        ['storecoords'] = {["x"]= 428.90,["y"] = -800.18, ["z"] = 28.50,["h"] = 96}, 
        ['storeblips'] = {['blipshow'] = true, ['blipsprite'] = 73, ['blipcolor'] = 1, ['blipscale'] = 0.7}, 
        ['storemarkers'] = {['markertype'] = 27,['markersize']= 0.7, ['markercolor'] = {['r'] = 255, ['g'] = 0 , ['b'] = 0}},
        ['storecategorysettings'] = {
            ["Jackets"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255, 55},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" },
                        ["1"] = { ['itemname'] = "Hello Guys", ['itemprice'] = 300, ['itemimage'] = "https://www.pngall.com/wp-content/uploads/4/Leather-Jacket-PNG-Pic.png" },
                        ["2"] = { ['itemname'] = "Hello Guys", ['itemprice'] = 500, ['itemimage'] = "categoryicons/deneme.png" }


                        
                    
                    
                    },  

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    }
                    
                }
            },
            ["Tshirt"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255, 2},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme2.png" }
                    },

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme2.png" }
                    }
                    
                }
            },
            ["Pants"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme3.png" }
                    },

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme3.png" }
                    }
                    
                }
            },
            ["Shoes"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme4.png" }
                    },

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme4.png" }
                    }
                    
                }
            },
            ["Arms"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/arms.png" }
                    },

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/arms.png" }
                    }
                    
                }
            },
            ["Mask"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    },

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    }
                    
                }
            },
            ["Glasses"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    },

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    }
                    
                }
            },
            ["Earrings"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    },

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    }
                    
                }
            },
            ["Vest"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    },

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    }
                    
                }
            },
            ["Helmet"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    },

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    }
                    
                }
            },
            ["Chain"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    },

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    }
                    
                }
            },
            ["Bag"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    },

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    }
                    
                }
            },
            ["Watch"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    },

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    }
                    
                }
            },
            ["Bracelets"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    },

                    ["female"] = {
                        ["21"] = { ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                    }
                    
                }
            }
        }
    },
   ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    ----------------------- STORE 2----------------------------------------------------------------------------------------------------
    {
        ['storename'] = "Premium", 
        ['storedrawtext'] = "Clothing Store [E]",
        ['storecoords'] = {["x"]= -712.215881,["y"] = -155.352982, ["z"] = 36.4151268,["h"] = 96}, 
        ['storeblips'] = {['blipshow'] = true, ['blipsprite'] = 73, ['blipcolor'] = 1, ['blipscale'] = 0.7}, 
        ['storemarkers'] = {['markertype'] = 27,['markersize']= 0.7, ['markercolor'] = {['r'] = 255, ['g'] = 0 , ['b'] = 0}},
        ['storecategorysettings'] = {
            ["Jackets"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png" }
                     

                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300 , ['itemimage'] = "categoryicons/torso.svg"}
                    }
                    
                }
            },
            ["Tshirt"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme2.png"}
                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme2.png"}
                    }
                    
                }
            },
            ["Pants"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme3.png"}
                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300 , ['itemimage'] = "categoryicons/deneme3.png"}
                    }
                    
                }
            },
            ["Shoes"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme4.png" }
                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme4.png"}
                    }
                    
                }
            },
            ["Arms"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/arms.svg"}
                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300}, ['itemimage'] = "categoryicons/arms.svg"
                    }
                    
                }
            },
            ["Mask"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    }
                    
                }
            },
            ["Glasses"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    }
                    
                }
            },
            ["Earrings"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    }
                    
                }
            },
            ["Vest"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    }
                    
                }
            },
            ["Helmet"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    }
                    
                }
            },
            ["Chain"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    }
                    
                }
            },
            ["Bag"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    }
                    
                }
            },
            ["Watch"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    }
                    
                }
            },
            ["Bracelets"] = {
                ['state'] = true, 
                ['factor'] = 1.0,
                ['blacklist'] = {224,255},
                ['changeset'] = {
                    ["male"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    },

                    ["female"] = {
                        {['itemid'] = 20, ['itemname'] = "New Name", ['itemprice'] = 300, ['itemimage'] = "categoryicons/deneme.png"}
                    }
                    
                }
            }
        }
    }

   ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

}