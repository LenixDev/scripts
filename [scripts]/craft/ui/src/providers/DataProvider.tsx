import React, { createContext, useEffect, useState } from "react";
import {
  AttachmentBoxesProps,
  CraftableItemProps,
  CraftableItemsProps,
  CraftingQueueProps,
  DataContextProps,
  QueueProps,
  WeaponAttachmentsProps,
  WeaponProps,
} from "../types/DataProviderTypes";
import { ThemeColorProps, MenuProps } from "../types/BasicTypes";
import { debugData } from "../utils/debugData";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
import { useVisibility } from "../hooks/useVisibility";

debugData<CraftableItemsProps>([
  {
    action: "ui:setCraftableItems",
    data: {
      weapon_assaultrifle: {
        index: 1,
        name: "weapon_assaultrifle",
        label: "Assault Rifle",
        count: 1,
        duration: 1000,
        image: "weapons/attachments/at_grip.png",
        propModel: "",
        ingredients: {
          scrapmetal: {
            count: 10,
            name: "scrapmetal",
            label: "Scrap Metal",
            need: 5,
          },
          WEAPON_HAMMER: {
            count: 0.9,
            name: "WEAPON_HAMMER",
            label: "HAMMER",
            need: 0.1,
          },
        },
        price: 3500,
        canItBeCraftable: true,
      },
      weapon_pistol: {
        index: 2,
        name: "weapon_pistol",
        label: "Pistol",
        count: 1,
        duration: 1000,
        image: "weapons/weapon_pistol.png",
        propModel: "",
        ingredients: {
          scrapmetal: {
            count: 1,
            name: "scrapmetal",
            label: "Scrap Metal",
            need: 1,
          },
          WEAPON_HAMMER: {
            count: 1,
            name: "WEAPON_HAMMER",
            label: "HAMMER",
            need: 0.05,
          },
        },
        price: 1000,
        canItBeCraftable: false,
      },
    },
  },
]);
debugData<CraftingQueueProps>([
  {
    action: "ui:addCraftingQueue",
    data: {
      index: 1,
      name: "weapon_assaultrifle",
      label: "Assault Rifle",
      count: 1,
      duration: 10000,
      image: "weapons/weapon_assaultrifle.png",
      propModel: "",
      ingredients: {
        scrapmetal: {
          count: 10,
          name: "scrapmetal",
          label: "Scrap Metal",
          need: 5,
        },
        WEAPON_HAMMER: {
          count: 0.9,
          name: "WEAPON_HAMMER",
          label: "HAMMER",
          need: 0.1,
        },
      },
      price: 3500,
      canItBeCraftable: true,
      remaining: 0,
    },
  },
]);

export const DataCtx = createContext<DataContextProps>({} as DataContextProps);

