import classNames from "classnames";
import { whichColor } from "../../utils/misc";
import useData from "../../hooks/useData";
import useLocales from "../../hooks/useLocales";

export const CraftingTopLeft: React.FC = () => {
  const { themeColor } = useData();
  const { locale } = useLocales();

  const getWeaponIcon = (): string => {
    switch (themeColor) {
      case "_green":
        return "images/green_wbag.svg";
      case "_orange":
        return "images/orange_wbag.svg";
      case "_red":
        return "images/red_wbag.svg";
      case "_blue":
        return "images/blue_wbag.svg";
      default:
        return "images/orange_wbag.svg";
    }
  };

  return (
    <>
      <div className="flex items-center gap-3">
        <div>
          <img
            className={classNames(
              "shrink-0",
              whichColor(themeColor, "text"),
              whichColor(themeColor, "drop-shadow")
            )}
            src={getWeaponIcon()}
            alt="theme_wbag_icon"
          />
        </div>
        <div>
          <h1
            className={classNames(
              "mb-0.5 uppercase text-xl font-Akira",
              whichColor(themeColor, "text")
            )}
          >
            {locale.text_createable_items}
          </h1>
          <h1 className="whitespace-pre-wrap text-[#9E9E9E] text-[9px] uppercase font-Akira">
            {locale.text_createable_items}
          </h1>
        </div>
      </div>
    </>
  );
};
