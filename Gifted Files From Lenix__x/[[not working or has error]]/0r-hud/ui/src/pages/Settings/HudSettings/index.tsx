import { ColorSelector } from "../../../components/ColorSelector";
import useData from "../../../hooks/useData";
import useLocales from "../../../hooks/useLocales";
import { HexagonColors } from "../../../types/BasicTypes";
import { fetchNui } from "../../../utils/fetchNui";

export const HudSettings = () => {
  const {
    statusBars,
    vehicleHud,
    setVehicleHud,
    setStatusBars,
    compassHud,
    setCompassHud,
  } = useData();
  const { locale } = useLocales();

  return (
    <div>
      <div className="mb-2 w-full">
        <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
          <div className="p-3 border-r border-[rgba(217,217,217,0.1)] h-20 flex items-center">
            <img
              src="images/simple_setting.svg"
              alt="status-bar-types"
              className="w-10 h-10"
            />
          </div>
          <div className="px-3">
            <h1 className="font-bold text-base text-white">
              {locale.settings_text_bars}
            </h1>
            <h1 className="text-xs font-[inherit] text-[#757575] font-semibold">
              {locale.settings_text_desc_change_bar}
            </h1>
          </div>
          <div className="flex gap-4 items-center ml-auto px-3">
            <div>
              <label htmlFor="type" className="sr-only">
                {locale.settings_text_j_type}
              </label>
              <select
                id="type"
                className="bg-[#272727] text-white text-sm p-1 px-8 rounded-sm ring-0 outline-none"
                value={statusBars.type}
                onChange={(event) => {
                  setStatusBars((p) => ({
                    ...p,
                    type: event.target.value as any,
                  }));
                }}
              >
                <option value={""} disabled>
                  {locale.settings_text_j_type}
                </option>
                <option value={1}>{locale.settings_text_type_number}1</option>
                <option value={2}>{locale.settings_text_type_number}2</option>
                <option value={3}>{locale.settings_text_type_number}3</option>
                <option value={4}>{locale.settings_text_type_number}4</option>
              </select>
            </div>
          </div>
        </div>
      </div>
      <div className="mb-2 w-full">
        <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
          <div className="p-3 border-r border-[rgba(217,217,217,0.1)] h-20 flex items-center">
            <img
              src="images/vehicle_hud.svg"
              alt="vehicle-hud"
              className="w-10 h-10"
            />
          </div>
          <div className="px-3">
            <h1 className="font-bold text-base text-white">
              {locale.settings_text_vehicle_hud}
            </h1>
            <h1 className="text-xs font-[inherit] text-[#757575] font-semibold">
              Hide / Show & Type
            </h1>
          </div>
          <div className="flex gap-4 items-center ml-auto px-3">
            <div>
              <label htmlFor="type" className="sr-only">
                {locale.settings_text_j_type}
              </label>
              <select
                id="type"
                className="bg-[#272727] text-white text-sm p-1 px-8 rounded-sm ring-0 outline-none"
                value={vehicleHud.type}
                onChange={(event) => {
                  setVehicleHud((p) => ({
                    ...p,
                    type: event.target.value as any,
                  }));
                }}
              >
                <option value={""} disabled>
                  {locale.settings_text_j_type}
                </option>
                <option value={1}>{locale.settings_text_type_number}1</option>
                <option value={2}>{locale.settings_text_type_number}2</option>
                <option value={3}>{locale.settings_text_type_number}3</option>
              </select>
            </div>
            <div>
              <label className="setting-switch">
                <input
                  type="checkbox"
                  checked={!vehicleHud.hidden}
                  onChange={() => {
                    setVehicleHud((p) => ({
                      ...p,
                      hidden: !p.hidden,
                    }));
                  }}
                />
              </label>
            </div>
          </div>
        </div>
      </div>
      <div className="mb-2 w-full">
        <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
          <div className="p-3 h-20 flex items-center border-r border-[rgba(217,217,217,0.1)]">
            <img
              src="images/health_bar.svg"
              alt="health-bar"
              className="w-10 h-10"
            />
          </div>
          <div className="px-3 py-3">
            <h1 className="font-bold text-base text-white">
              {locale.settings_text_health_icon}
            </h1>
            <h1 className="text-xs font-[inherit] text-[#757575] font-semibold">
              {locale.settings_text_hideWhenMoreThen}
            </h1>
          </div>
          <div className="flex h-20 gap-4 items-center ml-auto px-3 border-l border-[rgba(217,217,217,0.1)] py-3">
            <div className="flex flex-col gap-2">
              <div>
                <label htmlFor="healthiconI" className="sr-only">
                  HealthIcon
                </label>
                <div>
                  <div className="pl-4 bg-[#272727] border border-[#2D2D2D] flex items-center justify-between gap-2">
                    <div>
                      <h1 className="text-[#808080] text-[11px]">
                        {locale.settings_text_never_hide}
                      </h1>
                    </div>
                    <div>
                      <input
                        id="healthiconI"
                        className="w-[56px] font-bold text-center text-[#808080] bg-[#3c3c3c] border border-[#484848] ring-0 outline-none"
                        value={statusBars?.health?.autoHide}
                        onChange={(event) => {
                          setStatusBars((p) => ({
                            ...p,
                            health: {
                              ...p.health,
                              autoHide: parseInt(event.target.value) as number,
                            },
                          }));
                        }}
                        max={100}
                        min={1}
                        type="number"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div>
                <ColorSelector
                  color={statusBars.health.color}
                  handleOnChange={(event) => {
                    setStatusBars((p) => ({
                      ...p,
                      health: {
                        ...p.health,
                        color: event.target.value as HexagonColors,
                      },
                    }));
                  }}
                />
              </div>
            </div>
            <div>
              <label className="setting-switch">
                <input
                  type="checkbox"
                  checked={statusBars.health.active}
                  onChange={() => {
                    setStatusBars((p) => ({
                      ...p,
                      health: {
                        ...p.health,
                        active: !p.health.active,
                      },
                    }));
                  }}
                />
              </label>
            </div>
          </div>
        </div>
      </div>
      <div className="mb-2 w-full">
        <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
          <div className="p-3 h-20 flex items-center border-r border-[rgba(217,217,217,0.1)]">
            <img
              src="images/armor_bar.svg"
              alt="armor-bar"
              className="w-10 h-10"
            />
          </div>
          <div className="px-3 py-3">
            <h1 className="font-bold text-base text-white">
              {locale.settings_text_armor_icon}
            </h1>
            <h1 className="text-xs font-[inherit] text-[#757575] font-semibold">
              {locale.settings_text_hideWhenMoreThen}
            </h1>
          </div>
          <div className="flex h-20 gap-4 items-center ml-auto px-3 border-l border-[rgba(217,217,217,0.1)] py-3">
            <div className="flex flex-col gap-2">
              <div>
                <label htmlFor="armoriconI" className="sr-only">
                  armorIcon
                </label>
                <div>
                  <div className="pl-4 bg-[#272727] border border-[#2D2D2D] flex items-center justify-between gap-2">
                    <div>
                      <h1 className="text-[#808080] text-[11px]">
                        {locale.settings_text_never_hide}
                      </h1>
                    </div>
                    <div>
                      <input
                        id="armoriconI"
                        className="w-[56px] font-bold text-center text-[#808080] bg-[#3c3c3c] border border-[#484848] ring-0 outline-none"
                        value={statusBars?.armor?.autoHide}
                        onChange={(event) => {
                          setStatusBars((p) => ({
                            ...p,
                            armor: {
                              ...p.armor,
                              autoHide: parseInt(event.target.value) as number,
                            },
                          }));
                        }}
                        max={100}
                        min={1}
                        type="number"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div>
                <ColorSelector
                  color={statusBars.armor.color}
                  handleOnChange={(event) => {
                    setStatusBars((p) => ({
                      ...p,
                      armor: {
                        ...p.armor,
                        color: event.target.value as HexagonColors,
                      },
                    }));
                  }}
                />
              </div>
            </div>
            <div>
              <label className="setting-switch">
                <input
                  type="checkbox"
                  checked={statusBars.armor.active}
                  onChange={() => {
                    setStatusBars((p) => ({
                      ...p,
                      armor: {
                        ...p.armor,
                        active: !p.armor.active,
                      },
                    }));
                  }}
                />
              </label>
            </div>
          </div>
        </div>
      </div>
      <div className="mb-2 w-full">
        <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
          <div className="p-3 h-20 flex items-center border-r border-[rgba(217,217,217,0.1)]">
            <img
              src="images/hunger_bar.svg"
              alt="hunger-bar"
              className="w-10 h-10"
            />
          </div>
          <div className="px-3 py-3">
            <h1 className="font-bold text-base text-white">
              {locale.settings_text_hunger_icon}
            </h1>
            <h1 className="text-xs font-[inherit] text-[#757575] font-semibold">
              {locale.settings_text_hideWhenMoreThen}
            </h1>
          </div>
          <div className="flex h-20 gap-4 items-center ml-auto px-3 border-l border-[rgba(217,217,217,0.1)] py-3">
            <div className="flex flex-col gap-2">
              <div>
                <label htmlFor="hungericonI" className="sr-only">
                  hungerIcon
                </label>
                <div>
                  <div className="pl-4 bg-[#272727] border border-[#2D2D2D] flex items-center justify-between gap-2">
                    <div>
                      <h1 className="text-[#808080] text-[11px]">
                        {locale.settings_text_never_hide}
                      </h1>
                    </div>
                    <div>
                      <input
                        id="hungericonI"
                        className="w-[56px] font-bold text-center text-[#808080] bg-[#3c3c3c] border border-[#484848] ring-0 outline-none"
                        value={statusBars?.hunger?.autoHide}
                        onChange={(event) => {
                          setStatusBars((p) => ({
                            ...p,
                            hunger: {
                              ...p.hunger,
                              autoHide: parseInt(event.target.value) as number,
                            },
                          }));
                        }}
                        max={100}
                        min={1}
                        type="number"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div>
                <ColorSelector
                  color={statusBars.hunger.color}
                  handleOnChange={(event) => {
                    setStatusBars((p) => ({
                      ...p,
                      hunger: {
                        ...p.hunger,
                        color: event.target.value as HexagonColors,
                      },
                    }));
                  }}
                />
              </div>
            </div>
            <div>
              <label className="setting-switch">
                <input
                  type="checkbox"
                  checked={statusBars.hunger.active}
                  onChange={() => {
                    setStatusBars((p) => ({
                      ...p,
                      hunger: {
                        ...p.hunger,
                        active: !p.hunger.active,
                      },
                    }));
                  }}
                />
              </label>
            </div>
          </div>
        </div>
      </div>
      <div className="mb-2 w-full">
        <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
          <div className="p-3 h-20 flex items-center border-r border-[rgba(217,217,217,0.1)]">
            <img
              src="images/thirst_bar.svg"
              alt="thirst-bar"
              className="w-10 h-10"
            />
          </div>
          <div className="px-3 py-3">
            <h1 className="font-bold text-base text-white">
              {locale.settings_text_thirst_icon}
            </h1>
            <h1 className="text-xs font-[inherit] text-[#757575] font-semibold">
              {locale.settings_text_hideWhenMoreThen}
            </h1>
          </div>
          <div className="flex h-20 gap-4 items-center ml-auto px-3 border-l border-[rgba(217,217,217,0.1)] py-3">
            <div className="flex flex-col gap-2">
              <div>
                <label htmlFor="thirsticonI" className="sr-only">
                  thirstIcon
                </label>
                <div>
                  <div className="pl-4 bg-[#272727] border border-[#2D2D2D] flex items-center justify-between gap-2">
                    <div>
                      <h1 className="text-[#808080] text-[11px]">
                        {locale.settings_text_never_hide}
                      </h1>
                    </div>
                    <div>
                      <input
                        id="thirsticonI"
                        className="w-[56px] font-bold text-center text-[#808080] bg-[#3c3c3c] border border-[#484848] ring-0 outline-none"
                        value={statusBars?.thirst?.autoHide}
                        onChange={(event) => {
                          setStatusBars((p) => ({
                            ...p,
                            thirst: {
                              ...p.thirst,
                              autoHide: parseInt(event.target.value) as number,
                            },
                          }));
                        }}
                        max={100}
                        min={1}
                        type="number"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div>
                <ColorSelector
                  color={statusBars.thirst.color}
                  handleOnChange={(event) => {
                    setStatusBars((p) => ({
                      ...p,
                      thirst: {
                        ...p.thirst,
                        color: event.target.value as HexagonColors,
                      },
                    }));
                  }}
                />
              </div>
            </div>
            <div>
              <label className="setting-switch">
                <input
                  type="checkbox"
                  checked={statusBars.thirst.active}
                  onChange={() => {
                    setStatusBars((p) => ({
                      ...p,
                      thirst: {
                        ...p.thirst,
                        active: !p.thirst.active,
                      },
                    }));
                  }}
                />
              </label>
            </div>
          </div>
        </div>
      </div>
      <div className="mb-2 w-full">
        <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
          <div className="p-3 h-20 flex items-center border-r border-[rgba(217,217,217,0.1)]">
            <img
              src="images/custom_bar.svg"
              alt="oxygen-bar"
              className="w-10 h-10"
            />
          </div>
          <div className="px-3 py-3">
            <h1 className="font-bold text-base text-white">
              {locale.settings_text_oxygen_icon}
            </h1>
            <h1 className="text-xs font-[inherit] text-[#757575] font-semibold">
              {locale.settings_text_hideWhenMoreThen}
            </h1>
          </div>
          <div className="flex h-20 gap-4 items-center ml-auto px-3 border-l border-[rgba(217,217,217,0.1)] py-3">
            <div className="flex flex-col gap-2">
              <div>
                <label htmlFor="oxygeniconI" className="sr-only">
                  oxygenIcon
                </label>
                <div>
                  <div className="pl-4 bg-[#272727] border border-[#2D2D2D] flex items-center justify-between gap-2">
                    <div>
                      <h1 className="text-[#808080] text-[11px]">
                        {locale.settings_text_never_hide}
                      </h1>
                    </div>
                    <div>
                      <input
                        id="oxygeniconI"
                        className="w-[56px] font-bold text-center text-[#808080] bg-[#3c3c3c] border border-[#484848] ring-0 outline-none"
                        value={statusBars?.oxygen?.autoHide}
                        onChange={(event) => {
                          setStatusBars((p) => ({
                            ...p,
                            oxygen: {
                              ...p.oxygen,
                              autoHide: parseInt(event.target.value) as number,
                            },
                          }));
                        }}
                        max={100}
                        min={1}
                        type="number"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div>
                <ColorSelector
                  color={statusBars.oxygen.color}
                  handleOnChange={(event) => {
                    setStatusBars((p) => ({
                      ...p,
                      oxygen: {
                        ...p.oxygen,
                        color: event.target.value as HexagonColors,
                      },
                    }));
                  }}
                />
              </div>
            </div>
            <div>
              <label className="setting-switch">
                <input
                  type="checkbox"
                  checked={statusBars.oxygen.active}
                  onChange={() => {
                    setStatusBars((p) => ({
                      ...p,
                      oxygen: {
                        ...p.oxygen,
                        active: !p.oxygen.active,
                      },
                    }));
                  }}
                />
              </label>
            </div>
          </div>
        </div>
      </div>
      <div className="mb-2 w-full">
        <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
          <div className="p-3 h-20 flex items-center border-r border-[rgba(217,217,217,0.1)]">
            <img
              src="images/custom_bar.svg"
              alt="stamina-bar"
              className="w-10 h-10"
            />
          </div>
          <div className="px-3 py-3">
            <h1 className="font-bold text-base text-white">
              {locale.settings_text_stamina_icon}
            </h1>
            <h1 className="text-xs font-[inherit] text-[#757575] font-semibold">
              {locale.settings_text_hideWhenMoreThen}
            </h1>
          </div>
          <div className="flex h-20 gap-4 items-center ml-auto px-3 border-l border-[rgba(217,217,217,0.1)] py-3">
            <div className="flex flex-col gap-2">
              <div>
                <label htmlFor="staminaiconI" className="sr-only">
                  staminaIcon
                </label>
                <div>
                  <div className="pl-4 bg-[#272727] border border-[#2D2D2D] flex items-center justify-between gap-2">
                    <div>
                      <h1 className="text-[#808080] text-[11px]">
                        {locale.settings_text_never_hide}
                      </h1>
                    </div>
                    <div>
                      <input
                        id="staminaiconI"
                        className="w-[56px] font-bold text-center text-[#808080] bg-[#3c3c3c] border border-[#484848] ring-0 outline-none"
                        value={statusBars?.stamina?.autoHide}
                        onChange={(event) => {
                          setStatusBars((p) => ({
                            ...p,
                            stamina: {
                              ...p.stamina,
                              autoHide: parseInt(event.target.value) as number,
                            },
                          }));
                        }}
                        max={100}
                        min={1}
                        type="number"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div>
                <ColorSelector
                  color={statusBars.stamina.color}
                  handleOnChange={(event) => {
                    setStatusBars((p) => ({
                      ...p,
                      stamina: {
                        ...p.stamina,
                        color: event.target.value as HexagonColors,
                      },
                    }));
                  }}
                />
              </div>
            </div>
            <div>
              <label className="setting-switch">
                <input
                  type="checkbox"
                  checked={statusBars.stamina.active}
                  onChange={() => {
                    setStatusBars((p) => ({
                      ...p,
                      stamina: {
                        ...p.stamina,
                        active: !p.stamina.active,
                      },
                    }));
                  }}
                />
              </label>
            </div>
          </div>
        </div>
      </div>
      <div className="mb-2 w-full">
        <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
          <div className="p-3 h-20 flex items-center border-r border-[rgba(217,217,217,0.1)]">
            <img
              src="images/custom_bar.svg"
              alt="stress-bar"
              className="w-10 h-10"
            />
          </div>
          <div className="px-3 py-3">
            <h1 className="font-bold text-base text-white">
              {locale.settings_text_stress_icon}
            </h1>
            <h1 className="text-xs font-[inherit] text-[#757575] font-semibold">
              {locale.settings_text_hideWhenMoreThen}
            </h1>
          </div>
          <div className="flex h-20 gap-4 items-center ml-auto px-3 border-l border-[rgba(217,217,217,0.1)] py-3">
            <div className="flex flex-col gap-2">
              <div>
                <label htmlFor="stressiconI" className="sr-only">
                  stressIcon
                </label>
                <div>
                  <div className="pl-4 bg-[#272727] border border-[#2D2D2D] flex items-center justify-between gap-2">
                    <div>
                      <h1 className="text-[#808080] text-[11px]">
                        {locale.settings_text_never_hide}
                      </h1>
                    </div>
                    <div>
                      <input
                        id="stressiconI"
                        className="w-[56px] font-bold text-center text-[#808080] bg-[#3c3c3c] border border-[#484848] ring-0 outline-none"
                        value={statusBars?.stress?.autoHide}
                        onChange={(event) => {
                          setStatusBars((p) => ({
                            ...p,
                            stress: {
                              ...p.stress,
                              autoHide: parseInt(event.target.value) as number,
                            },
                          }));
                        }}
                        max={100}
                        min={1}
                        type="number"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div>
                <ColorSelector
                  color={statusBars.stress.color}
                  handleOnChange={(event) => {
                    setStatusBars((p) => ({
                      ...p,
                      stress: {
                        ...p.stress,
                        color: event.target.value as HexagonColors,
                      },
                    }));
                  }}
                />
              </div>
            </div>
            <div>
              <label className="setting-switch">
                <input
                  type="checkbox"
                  checked={statusBars.stress.active}
                  onChange={() => {
                    setStatusBars((p) => ({
                      ...p,
                      stress: {
                        ...p.stress,
                        active: !p.stress.active,
                      },
                    }));
                  }}
                />
              </label>
            </div>
          </div>
        </div>
      </div>
      <div className="mb-2 w-full">
        <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
          <div className="p-3 h-20 flex items-center border-r border-[rgba(217,217,217,0.1)]">
            <img
              src="images/custom_bar.svg"
              alt="terminal-bar"
              className="w-10 h-10"
            />
          </div>
          <div className="px-3 py-3">
            <h1 className="font-bold text-base text-white">
              {locale.settings_text_terminal_icon}
            </h1>
            <h1 className="text-xs font-[inherit] text-[#757575] font-semibold">
              {locale.settings_text_hideWhenMoreThen}
            </h1>
          </div>
          <div className="flex h-20 gap-4 items-center ml-auto px-3 border-l border-[rgba(217,217,217,0.1)] py-3">
            <div className="flex flex-col gap-2">
              <div>
                <label htmlFor="terminaliconI" className="sr-only">
                  terminalIcon
                </label>
                <div>
                  <div className="pl-4 bg-[#272727] border border-[#2D2D2D] flex items-center justify-between gap-2">
                    <div>
                      <h1 className="text-[#808080] text-[11px]">
                        {locale.settings_text_never_hide}
                      </h1>
                    </div>
                    <div>
                      <input
                        id="terminaliconI"
                        className="w-[56px] font-bold text-center text-[#808080] bg-[#3c3c3c] border border-[#484848] ring-0 outline-none"
                        value={statusBars?.terminal?.autoHide}
                        onChange={(event) => {
                          setStatusBars((p) => ({
                            ...p,
                            terminal: {
                              ...p.terminal,
                              autoHide: parseInt(event.target.value) as number,
                            },
                          }));
                        }}
                        max={100}
                        min={1}
                        type="number"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div>
                <ColorSelector
                  color={statusBars.terminal.color}
                  handleOnChange={(event) => {
                    setStatusBars((p) => ({
                      ...p,
                      terminal: {
                        ...p.terminal,
                        color: event.target.value as HexagonColors,
                      },
                    }));
                  }}
                />
              </div>
            </div>
            <div>
              <label className="setting-switch">
                <input
                  type="checkbox"
                  checked={statusBars.terminal.active}
                  onChange={() => {
                    setStatusBars((p) => ({
                      ...p,
                      terminal: {
                        ...p.terminal,
                        active: !p.terminal.active,
                      },
                    }));
                  }}
                />
              </label>
            </div>
          </div>
        </div>
      </div>
      <div className="mb-2 w-full">
        <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
          <div className="p-3 h-20 flex items-center border-r border-[rgba(217,217,217,0.1)]">
            <img
              src="images/custom_bar.svg"
              alt="leaf-bar"
              className="w-10 h-10"
            />
          </div>
          <div className="px-3 py-3">
            <h1 className="font-bold text-base text-white">
              {locale.settings_text_leaf_icon}
            </h1>
            <h1 className="text-xs font-[inherit] text-[#757575] font-semibold">
              {locale.settings_text_hideWhenMoreThen}
            </h1>
          </div>
          <div className="flex h-20 gap-4 items-center ml-auto px-3 border-l border-[rgba(217,217,217,0.1)] py-3">
            <div className="flex flex-col gap-2">
              <div>
                <label htmlFor="leaficonI" className="sr-only">
                  leafIcon
                </label>
                <div>
                  <div className="pl-4 bg-[#272727] border border-[#2D2D2D] flex items-center justify-between gap-2">
                    <div>
                      <h1 className="text-[#808080] text-[11px]">
                        {locale.settings_text_never_hide}
                      </h1>
                    </div>
                    <div>
                      <input
                        id="leaficonI"
                        className="w-[56px] font-bold text-center text-[#808080] bg-[#3c3c3c] border border-[#484848] ring-0 outline-none"
                        value={statusBars?.leaf?.autoHide}
                        onChange={(event) => {
                          setStatusBars((p) => ({
                            ...p,
                            leaf: {
                              ...p.leaf,
                              autoHide: parseInt(event.target.value) as number,
                            },
                          }));
                        }}
                        max={100}
                        min={1}
                        type="number"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div>
                <ColorSelector
                  color={statusBars.leaf.color}
                  handleOnChange={(event) => {
                    setStatusBars((p) => ({
                      ...p,
                      leaf: {
                        ...p.leaf,
                        color: event.target.value as HexagonColors,
                      },
                    }));
                  }}
                />
              </div>
            </div>
            <div>
              <label className="setting-switch">
                <input
                  type="checkbox"
                  checked={statusBars.leaf.active}
                  onChange={() => {
                    setStatusBars((p) => ({
                      ...p,
                      leaf: {
                        ...p.leaf,
                        active: !p.leaf.active,
                      },
                    }));
                  }}
                />
              </label>
            </div>
          </div>
        </div>
      </div>
      {vehicleHud.manualModeType && (
        <div className="mb-2 w-full">
          <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
            <div className="p-3 h-20 flex items-center border-r border-[rgba(217,217,217,0.1)]">
              <img
                src="images/gear_setting.svg"
                alt="gear-mode"
                className="w-10 h-10"
              />
            </div>
            <div className="px-3 py-3">
              <h1 className="font-bold text-base text-white">
                {locale.settings_text_vehicle_mode}
              </h1>
            </div>
            <div className="flex items-center h-20 gap-2 ml-auto px-3 border-l border-[rgba(217,217,217,0.1)] py-3">
              <div>
                <label htmlFor="minimapstyle" className="sr-only">
                  {locale.settings_text_minimap_style}
                </label>
                <select
                  id="minimapstyle"
                  className="bg-[#272727] text-white text-sm p-1 px-2 rounded-sm ring-0 outline-none"
                  value={vehicleHud.manualMode ? 1 : 0}
                  onChange={(event) => {
                    setVehicleHud((p) => ({
                      ...p,
                      manualMode:
                        (event.target.value as any) == 1 ? true : false,
                    }));
                    fetchNui(
                      "OnGearModeChanged",
                      (event.target.value as any) == 1 ? true : false
                    );
                  }}
                >
                  <option value={""} disabled>
                    Mode
                  </option>
                  <option value={1}>{locale.settings_text_manual_mode}</option>
                  <option value={0}>{locale.settings_text_oto_mode}</option>
                </select>
              </div>
            </div>
          </div>
        </div>
      )}
      <div className="mb-2 w-full">
        <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
          <div className="p-3 h-20 flex items-center border-r border-[rgba(217,217,217,0.1)]">
            <img
              src="images/custom_bar.svg"
              alt="compass-bar"
              className="w-10 h-10"
            />
          </div>
          <div className="px-3 py-3">
            <h1 className="font-bold text-base text-white">
              {locale.settings_text_compass_hud}
            </h1>
          </div>
          <div className="flex h-20 gap-4 items-center ml-auto px-3 border-l border-[rgba(217,217,217,0.1)] py-3">
            <div>
              <label className="setting-switch">
                <input
                  type="checkbox"
                  checked={compassHud.show}
                  onChange={() => {
                    setCompassHud((p) => ({
                      ...p,
                      show: !p.show,
                    }));
                  }}
                />
              </label>
            </div>
          </div>
        </div>
      </div>
      <div className="mb-2 w-full">
        <div className="flex justify-start items-center bg-setting/80 rounded-md h-20">
          <div className="p-3 h-20 flex items-center border-r border-[rgba(217,217,217,0.1)]">
            <img
              src="images/vehicle_hud.svg"
              alt="vehicle_hud-position"
              className="w-10 h-10"
            />
          </div>
          <div className="px-3 py-3">
            <h1 className="font-bold text-base text-white">
              {locale.settings_text_vehicle_position}
            </h1>
          </div>
          <div className="flex items-center h-20 gap-2 ml-auto px-3 border-l border-[rgba(217,217,217,0.1)] py-3">
            <div>
              <label htmlFor="vehicleHudPositionB" className="sr-only">
                vehicleHudPositionB
              </label>
              <div>
                <div className="pl-4 bg-[#272727] border border-[#2D2D2D] flex items-center justify-between gap-2">
                  <div>
                    <h1 className="text-[#808080] text-[11px]">
                      + Bottom (px):
                    </h1>
                  </div>
                  <div>
                    <input
                      id="vehicleHudPositionB"
                      className="w-[56px] font-bold text-center text-[#808080] bg-[#3c3c3c] border border-[#484848] ring-0 outline-none"
                      value={vehicleHud?.position?.bottom}
                      onChange={(event) => {
                        setVehicleHud((p) => ({
                          ...p,
                          position: {
                            ...p.position,
                            bottom: parseInt(event.target.value),
                          },
                        }));
                      }}
                      type="number"
                    />
                  </div>
                </div>
              </div>
            </div>
            <div>
              <label htmlFor="vehicleHudPositionL" className="sr-only">
                vehicleHudPositionL
              </label>
              <div>
                <div className="pl-4 bg-[#272727] border border-[#2D2D2D] flex items-center justify-between gap-2">
                  <div>
                    <h1 className="text-[#808080] text-[11px]">+ Left (px):</h1>
                  </div>
                  <div>
                    <input
                      id="vehicleHudPositionL"
                      className="w-[56px] font-bold text-center text-[#808080] bg-[#3c3c3c] border border-[#484848] ring-0 outline-none"
                      value={vehicleHud?.position?.left}
                      onChange={(event) => {
                        setVehicleHud((p) => ({
                          ...p,
                          position: {
                            ...p.position,
                            left: parseInt(event.target.value),
                          },
                        }));
                      }}
                      type="number"
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
