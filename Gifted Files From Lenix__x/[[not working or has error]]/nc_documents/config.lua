Config = {}

Config.Debug = true

Config.Language = "en"

Config.DisplayRadius = 3.0

Config.Photos = {
    UploadURL = "https://discord.com/api/webhooks/1236538042152517692/cYqhegVm6EO9dU7ClrKIuaRskFyuqz8Q7bqc5UcwfEMo3qB-sRVNA7dUfPu8kVlYI7sa", -- REQUIRED: By default, uses discord to host images. Use a discord hook link inside the quotes.
    UploadProtocol = 'files[]',
    ResponseHandler = function(resp) -- Return URL from response.
       return resp.attachments[1].url
    end,
    Brightness = 1.0,
    CameraDistance = 0.5,
    Coords = vector3(-1082.1935, -2763.8074, 44.5574),
    Heading = 153.1498, -- Face away from wall.
}

Config.Formats = {
    DEFAULT_ID = [[
        <div id="ac-top">
            <b>{TEXT_1}</b>
        </div>
        <div id="ac-middle">
            <div id="ac-middle-1">
                <div id="ac-photo">
                </div>
                <div id="ac-info">
                    <div>
                        <span>ID</span>
                        <b style="color: rgb(186, 45, 45);">{TEXT_2}</b>
                    </div>
                    <div>
                        <span>DOB</span>
                        <b style="color: rgb(186, 45, 45);">{TEXT_3}</b>
                    </div>
                    <div>
                        <span>LN</span>
                        <b>{TEXT_4}</b>
                    </div>
                    <div>
                        <span>FN</span>
                        <b>{TEXT_5}</b>
                    </div>
                    <div>
                        <div style="display: flex; flex-direction: column;">
                            <b style="font-size: 0.55vw;">{TEXT_6}</b>
                            <b style="font-size: 0.55vw;">{TEXT_7}</b>
                        </div>
                    </div>
                </div>
            </div>
            <div id="ac-middle-2">
                <div id="ac-info2">
                    <div>
                        <span>HGT</span>
                        <b>{TEXT_8}</b>
                    </div>
                    <div>
                        <span>SEX</span>
                        <b>{TEXT_9}</b>
                    </div>
                    <div>
                        <span>EYES</span>
                        <b>{TEXT_10}</b>
                    </div>
                </div>
                <div id="ac-info3">
                </div>
            </div>
        </div>
        <div id="ac-bottom">
            <b>{TEXT_11}</b>
        </div>
    ]],
    DEFAULT_DOCUMENT = [[
        <div id="ad-top">
        </div>
        <div id="ad-middle">
        </div>
        <div id="ad-bottom">
        </div>
    ]],
}