export const DataProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const { visible } = useVisibility();
  const [activeMenu, setActiveMenu] = useState<MenuProps>("personal");
  const [themeColor, setThemeColor] = useState<ThemeColorProps>("_red");
  const [inventoryWeapons, setInventoryWeapons] = useState<WeaponProps[]>([]);
  const [inventoryAttachments, setInventoryAttachments] = useState<
    WeaponAttachmentsProps[]
  >([]);
  const [selectedItem, setSelectedItem] = useState<WeaponProps>(
    {} as WeaponProps
  );
  const [selectedCraftableItem, setSelectedCraftableItem] =
    useState<CraftableItemProps>({} as CraftableItemProps);
  const [attachmentBoxes, setAttachmentBoxes] = useState<
    AttachmentBoxesProps[]
  >([]);
  const [CraftableItems, setCraftableItems] = useState<CraftableItemProps[]>(
    []
  );
  const [CraftingQueue, setCraftingQueue] = useState<CraftingQueueProps[]>([]);
  const [CompletedCraftingQueue, setCompletedCraftingQueue] = useState<
    CraftingQueueProps[]
  >([]);

  useEffect(() => {
    if (!visible) {
      setActiveMenu("personal");
      setInventoryWeapons([]);
      setInventoryAttachments([]);
      setSelectedItem({} as WeaponProps);
      setSelectedCraftableItem({} as CraftableItemProps);
      setAttachmentBoxes([]);
      setCraftingQueue([]);
      setCompletedCraftingQueue([]);
    }
  }, [visible]);

  useNuiEvent("ui:setInventoryWeapons", (items: WeaponProps[]) => {
    setInventoryWeapons(items);
  });

  useNuiEvent(
    "ui:setInventoryAttachments",
    (items: WeaponAttachmentsProps[]) => {
      setInventoryAttachments(items);
    }
  );

  useNuiEvent(
    "ui:SETUP_ATTACHMENT_BOXES",
    (attachments: AttachmentBoxesProps[]) => {
      setAttachmentBoxes(attachments);
    }
  );

  useNuiEvent("ui:setTheme", (color: string) => {
    switch (color) {
      case "red":
      case "blue":
      case "orange":
      case "green":
        setThemeColor(("_" + color) as ThemeColorProps);
        return;
      default:
        setThemeColor("_red");
        return;
    }
  });

  useNuiEvent("ui:setCraftableItems", (data: CraftableItemsProps) => {
    setCraftableItems(Object.values(data));
  });

  useNuiEvent("ui:addCraftingQueue", (item: QueueProps) => {
    setCraftingQueue([...CraftingQueue, item]);
  });

  useNuiEvent("ui:updateCraftingQueue", ({ queues, completedQueues }) => {
    setCraftingQueue(queues);
    setCompletedCraftingQueue(completedQueues);
  });

  useNuiEvent("ui:setCompletedCraftingQueue", (data) => {
    setCompletedCraftingQueue(data);
  });

  const changeActivePage = (page: MenuProps) => {
    if (page == "crafting") {
      setInventoryAttachments([]);
      setSelectedItem({} as WeaponProps);
      setAttachmentBoxes([]);
    } else if (page == "personal") {
      setSelectedCraftableItem({} as CraftableItemProps);
      setAttachmentBoxes([]);
    }
    setActiveMenu(page);
    fetchNui("nui:ChangedActivePage", page, true);
  };

  const loadSelectedWeapon = (weapon: WeaponProps) => {
    if (weapon.index == selectedItem.index) return;
    setSelectedItem(weapon);
    fetchNui("nui:GetPlayerOwnedAttachmentsByWeapon", {
      weapon: weapon.name,
    }).then((attachments) => {
      setInventoryAttachments(attachments);
    });
    fetchNui("nui:LoadSelectedWeaponOnMiddle", {
      weapon: weapon,
    }).then((data) => {
      if (data) {
        setSelectedItem((p) => ({
          ...p,
          object: data,
        }));
      }
    });
  };

  const loadSelectedCraftableItem = (item: CraftableItemProps) => {
    if (item.name == selectedCraftableItem.name) return;
    setSelectedCraftableItem(item);
    fetchNui(
      "nui:GetPlayerOwnedItemsByIngredients",
      {
        item: item,
      },
      {
        ingredients: item.ingredients,
        canItBeCraftable: item.canItBeCraftable,
      }
    ).then((data) => {
      setSelectedCraftableItem((p) => ({
        ...p,
        ingredients: data?.ingredients,
        canItBeCraftable: data?.canItBeCraftable,
      }));
    });
    fetchNui("nui:LoadSelectedCraftableOnMiddle", {
      item: item,
    }).then((data) => {
      if (data) {
        setSelectedCraftableItem((p) => ({
          ...p,
          object: data,
        }));
      }
    });
  };

  const addAttachment = (attachment: WeaponAttachmentsProps) => {
    fetchNui("nui:AddAttachmentToSelectedWeapon", {
      weapon: selectedItem,
      attachment: attachment,
    }).then((response) => {
      if (response) {
        const newAttachment = response.newAttachment;
        const newMetadata = response.newMetadata;
        setInventoryAttachments((prevAttachments) =>
          prevAttachments?.filter((item) => item.index !== attachment.index)
        );
        setSelectedItem((prevSelectedItem) => ({
          ...prevSelectedItem,
          attachments: [...prevSelectedItem.attachments, newAttachment],
          _item: {
            ...prevSelectedItem._item,
            metadata: newMetadata,
          },
        }));
        setInventoryWeapons((prevInventoryWeapons) =>
          prevInventoryWeapons.map((_weapon) =>
            _weapon.index === selectedItem.index
              ? {
                  ..._weapon,
                  attachments: [..._weapon.attachments, newAttachment],
                  _item: {
                    ..._weapon._item,
                    metadata: newMetadata,
                  },
                }
              : _weapon
          )
        );
        setAttachmentBoxes((prevBoxes) =>
          prevBoxes.map((box) =>
            box.slot == newAttachment.type
              ? {
                  ...box,
                  child: newAttachment,
                }
              : box
          )
        );
      }
    });
  };

  const removeAttachment = (attachment: WeaponAttachmentsProps) => {
    fetchNui(
      "nui:RemoveAttachmentToSelectedWeapon",
      {
        weapon: selectedItem,
        attachment: attachment,
      },
      {
        newMetadata: {},
      }
    ).then((response) => {
      if (response) {
        const newMetadata = response.newMetadata;
        setInventoryAttachments((prevAttachments) => [
          ...prevAttachments,
          attachment,
        ]);
        setSelectedItem((prevSelectedItem) => ({
          ...prevSelectedItem,
          attachments: prevSelectedItem?.attachments?.filter(
            (_attachment) => _attachment.index !== attachment.index
          ),
          _item: {
            ...prevSelectedItem._item,
            metadata: newMetadata,
          },
        }));
        setInventoryWeapons((prevInventoryWeapons) =>
          prevInventoryWeapons.map((_weapon) =>
            _weapon.index === selectedItem.index
              ? {
                  ..._weapon,
                  attachments: _weapon?.attachments?.filter(
                    (_attachment) => _attachment.index !== attachment.index
                  ),
                  _item: {
                    ..._weapon._item,
                    metadata: newMetadata,
                  },
                }
              : _weapon
          )
        );
        setAttachmentBoxes((prevBoxes) =>
          prevBoxes.map((box) =>
            box.slot == attachment.type
              ? {
                  ...box,
                  child: null,
                }
              : box
          )
        );
      }
    });
  };

  const AddSelectedItemToCraftingQueue = async (): Promise<boolean> => {
    const response: any = await fetchNui("nui:AddSelectedItemToCraftingQueue", {
      item: selectedCraftableItem,
    });
    if (response) {
      setCraftingQueue([...CraftingQueue, selectedCraftableItem]);
      fetchNui("nui:GetPlayerOwnedItemsByIngredients", {
        item: selectedCraftableItem,
      }).then((data) => {
        setSelectedCraftableItem((p) => ({
          ...p,
          ingredients: data?.ingredients,
          canItBeCraftable: data?.canItBeCraftable,
        }));
      });
    }
    return true;
  };

  const ItemPickUp = async (queue: QueueProps): Promise<boolean> => {
    const response: any = await fetchNui("nui:ItemPickUpFromQueue", {
      queue: queue,
    });
    if (response) {
      setCompletedCraftingQueue((prev) =>
        prev?.filter((item) => item.index !== queue.index)
      );
    }
    return true;
  };

  const value = {
    themeColor,
    setThemeColor,
    activeMenu,
    setActiveMenu,
    inventoryWeapons,
    inventoryAttachments,
    setInventoryWeapons,
    selectedItem,
    setSelectedItem,
    attachmentBoxes,
    setAttachmentBoxes,
    addAttachment,
    removeAttachment,
    loadSelectedWeapon,
    changeActivePage,
    selectedCraftableItem,
    setSelectedCraftableItem,
    CraftableItems,
    loadSelectedCraftableItem,
    AddSelectedItemToCraftingQueue,
    CraftingQueue,
    CompletedCraftingQueue,
    ItemPickUp,
  };
  return <DataCtx.Provider value={value}>{children}</DataCtx.Provider>;
};
