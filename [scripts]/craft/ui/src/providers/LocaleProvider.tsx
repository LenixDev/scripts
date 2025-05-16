import { createContext, useEffect, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { debugData } from "../utils/debugData";
import { fetchNui } from "../utils/fetchNui";
import { LocaleContextProps, LocaleProps } from "../types/LocaleProviderTypes";
import { isEnvBrowser } from "../utils/misc";

debugData<LocaleProps>([
  {
    action: "ui:setLocale",
    data: {
      text_crafting_table: "Crafting Table",
      text_personal: "Personal",
      text_crafting_table_desc: "Modify your items or craft new items",
      text_crafting: "Crafting",
      text_your_attachments: "Your attachments",
      text_attachable_attachments_inventory:
        "Attachable attachments in your inventory",
      text_your_guns: "Your Guns",
      text_modifiable_items_inventory: "Modifiable items in your inventory",
      text_modify: "Modify",
      text_note_equipped: "Note Equipped",
      text_crafting_queue: "Crafting Queue",
      text_items_queued: "Items queued to be production",
      text_createable_items: "Createable Items",
      text_craft: "Craft",
      text_start_crafting: "Start Crafting",
      text_pick_up: "Pick Up",
      text_choose_an_item: "Choose An Item",
    },
  },
]);

export const LocaleCtx = createContext<LocaleContextProps>(
  {} as LocaleContextProps
);

export const LocaleProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [locale, setLocale] = useState<LocaleProps>({} as LocaleProps);

  useEffect(() => {
    if (isEnvBrowser()) return;
    fetchNui("nui:loadLocaleFile");
  }, []);

  useNuiEvent("ui:setLocale", async (data: LocaleProps) => setLocale(data));

  const value = {
    locale,
    setLocale,
  };

  return <LocaleCtx.Provider value={value}>{children}</LocaleCtx.Provider>;
};

export default LocaleProvider;
