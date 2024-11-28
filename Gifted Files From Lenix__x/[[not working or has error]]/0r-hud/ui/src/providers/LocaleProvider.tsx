import { createContext, useEffect, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { debugData } from "../utils/debugData";
import { fetchNui } from "../utils/fetchNui";
import { LocaleContextProps, LocaleProps } from "../types/LocaleProviderTypes";
import { isEnvBrowser } from "../utils/misc";

debugData<LocaleProps>([
  {
    action: "setLocale",
    data: {
      settings_text_settings_menu: "Settings Menu",
      settings_text_change_your_settings: "Change your settings",
      settings_text_save: "Save",
      settings_text_hud: "Hud",
      settings_text_settings: "Settings",
      settings_text_map: "Map",
      settings_text_open_map: "Open Map",
      settings_text_open_settings_menu: "Open Settings Menu",
      settings_text_minimap_style: "Minimap Style",
      settings_text_choose_minimap_style: "Choose the minimap style",
      settings_text_minimap_square: "Square",
      settings_text_minimap_circle: "Circle",
      settings_text_speedometerFPS: "Speedometer FPS",
      settings_text_speedometer_desc:
        "The higher the FPS, the more demanding this is on your machine.",
      settings_text_health_icon: "Health Icon",
      settings_text_hideWhenMoreThen: "Hide when more than...",
      settings_text_never_hide: "100 : Never Hide",
      settings_text_armor_icon: "Armor Icon",
      settings_text_hunger_icon: "Food Icon",
      settings_text_thirst_icon: "Water Icon",
      settings_text_oxygen_icon: "Oxygen Icon",
      settings_text_stamina_icon: "Stamina Icon",
      settings_text_stress_icon: "Stress Icon",
      settings_text_terminal_icon: "Terminal Icon",
      settings_text_leaf_icon: "Leaf Icon",
      settings_text_compass_hud: "Compass Hud",
      settings_text_vehicle_hud: "Vehicle Hud",
      settings_text_vehicle_position: "Vehicle Hud Position",
      settings_text_color: "Color",
      settings_text_j_type: "Type",
      settings_text_type_number: "Type: ",
      settings_text_bars: "Status Bar",
      settings_text_desc_change_bar: "Change your status bar style.",
      settings_text_vehicle_mode: "Vehicle Gear Mode",
      settings_text_desc_vehicle_mode: "Change vehicle gear mode.",
      settings_text_manual_mode: "Manual",
      settings_text_oto_mode: "Oto",
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
    fetchNui("loadLocaleFile");
  }, []);

  useNuiEvent("setLocale", async (data: LocaleProps) => setLocale(data));

  const value = {
    locale,
    setLocale,
  };

  return <LocaleCtx.Provider value={value}>{children}</LocaleCtx.Provider>;
};

export default LocaleProvider;
