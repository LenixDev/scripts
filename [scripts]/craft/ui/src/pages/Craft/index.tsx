import classNames from "classnames";
import useData from "../../hooks/useData";
import { whichColor } from "../../utils/misc";
import "./index.sass";
import { MenuProps } from "../../types/BasicTypes";
import { HR } from "../../components/HR";
import { PersonalTopLeft } from "../../components/PersonalTopLeft";
import { CraftingTopLeft } from "../../components/CraftingTopLeft";
import { PersonalTopRight } from "../../components/PersonalTopRight";
import { CraftingTopRight } from "../../components/CraftingTopRight";
import { PersonalInventory } from "../../components/PersonalInventory";
import { CraftingInventory } from "../../components/CraftingInventory";
import { CraftingQueue } from "../../components/CraftingQueue";
import { PersonalMiddle } from "../../components/PersonalMiddle";
import { CraftingMiddle } from "../../components/CraftingMiddle";
import { PersonalBottom } from "../../components/PersonalBottom";
import { CraftingBottom } from "../../components/CraftingBottom";
import { CraftingIngredients } from "../../components/CraftingIngredients";
import useLocales from "../../hooks/useLocales";

const Craft = () => {
  const { themeColor, activeMenu, changeActivePage } = useData();
  const { locale } = useLocales();

  const handleChangePage = (menu: MenuProps) => {
    changeActivePage(menu);
  };

  return (
    <>
      <div className="px-8 py-11 h-full flex flex-col">
        <div className="w-full flex justify-between">
          <div className="w-[380px] flex flex-col justify-between">
            {activeMenu == "personal" && <PersonalTopLeft />}
            {activeMenu == "crafting" && <CraftingTopLeft />}
            <div className="mt-6">
              <HR />
            </div>
          </div>
          <div className="flex flex-col justify-between">
            <div>
              <h1 className="text-xl uppercase font-Akira text-white text-center">
                {locale.text_crafting_table}
              </h1>
            </div>
            <div className="flex items-center gap-8">
              <div>
                <button
                  className={classNames("relative group")}
                  onClick={() => handleChangePage("personal")}
                >
                  <div
                    className={classNames(
                      "absolute w-2 h-7 -left-[7.7px] half-hexagon",
                      {
                        "group-hover:bg-white": activeMenu == "crafting",
                        [whichColor(themeColor, "hover:background")]:
                          activeMenu === "crafting",
                        [whichColor(themeColor, "background")]:
                          activeMenu === "personal",
                        "bg-white": activeMenu == "crafting",
                      }
                    )}
                  />
                  <h1
                    className={classNames(
                      "font-Akira text-[10px] border-2 h-7 pt-0.5 flex items-center px-3",
                      {
                        ["text-white"]: activeMenu === "crafting",
                        ["border-white"]: activeMenu === "crafting",
                        "bg-black/80": activeMenu == "crafting",
                        [whichColor("_181818", "background-linear")]:
                          activeMenu === "crafting",
                        [whichColor(themeColor, "text")]:
                          activeMenu === "personal",
                        [whichColor(themeColor, "border")]:
                          activeMenu === "personal",
                      }
                    )}
                  >
                    {locale.text_personal}
                  </h1>
                </button>
              </div>
              <div>
                <h1 className="text-[10px] font-Akira text-[#dedede]">
                  {locale.text_crafting_table_desc}
                </h1>
              </div>
              <div>
                <button
                  className={classNames("relative group")}
                  onClick={() => handleChangePage("crafting")}
                >
                  <h1
                    className={classNames(
                      "font-Akira text-[10px] border-2 h-7 pt-0.5 flex items-center px-3",
                      {
                        ["text-white"]: activeMenu === "personal",
                        "border-white": activeMenu === "personal",
                        "bg-black/80": activeMenu == "personal",
                        [whichColor("_181818", "background-linear")]:
                          activeMenu === "personal",
                        [whichColor(themeColor, "text")]:
                          activeMenu === "crafting",
                        [whichColor(themeColor, "border")]:
                          activeMenu === "crafting",
                      }
                    )}
                  >
                    {locale.text_crafting}
                  </h1>
                  <div
                    className={classNames(
                      "absolute w-2 h-7 -right-[7px] top-0 half-hexagon rotate-180",
                      {
                        "group-hover:bg-white": activeMenu == "personal",
                        [whichColor(themeColor, "hover:background")]:
                          activeMenu === "personal",
                        [whichColor(themeColor, "background")]:
                          activeMenu === "crafting",
                        "bg-white": activeMenu == "personal",
                      }
                    )}
                  />
                </button>
              </div>
            </div>
            <div className="mt-6">
              <HR />
            </div>
          </div>
          <div className="w-[380px] flex flex-col justify-between">
            {activeMenu == "personal" && <PersonalTopRight />}
            {activeMenu == "crafting" && <CraftingTopRight />}
            <div className="mt-6">
              <HR />
            </div>
          </div>
        </div>
        <div className="w-full flex justify-between h-full relative">
          <div className="w-[380px] flex justify-start z-10" id="l">
            {activeMenu == "personal" && <PersonalInventory type="gun" />}
            {activeMenu == "crafting" && <CraftingInventory />}
          </div>
          <div className="w-full h-full" id="m">
            {activeMenu == "personal" && <PersonalMiddle />}
            {activeMenu == "crafting" && <CraftingMiddle />}
          </div>
          <div
            className="max-w-[380px] w-full flex flex-col items-end z-10"
            id="r"
          >
            {activeMenu == "personal" && (
              <PersonalInventory type="attachments" />
            )}
            {activeMenu == "crafting" && <CraftingQueue />}
            {activeMenu == "crafting" && <CraftingIngredients />}
          </div>
        </div>
        <div className="w-full mt-auto">
          {activeMenu == "personal" && <PersonalBottom />}
          {activeMenu == "crafting" && <CraftingBottom />}
        </div>
      </div>
      <div className="absolute w-full h-full top-0 left-0 -z-50 bg-openedTable"></div>
    </>
  );
};
export default Craft;
