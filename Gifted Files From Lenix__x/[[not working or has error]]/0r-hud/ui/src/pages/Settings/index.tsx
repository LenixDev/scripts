import { useEffect, useState } from "react";
import { SettingsPagesProps } from "../../types/BasicTypes";
import useData from "../../hooks/useData";
import "./index.sass";
import { fetchNui } from "../../utils/fetchNui";
import useLocales from "../../hooks/useLocales";
import { HudSettings } from "./HudSettings";
import Home from "../Home";
import useRouter from "../../hooks/useRouter";

const Settings = () => {
  const { saveSettings, vehicleHud, setVehicleHud } = useData();
  const { locale } = useLocales();
  const { setRouter, router } = useRouter();
  const [activePage, setActivePage] = useState<SettingsPagesProps>("hud");
  const handleSaveSettings = () => {
    saveSettings(activePage);
    setRouter("home");
  };

  useEffect(() => {
    if (router == "settings") {
      if (activePage == "map") {
        setRouter("home");
        fetchNui("OnHideSettingsMenu");
        fetchNui("openBigMap");
      } else if (activePage == "pause_menu") {
        setRouter("home");
        fetchNui("OnHideSettingsMenu");
        fetchNui("openPauseMenu");
      }
    }
  }, [activePage, router, setRouter]);

  return (
    <>
      <div className="h-full w-full flex items-center justify-center">
        <div className="relative flex w-[50rem] h-[51rem] flex-col rounded-2xl bg-settings/[0.95] border-[2px] border-[#212121]">
          <div>
            <div className="p-4 text-start flex items-center gap-2">
              <div className="relative">
                <img
                  src="images/setting-icon.svg"
                  alt="settings-icon"
                  className="text-settings_green"
                />
                <div className="absolute shadow-settings_green shadow-[0_0_24px_4px] left-4 bottom-4"></div>
              </div>
              <div>
                <h1 className="font-bold text-xl font-[inherit] text-settings_green text-shadow shadow-settings_green">
                  {locale.settings_text_settings_menu}
                </h1>
                <h1 className="text-sm font-[inherit] text-[#757575]">
                  {locale.settings_text_change_your_settings}
                </h1>
              </div>
              <div className="ml-auto">
                <button
                  className="bg-white p-1.5 px-4 rounded brightness-110 hover:brightness-125"
                  onClick={handleSaveSettings}
                >
                  <h1 className="text-black font-extrabold uppercase">
                    {locale.settings_text_save}
                  </h1>
                </button>
              </div>
            </div>
            <hr className="border-[#212121] border" />
          </div>
          <div className="p-3">
            <div className="flex gap-4 items-center mb-3">
              <button
                onClick={() => setActivePage("map")}
                className="group transition-colors max-w-[220px] h-[92px] w-full border-[2px] border-[#212121] flex items-center justify-center text-center rounded bg-cover bg-no-repeat"
                style={{ backgroundImage: `url("images/GTAV_Atlas.png")` }}
              >
                <div className="text-[#949EFF] font-bold uppercase group-hover:text-settings_green">
                  <h1 className="text-3xl">{locale.settings_text_map}</h1>
                  <h1 className="text-sm">{locale.settings_text_open_map}</h1>
                </div>
              </button>
              <button
                onClick={() => setActivePage("map")}
                className="transition-colors max-w-[70px] h-[92px] rounded bg-cover bg-no-repeat w-full"
                style={{
                  backgroundImage: `url("images/game-settings-button.svg")`,
                }}
              />
              <div className="flex flex-col gap-2 w-full">
                <div className="flex justify-between items-center bg-[#212121] text-start rounded h-[42px] p-2 px-3">
                  <div className="mr-2">
                    <h1 className="font-bold text-white text-[13px]">
                      {locale.settings_text_minimap_style}
                    </h1>
                    <h1 className="max-h-4 text-[9px] font-[inherit] text-[#757575] whitespace-nowrap text-ellipsis overflow-hidden">
                      {locale.settings_text_choose_minimap_style}
                    </h1>
                  </div>
                  <div>
                    <label htmlFor="minimapstyle" className="sr-only">
                      {locale.settings_text_minimap_style}
                    </label>
                    <select
                      id="minimapstyle"
                      className="bg-[#272727] text-white text-sm p-1 px-2 rounded-sm ring-0 outline-none"
                      value={vehicleHud.miniMaP.style}
                      onChange={(event) => {
                        setVehicleHud((p) => ({
                          ...p,
                          miniMaP: {
                            ...p.miniMaP,
                            style: event.target.value as any,
                          },
                        }));
                      }}
                    >
                      <option value={""} disabled>
                        {locale.settings_text_choose_minimap_style}
                      </option>
                      <option value="square">
                        {locale.settings_text_minimap_square}
                      </option>
                      <option value="circle">
                        {locale.settings_text_minimap_circle}
                      </option>
                    </select>
                  </div>
                </div>
                <div className="flex justify-between items-center bg-[#212121] text-start rounded h-[42px] p-2 px-3">
                  <div className="mr-2">
                    <h1 className="font-bold text-white text-[13px]">
                      {locale.settings_text_speedometerFPS}
                    </h1>
                    <h1 className="max-h-4 text-[9px] font-[inherit] text-[#757575]">
                      {locale.settings_text_speedometer_desc}
                    </h1>
                  </div>
                  <div>
                    <label htmlFor="speedometerfps" className="sr-only">
                      {locale.settings_text_speedometerFPS}
                    </label>
                    <select
                      id="speedometerfps"
                      className="bg-[#272727] text-white text-sm p-1 px-2 rounded-sm ring-0 outline-none"
                      value={vehicleHud.speedoMeter.fps}
                      onChange={(event) => {
                        setVehicleHud((p) => ({
                          ...p,
                          speedoMeter: {
                            fps: parseInt(event.target.value),
                          },
                        }));
                      }}
                    >
                      <option value="" disabled>
                        {locale.settings_text_speedometerFPS}
                      </option>
                      <option value={15}>15</option>
                      <option value={30}>30</option>
                      <option value={60}>60</option>
                    </select>
                  </div>
                </div>
              </div>
            </div>
            <div className="w-full overflow-auto h-[38rem] no-scrollbar">
              <HudSettings />
            </div>
          </div>
        </div>
      </div>
      <Home />
    </>
  );
};

export default Settings;
