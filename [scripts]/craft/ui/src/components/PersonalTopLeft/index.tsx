import classNames from "classnames";
import useData from "../../hooks/useData";
import { whichColor } from "../../utils/misc";
import useLocales from "../../hooks/useLocales";

export const PersonalTopLeft: React.FC = () => {
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
            {locale.text_your_guns}
          </h1>
          <h1 className="whitespace-pre-wrap text-[#9E9E9E] text-[9px] uppercase font-Akira">
            {locale.text_modifiable_items_inventory}
          </h1>
        </div>
      </div>
    </>
  );
};