Config.Documents = {
    -- Cards --
    ["Drivers"] = {
        Type = "card", 
        Item = "id_card",
        ItemLabel = "ID & Driver License", -- Works with ox_inventory as far as I know, meaning you can just use id_card, and document without needing new items. 
        Format = Config.Formats.DEFAULT_ID,
        RequiresPhoto = true,
        RequiredFields = { -- set RequiredFields = nil if not requiring additional data.
            {metakey = "gender", type = "select", label = "Gender", options = {
                { value = 'M', label = 'Male' },
                { value = 'F', label = 'Female' },
                { value = 'NB', label = 'Non-Binary / Other'},
            }},
            {metakey = "eyes", type = "input", label = "Eye Color"},
            {metakey = "height", type = "input", label = "Height"},
            {metakey = "address", type = "input", label = "Street Address"},
            {metakey = "location", type = "input", label = "City, State, and Zip code"},
        },
        CreateDocument = function(source, info, metadata, cb)
            local days = (60 * 60) * 24
            local date = os.date("%m/%d/%Y")
            local exp = os.date("%m/%d/%Y", os.time() + (30 * days))
            local document = {
                photoURL = metadata.photoURL,
                appStyle = "background: url('assets/images/default_card.jpg'); background-size: cover;",
                metaValues = {
                    {label = "CLASS", value = "D"},
                    {label = "ISSUED", value = date},
                    {label = "EXP", value = exp},
                },
                formatValues = {
                    ["TEXT_1"] = "ID & Driver License",
                    ["TEXT_2"] = math.random(100000, 999999),
                    ["TEXT_3"] = info.dateofbirth,
                    ["TEXT_4"] = string.upper(info.lastname),
                    ["TEXT_5"] = string.upper(info.firstname),
                    ["TEXT_6"] = metadata.address,
                    ["TEXT_7"] = metadata.location,
                    ["TEXT_8"] = metadata.height,
                    ["TEXT_9"] = metadata.gender,
                    ["TEXT_10"] = metadata.eyes,
                    ["TEXT_11"] = info.firstname .. " " .. info.lastname
                }
            }
            cb(document)
        end
    },
    ["Firearms"] = {
        Type = "card", 
        Item = "id_card",
        ItemLabel = "Firearms License", -- Works with ox_inventory as far as I know, meaning you can just use id_card, and document without needing new items. 
        Format = Config.Formats.DEFAULT_ID,
        RequiresPhoto = true,
        RequiredFields = { -- set RequiredFields = nil if not requiring additional data.
            {metakey = "gender", type = "select", label = "Gender", options = {
                { value = 'M', label = 'Male' },
                { value = 'F', label = 'Female' },
                { value = 'NB', label = 'Non-Binary / Other'},
            }},
            {metakey = "eyes", type = "input", label = "Eye Color"},
            {metakey = "height", type = "input", label = "Height"},
            {metakey = "address", type = "input", label = "Street Address"},
            {metakey = "location", type = "input", label = "City, State, and Zip code"},
        },
        CreateDocument = function(source, info, metadata, cb)
            local days = (60 * 60) * 24
            local date = os.date("%m/%d/%Y")
            local exp = os.date("%m/%d/%Y", os.time() + (30 * days))
            local document = {
                photoURL = metadata.photoURL,
                appStyle = "background: url('assets/images/firearm.png'); background-size: cover;",
                metaValues = {
                    {label = "CLASS", value = "A"},
                    {label = "ISSUED", value = date},
                    {label = "EXP", value = exp},
                },
                formatValues = {
                    ["TEXT_1"] = "Firearms License",
                    ["TEXT_2"] = math.random(100000, 999999),
                    ["TEXT_3"] = info.dateofbirth,
                    ["TEXT_4"] = string.upper(info.lastname),
                    ["TEXT_5"] = string.upper(info.firstname),
                    ["TEXT_6"] = metadata.address,
                    ["TEXT_7"] = metadata.location,
                    ["TEXT_8"] = metadata.height,
                    ["TEXT_9"] = metadata.gender,
                    ["TEXT_10"] = metadata.eyes,
                    ["TEXT_11"] = info.firstname .. " " .. info.lastname
                }
            }
            cb(document)
        end
    },
    ["Hunting"] = {
        Type = "card", 
        Item = "id_card",
        ItemLabel = "Hunting License", -- Works with ox_inventory as far as I know, meaning you can just use id_card, and document without needing new items. 
        Format = Config.Formats.DEFAULT_ID,
        RequiresPhoto = true,
        RequiredFields = { -- set RequiredFields = nil if not requiring additional data.
            {metakey = "gender", type = "select", label = "Gender", options = {
                { value = 'M', label = 'Male' },
                { value = 'F', label = 'Female' },
                { value = 'NB', label = 'Non-Binary / Other'},
            }},
            {metakey = "eyes", type = "input", label = "Eye Color"},
            {metakey = "height", type = "input", label = "Height"},
            {metakey = "address", type = "input", label = "Street Address"},
            {metakey = "location", type = "input", label = "City, State, and Zip code"},
        },
        CreateDocument = function(source, info, metadata, cb)
            local days = (60 * 60) * 24
            local date = os.date("%m/%d/%Y")
            local exp = os.date("%m/%d/%Y", os.time() + (30 * days))
            local document = {
                photoURL = metadata.photoURL,
                appStyle = "background: url('assets/images/hunting.png'); background-size: cover;",
                metaValues = {
                    {label = "CLASS", value = "A"},
                    {label = "ISSUED", value = date},
                    {label = "EXP", value = exp},
                },
                formatValues = {
                    ["TEXT_1"] = "Hunting License",
                    ["TEXT_2"] = math.random(100000, 999999),
                    ["TEXT_3"] = info.dateofbirth,
                    ["TEXT_4"] = string.upper(info.lastname),
                    ["TEXT_5"] = string.upper(info.firstname),
                    ["TEXT_6"] = metadata.address,
                    ["TEXT_7"] = metadata.location,
                    ["TEXT_8"] = metadata.height,
                    ["TEXT_9"] = metadata.gender,
                    ["TEXT_10"] = metadata.eyes,
                    ["TEXT_11"] = info.firstname .. " " .. info.lastname
                }
            }
            cb(document)
        end
    },
    ["Weed"] = {
        Type = "card", 
        Item = "id_card",
        ItemLabel = "Medical Dispensiary License", -- Works with ox_inventory as far as I know, meaning you can just use id_card, and document without needing new items. 
        Format = Config.Formats.DEFAULT_ID,
        RequiresPhoto = true,
        RequiredFields = { -- set RequiredFields = nil if not requiring additional data.
            {metakey = "gender", type = "select", label = "Gender", options = {
                { value = 'M', label = 'Male' },
                { value = 'F', label = 'Female' },
                { value = 'NB', label = 'Non-Binary / Other'},
            }},
            {metakey = "eyes", type = "input", label = "Eye Color"},
            {metakey = "height", type = "input", label = "Height"},
            {metakey = "address", type = "input", label = "Street Address"},
            {metakey = "location", type = "input", label = "City, State, and Zip code"},
        },
        CreateDocument = function(source, info, metadata, cb)
            local days = (60 * 60) * 24
            local date = os.date("%m/%d/%Y")
            local exp = os.date("%m/%d/%Y", os.time() + (30 * days))
            local document = {
                photoURL = metadata.photoURL,
                appStyle = "background: url('assets/images/weed.png'); background-size: cover;",
                metaValues = {
                    {label = "CLASS", value = "A"},
                    {label = "ISSUED", value = date},
                    {label = "EXP", value = exp},
                },
                formatValues = {
                    ["TEXT_1"] = "Medical Dispensiary License",
                    ["TEXT_2"] = math.random(100000, 999999),
                    ["TEXT_3"] = info.dateofbirth,
                    ["TEXT_4"] = string.upper(info.lastname),
                    ["TEXT_5"] = string.upper(info.firstname),
                    ["TEXT_6"] = metadata.address,
                    ["TEXT_7"] = metadata.location,
                    ["TEXT_8"] = metadata.height,
                    ["TEXT_9"] = metadata.gender,
                    ["TEXT_10"] = metadata.eyes,
                    ["TEXT_11"] = info.firstname .. " " .. info.lastname
                }
            }
            cb(document)
        end
    },
    ["Vending"] = {
        Type = "card", 
        Item = "id_card",
        ItemLabel = "Vending License", -- Works with ox_inventory as far as I know, meaning you can just use id_card, and document without needing new items. 
        Format = Config.Formats.DEFAULT_ID,
        RequiresPhoto = true,
        RequiredFields = { -- set RequiredFields = nil if not requiring additional data.
            {metakey = "gender", type = "select", label = "Gender", options = {
                { value = 'M', label = 'Male' },
                { value = 'F', label = 'Female' },
                { value = 'NB', label = 'Non-Binary / Other'},
            }},
            {metakey = "eyes", type = "input", label = "Eye Color"},
            {metakey = "height", type = "input", label = "Height"},
            {metakey = "address", type = "input", label = "Street Address"},
            {metakey = "location", type = "input", label = "City, State, and Zip code"},
        },
        CreateDocument = function(source, info, metadata, cb)
            local days = (60 * 60) * 24
            local date = os.date("%m/%d/%Y")
            local exp = os.date("%m/%d/%Y", os.time() + (30 * days))
            local document = {
                photoURL = metadata.photoURL,
                appStyle = "background: url('assets/images/vendor.png'); background-size: cover;",
                metaValues = {
                    {label = "CLASS", value = "A"},
                    {label = "ISSUED", value = date},
                    {label = "EXP", value = exp},
                },
                formatValues = {
                    ["TEXT_1"] = "Vending License",
                    ["TEXT_2"] = math.random(100000, 999999),
                    ["TEXT_3"] = info.dateofbirth,
                    ["TEXT_4"] = string.upper(info.lastname),
                    ["TEXT_5"] = string.upper(info.firstname),
                    ["TEXT_6"] = metadata.address,
                    ["TEXT_7"] = metadata.location,
                    ["TEXT_8"] = metadata.height,
                    ["TEXT_9"] = metadata.gender,
                    ["TEXT_10"] = metadata.eyes,
                    ["TEXT_11"] = info.firstname .. " " .. info.lastname
                }
            }
            cb(document)
        end
    },
    ["Government"] = {
        Type = "card", 
        Item = "id_card",
        ItemLabel = "Government ID", -- Works with ox_inventory as far as I know, meaning you can just use id_card, and document without needing new items. 
        Format = Config.Formats.DEFAULT_ID,
        RequiresPhoto = true,
        RequiredFields = { -- set RequiredFields = nil if not requiring additional data.
            {metakey = "gender", type = "select", label = "Gender", options = {
                { value = 'M', label = 'Male' },
                { value = 'F', label = 'Female' },
                { value = 'NB', label = 'Non-Binary / Other'},
            }},
            {metakey = "eyes", type = "input", label = "Eye Color"},
            {metakey = "height", type = "input", label = "Height"},
            {metakey = "department", type = "input", label = "Department"},
            {metakey = "callsign", type = "input", label = "Callsign"},
        },
        CreateDocument = function(source, info, metadata, cb)
            local days = (60 * 60) * 24
            local date = os.date("%m/%d/%Y")
            local exp = os.date("%m/%d/%Y", os.time() + (30 * days))
            local document = {
                photoURL = metadata.photoURL,
                appStyle = "background: url('assets/images/government.png'); background-size: cover;",
                metaValues = {
                    {label = "ISSUED", value = date},
                    {label = "EXP", value = exp},
                },
                formatValues = {
                    ["TEXT_1"] = "Government ID",
                    ["TEXT_2"] = math.random(100000, 999999),
                    ["TEXT_3"] = info.dateofbirth,
                    ["TEXT_4"] = string.upper(info.lastname),
                    ["TEXT_5"] = string.upper(info.firstname),
                    ["TEXT_6"] = metadata.callsign,
                    ["TEXT_7"] = metadata.department,
                    ["TEXT_8"] = metadata.height,
                    ["TEXT_9"] = metadata.gender,
                    ["TEXT_10"] = metadata.eyes,
                    ["TEXT_11"] = info.firstname .. " " .. info.lastname
                }
            }
            cb(document)
        end
    },
    ["Medical"] = {
        Type = "card", 
        Item = "id_card",
        ItemLabel = "Medical ID", -- Works with ox_inventory as far as I know, meaning you can just use id_card, and document without needing new items. 
        Format = Config.Formats.DEFAULT_ID,
        RequiresPhoto = true,
        RequiredFields = { -- set RequiredFields = nil if not requiring additional data.
            {metakey = "gender", type = "select", label = "Gender", options = {
                { value = 'M', label = 'Male' },
                { value = 'F', label = 'Female' },
                { value = 'NB', label = 'Non-Binary / Other'},
            }},
            {metakey = "eyes", type = "input", label = "Eye Color"},
            {metakey = "height", type = "input", label = "Height"},
            {metakey = "department", type = "input", label = "Department"},
            {metakey = "callsign", type = "input", label = "Callsign"},
        },
        CreateDocument = function(source, info, metadata, cb)
            local days = (60 * 60) * 24
            local date = os.date("%m/%d/%Y")
            local exp = os.date("%m/%d/%Y", os.time() + (30 * days))
            local document = {
                photoURL = metadata.photoURL,
                appStyle = "background: url('assets/images/medical.png'); background-size: cover;",
                metaValues = {
                    {label = "ISSUED", value = date},
                    {label = "EXP", value = exp},
                },
                formatValues = {
                    ["TEXT_1"] = "Medical ID",
                    ["TEXT_2"] = math.random(100000, 999999),
                    ["TEXT_3"] = info.dateofbirth,
                    ["TEXT_4"] = string.upper(info.lastname),
                    ["TEXT_5"] = string.upper(info.firstname),
                    ["TEXT_6"] = metadata.callsign,
                    ["TEXT_7"] = metadata.department,
                    ["TEXT_8"] = metadata.height,
                    ["TEXT_9"] = metadata.gender,
                    ["TEXT_10"] = metadata.eyes,
                    ["TEXT_11"] = info.firstname .. " " .. info.lastname
                }
            }
            cb(document)
        end
    },
    -- Documents --
    ["VehicleRegistration"] = {
        Type = "document", 
        Item = "document",
        ItemLabel = "Vehicle Registration", -- Works with ox_inventory as far as I know, meaning you can just use id_card, and document without needing new items. 
        Format = Config.Formats.DEFAULT_DOCUMENT,
        RequiresPhoto = false,
        RequiredFields = { -- set RequiredFields = nil if not requiring additional data.
            {metakey = "plate", type = "input", label = "Vehicle Plate"}, -- Under CreateDocument, metadata.plate will return what the user inputted.
            {metakey = "dealer", type = "input", label = "Vehicle Dealer"},
        },
        CreateDocument = function(source, info, metadata, cb)
            local date = os.date("%m/%d/%Y")
            local document = {
                appStyle = "background: url('assets/images/default_document.png'); background-size: 100% 100%;",
                elements = {
                    ["#ad-top"] = {
                        {html = "<b>Vehicle Registration</b>"},
                    },
                    ["#ad-middle"] = {
                        {label = "Plate:", value = metadata.plate},
                        {label = "VIN:", value = math.random(1000000, 9999999)},
                        {label = "Owner:", value = info.firstname .. " " .. info.lastname},
                        {label = "Dealer:", value = metadata.dealer},
                        {label = "Registration Date:", value = date},
                    },
                    ["#ad-bottom"] = {
                        {label = "Owner Signature:", value = "<span style='font-weight:bold; font-family: Signature;'>"..info.firstname .. " " .. info.lastname.."</span>"},
                        {label = "Dealer Signature:", value = "<span style='font-weight:bold; font-family: Signature;'>".. metadata.dealer .."</span>"},
                    },
                },
            }
            cb(document)
        end
    },
    ["PropertyOwnership"] = {
        Type = "document", 
        Item = "document",
        ItemLabel = "Property Deed", -- Works with ox_inventory as far as I know, meaning you can just use id_card, and document without needing new items. 
        Format = Config.Formats.DEFAULT_DOCUMENT,
        RequiresPhoto = false,
        RequiredFields = { -- set RequiredFields = nil if not requiring additional data.
            {metakey = "address", type = "input", label = "Street Address"},
            {metakey = "location", type = "input", label = "City, State, and Zip code"},
        },
        CreateDocument = function(source, info, metadata, cb)
            local date = os.date("%m/%d/%Y")
            local document = {
                appStyle = "background: url('assets/images/default_document.png'); background-size: 100% 100%;",
                elements = {
                    ["#ad-top"] = {
                        {html = "<b>Property Deed</b>"},
                    },
                    ["#ad-middle"] = {
                        {label = "Owner:", value = info.firstname .. " " .. info.lastname},
                        {label = "Street Address:", value = metadata.address .. ", " .. metadata.location},
                        {label = "Registration Date:", value = date},
                    },
                    ["#ad-bottom"] = {
                        {label = "Owner Signature:", value = "<span style='font-weight:bold; font-family: Signature;'>"..info.firstname .. " " .. info.lastname.."</span>"},
                    },
                },
            }
            cb(document)
        end
    },
    ["WeaponRegistration"] = {
        Type = "document", 
        Item = "document",
        ItemLabel = "Weapon Registration", -- Works with ox_inventory as far as I know, meaning you can just use id_card, and document without needing new items. 
        Format = Config.Formats.DEFAULT_DOCUMENT,
        RequiresPhoto = false,
        RequiredFields = { -- set RequiredFields = nil if not requiring additional data.
            {metakey = "serial", type = "input", label = "Serial Number"},
        },
        CreateDocument = function(source, info, metadata, cb)
            local date = os.date("%m/%d/%Y")
            local document = {
                appStyle = "background: url('assets/images/default_document.png'); background-size: 100% 100%;",
                elements = {
                    ["#ad-top"] = {
                        {html = "<b>Weapon Registration</b>"},
                    },
                    ["#ad-middle"] = {
                        {label = "Owner:", value = info.firstname .. " " .. info.lastname},
                        {label = "Serial Number:", value = metadata.serial},
                        {label = "Registration Date:", value = date},
                    },
                    ["#ad-bottom"] = {
                        {label = "Owner Signature:", value = "<span style='font-weight:bold; font-family: Signature;'>"..info.firstname .. " " .. info.lastname.."</span>"},
                    },
                },
            }
            cb(document)
        end
    },
}

Config.Locations = {
    {
        Blip = {
            Label = "Department of Motor Vehicles",
            ID = 419,
            Display = 4,
            Color = 0,
            Scale = 0.35,
        },
        Coords = vector3(632.19, -17.24, 82.07),
        Options = {
            {
                label = "ID & Driver License", 
                document = "Drivers", 
                groups = nil,
                items = {
                    ["money"] = 100
                },
            },
            -- {
            --     label = "Firearms License", 
            --     document = "Firearms", 
            --     groups = nil,
            --     items = {
            --         ["money"] = 100
            --     },
            -- },
            {
                label = "Hunting License", 
                document = "Hunting", 
                groups = {
                    ["police"] = 0
                },
                items = {
                    ["money"] = 100
                },
            },
            -- {
            --     label = "Vending License", 
            --     document = "Vending", 
            --     groups = nil,
            --     items = {
            --         ["money"] = 100
            --     },
            -- },
            -- {
            --     label = "Medical Dispensiary Card", 
            --     document = "Weed", 
            --     groups = nil,
            --     items = {
            --         ["money"] = 100
            --     },
            -- },
            -- {
            --     label = "Government ID", 
            --     document = "Government", 
            --     groups = {
            --         ["police"] = 0
            --     },
            --     items = {
            --         ["money"] = 100
            --     },
            -- },
            {
                label = "Medical ID", 
                document = "Medical", 
                groups = {
                    ["ambulance"] = 0
                },
                items = {
                    ["money"] = 100
                },
            },
            {
                label = "Vehicle Registration", 
                document = "VehicleRegistration", 
                groups = nil,
                items = {
                    ["money"] = 100
                },
            },
            {
                label = "Property Ownership", 
                document = "PropertyOwnership", 
                groups = nil,
                items = {
                    ["money"] = 100
                },
            },
            {
                label = "Weapon Registration", 
                document = "WeaponRegistration", 
                groups = {
                    ["police"] = 0
                },
                items = {
                    ["money"] = 100
                },
            },
        }
    }
}